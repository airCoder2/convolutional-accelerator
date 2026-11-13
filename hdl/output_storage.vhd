----------------------------------------------------------------------------------
-- Output Storage Unit
--
-- Gregory Ling, 2024
----------------------------------------------------------------------------------

library work;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity output_storage is
    generic(
        DATA_WIDTH : integer := 32;
        BRAM_DATA_WIDTH : integer := 32;
        ADDR_WIDTH : integer := 32;
        BRAM_ADDR_WIDTH : integer := 32;
        DIM_WIDTH : integer := 8;
        C_TID_WIDTH : integer := 1
    );
    port(
        S_AXIS_TREADY : out std_logic;
        S_AXIS_TDATA  : in  std_logic_vector(DATA_WIDTH-1 downto 0);
        S_AXIS_TLAST  : in  std_logic; -- always 1
        S_AXIS_TID    : in  std_logic_vector(C_TID_WIDTH-1 downto 0);
        S_AXIS_TVALID : in  std_logic;

        BRAM_addr : out std_logic_vector(32-1 downto 0); -- addres
        BRAM_din : out std_logic_vector(BRAM_DATA_WIDTH-1 downto 0);
        BRAM_dout : in std_logic_vector(BRAM_DATA_WIDTH-1 downto 0);
        BRAM_en : out std_logic;
        BRAM_we : out std_logic_vector((BRAM_DATA_WIDTH/8)-1 downto 0);
        BRAM_rst : out std_logic;
        BRAM_clk : out std_logic;

        max_pooling : in std_logic;
        elements_per_channel : in std_logic_vector(ADDR_WIDTH-1 downto 0);
        output_w : in std_logic_vector(DIM_WIDTH-1 downto 0);
        output_h : in std_logic_vector(DIM_WIDTH-1 downto 0);
        initial_offset : in std_logic_vector(ADDR_WIDTH-1 downto 0);
        
        conv_complete : out std_logic;
        conv_idle : in std_logic;
        clk : in std_logic;
        rst : in std_logic
    );
end output_storage;

architecture Behavioral of output_storage is

    -- initial offset is really 4 * o_h * o_w * (how_many_4pair_channels_computed)
    -- so if we already computed the first, 4 (assuming our oh and ow were both 2),
    -- our initial offset would be 4 * 2 * 2 * 1 = 16. Which means, we would start
    -- storing the output starting from index 16, since previous 4 channels are stored
    -- in indecies up to 16. But we keep track of it in software not hardware.
    -- TLDR: just add whatever you is in initial offset to address


    -- ANOTHER MD: soo when conv_idle is 1, reste the whole thing. conv_idle turn on
    -- every time we are done computing a set of output channels, (4 in this case)
    -- and each time we have to reset the registers we use to keep track of indexes


    -- Since we get TLAST each cycle, it is not useful to see if we should increment the 

    type state_type is (IDLE, READ, WRITE);
    signal current_state, next_state : state_type;

    signal s_ow : unsigned(DIM_WIDTH-1 downto 0);
    signal s_oh : unsigned(DIM_WIDTH-1 downto 0);
    signal s_output_idx : unsigned(DIM_WIDTH-1 downto 0);

    signal s_tid  :  std_logic_vector(C_TID_WIDTH-1 downto 0); -- latched tid
    signal s_data :  std_logic_vector(DATA_WIDTH-1 downto 0);  -- latched tdata

begin

    BRAM_clk <= clk;
    BRAM_rst <= '0';


    -- combinational next state logic
    process(all)
    begin
        next_state    <= state;
        S_AXIS_TREADY <= '0';
        BRAM_we <= (others => '0'); -- normally we are not writing to bram
        BRAM_en  <= '1';

        case current_state is
            when IDLE =>
                S_AXIS_TREADY   <= '1';
                BRAM_en  <= '0';
                if S_AXIS_TVALID = '1' then
                    next_state <= READ;
                end if;

            when READ =>
                S_AXIS_TREADY <= '0';
                -- we are just adding s_output_idx rather than leaving out the last 2 bits, because BRAM is set to byte supporting mode
                BRAM_addr  <= unsigned(initial_offset) + unsigned(S_AXIS_TID) * unsigned(elements_per_channel) + s_output_idx;
                                           
                next_state <= WRITE;

            when WRITE =>
                -- since we are writing the entire thing back, we can safely put all of them to 1
                BRAM_we <= "1111";
                BRAM_addr  <= unsigned(initial_offset) + unsigned(S_AXIS_TID) * unsigned(elements_per_channel) + s_output_idx;
                with s_output_idx(1 downto 0) select
                    BRAM_dout <= BRAM_din(31 downto 8) & s_data when "00",
                                 BRAM_din(31 downto 16) & s_data & BRAM_din(7 downto 0) when "01",
                                 BRAM_din(31 downto 24) & s_data & BRAM_din(15 downto 0) when "10",
                                 s_data & BRAM_din(24 downto 0) when others;

                next_state <= IDLE;

        end case;
    end process;

    -- synchronous state updates and transtion actions
    process(clk)
    begin
        if rising_edge(clk) then
            if (rst = '0' or conv_idle = '1') then
                s_ow <= (others => '0');        
                s_oh <= (others => '0');        

                s_output_idx  <= (others => '0');

                s_tid  <= (others => '0');
                s_data <= (others => '0');
                current_state    <= IDLE;

                BRAM_rst <= '1';
            else
                -- Update state register
                current_state <= next_state;

                -- Action on ACCEPT -> BUSY transition (Handshake edge)
                if (state = IDLE and next_state = READ) then
                    s_data <= S_AXIS_TDATA;
                    s_tid  <= S_AXIS_TID;
                end if;

                -- Action on BUSY -> IDLE transition (Count increments once)
                if (state = WRITE and next_state = IDLE and s_tid = "11") then
                    s_ow <= s_ow + 1;
                    s_output_idx <= s_output_idx + 1; 

                    if(s_ow = unsigned(output_w) - 1) then
                        s_ow <= 0;
                        s_oh <= s_oh + 1;
                        if(max_pooling = '1' and s_oh(0) = '0') then -- if max pooling and s_oh is even then roll back the index
                            s_output_idx <= s_output_idx - unsigned(output_w) - 1; -- get us to the beginning of the row

                        end if;
                    end if;
                end if;
            end if;
        end if;
    end process;


end Behavioral;
