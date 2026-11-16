----------------------------------------------------------------------------------
-- Output Storage Unit
--
-- Salah Nasriddinov
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

    signal output_storage_debug_BRAM_addr : std_logic_vector(32-1 downto 0);
    -- low 2 bits of BRAM_addr are constant 0 (word aligned); synthesis would strip them and the ILA
    -- can't probe a constant. Route them through a kept flop so they show up as real nets.
    -- Same for bits 31:19: the BD only wires the lower 19 bits to the BRAM controller, so these have no load
    -- and get removed. A kept flop gives them a load and a clock domain.
    signal s_debug_addr_low  : std_logic_vector(1 downto 0)  := "11";
    signal s_debug_addr_high : std_logic_vector(31 downto 19) := (others => '1');
    attribute dont_touch : string;
    attribute dont_touch of s_debug_addr_low  : signal is "true";
    attribute dont_touch of s_debug_addr_high : signal is "true";
    signal output_storage_debug_BRAM_din  : std_logic_vector(BRAM_DATA_WIDTH-1 downto 0);
    signal output_storage_debug_BRAM_we   : std_logic_vector((BRAM_DATA_WIDTH/8)-1 downto 0);

    attribute mark_debug : string;
    attribute mark_debug of output_storage_debug_BRAM_addr : signal is "true";
    attribute mark_debug of output_storage_debug_BRAM_din  : signal is "true";
    attribute mark_debug of output_storage_debug_BRAM_we   : signal is "true";

begin

    -- debug signals
    output_storage_debug_BRAM_addr <= s_debug_addr_high & BRAM_addr(18 downto 2) & s_debug_addr_low;

    process(clk)
    begin
        if rising_edge(clk) then
            s_debug_addr_low  <= BRAM_addr(1 downto 0);
            s_debug_addr_high <= BRAM_addr(31 downto 19);
        end if;
    end process;
    output_storage_debug_BRAM_din  <= BRAM_din;
    output_storage_debug_BRAM_we   <= BRAM_we;

    BRAM_clk <= clk;

    -- combinational next state logic
    process(all)

        variable BRAM_byte_addr : std_logic_vector(31 downto 0);

    begin
        next_state    <= IDLE;
        S_AXIS_TREADY <= '0';
        BRAM_we <= (others => '0'); -- normally we are not writing to bram
        BRAM_en  <= '1';
        BRAM_addr <= (others => '0');
        BRAM_din <= (others => '0');


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
                if (max_pooling = '0') then

                    -- this is the address in bytes
                    BRAM_byte_addr := std_logic_vector(resize(unsigned(s_tid) * unsigned(elements_per_channel) + 
                                      s_output_idx + unsigned(initial_offset), BRAM_byte_addr'length));

                    -- the way that the testbench wants me to output stuff
                    -- it wants address to be the first byte of the word that I am trying to acess
                    BRAM_addr  <= BRAM_byte_addr(31 downto 2) & 0b"00"; 

                    --BRAM_addr  <= std_logic_vector(resize(unsigned(s_tid) * unsigned(elements_per_channel) + 
                    --              s_output_idx(DIM_WIDTH-1 downto 2) + unsigned(initial_offset), BRAM_addr'length));
                else
                    BRAM_byte_addr  := std_logic_vector(resize(unsigned(s_tid) * unsigned(elements_per_channel) + 
                                       s_output_idx(DIM_WIDTH-1 downto 1) + unsigned(initial_offset), BRAM_addr'length));
                    BRAM_addr  <= BRAM_byte_addr(31 downto 2) & 0b"00"; 
                end if;
                                           
                next_state <= WRITE;

            when WRITE =>
                -- since we are writing the entire thing back, we can safely put all of them to 1
                BRAM_we <= "1111";

                if (max_pooling = '0') then
                    -- this is the address in bytes
                    BRAM_byte_addr := std_logic_vector(resize(unsigned(s_tid) * unsigned(elements_per_channel) + 
                                      s_output_idx + unsigned(initial_offset), BRAM_byte_addr'length));

                    -- the way that the testbench wants me to output stuff
                    -- it wants address to be the first byte of the word that I am trying to acess
                    BRAM_addr  <= BRAM_byte_addr(31 downto 2) & 0b"00"; 
                else
                    BRAM_byte_addr  := std_logic_vector(resize(unsigned(s_tid) * unsigned(elements_per_channel) + 
                                       s_output_idx(DIM_WIDTH-1 downto 1) + unsigned(initial_offset), BRAM_addr'length));
                    BRAM_addr  <= BRAM_byte_addr(31 downto 2) & 0b"00"; 
                end if;

                -- This tells us which byte we should be modifying
                if (max_pooling = '0') then
                    case s_output_idx(1 downto 0) is
                        when "00"   => BRAM_din <= BRAM_dout(31 downto 8)  & s_data;
                        when "01"   => BRAM_din <= BRAM_dout(31 downto 16) & s_data & BRAM_dout(7 downto 0);
                        when "10"   => BRAM_din <= BRAM_dout(31 downto 24) & s_data & BRAM_dout(15 downto 0);
                        when others => BRAM_din <= s_data & BRAM_dout(23 downto 0);
                    end case;
                else
                    if (s_oh(0) = '0' and s_ow(0) = '0') then -- if this is the first one
                        case s_output_idx(2 downto 0) is
                            when "000"   => BRAM_din <= BRAM_dout(31 downto 8) & s_data;
                            when "010"   => BRAM_din <= BRAM_dout(31 downto 16) & s_data & BRAM_dout(7 downto 0);
                            when "100"   => BRAM_din <= BRAM_dout(31 downto 24) & s_data & BRAM_dout(15 downto 0);
                            when "110"   => BRAM_din <= s_data & BRAM_dout(23 downto 0);
                            when others  => BRAM_din <= (others => '0');
                        end case;
                    else
                        case s_output_idx(2 downto 0) is
                            when "000" | "001"   => BRAM_din <= BRAM_dout(31 downto 8) & std_logic_vector(maximum(signed(BRAM_dout(7 downto 0)), signed(s_data)));

                            when "010" | "011"   => BRAM_din <= BRAM_dout(31 downto 16) & std_logic_vector(maximum(signed(BRAM_dout(15 downto 8)), signed(s_data)))
                                                                & BRAM_dout(7 downto 0);

                            when "100" | "101"   => BRAM_din <= BRAM_dout(31 downto 24) & std_logic_vector(maximum(signed(BRAM_dout(23 downto 16)), signed(s_data)))
                                                                & BRAM_dout(15 downto 0);

                            when "110" | "111"   => BRAM_din <= std_logic_vector(maximum(signed(BRAM_dout(31 downto 24)), signed(s_data))) 
                                                                & BRAM_dout(23 downto 0);
                            when others          => BRAM_din <= (others => '0');
                        end case;
                        
                    end if;

                end if;

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

                conv_complete <= '0';

                BRAM_rst <= '1'; -- BRAM RST pin is active high
            else
                BRAM_rst <= '0';
                -- Update state register
                current_state <= next_state;

                -- action on accept. This runs when transitioning from IDLE to READ. we register AXIS values
                if (current_state = IDLE and next_state = READ) then
                    s_data <= S_AXIS_TDATA;
                    s_tid  <= S_AXIS_TID;
                end if;

                -- Action on BUSY -> IDLE transition (Count increments once)
                if (current_state = WRITE and next_state = IDLE and s_tid = "11") then

                    -- I have to think about this. Because it might be possible that I have to set it 
                    -- when transitioning from READ to WRITE with tid = 11 if I want mark complete to be 1
                    -- during the last write
                    if (s_oh = unsigned(output_h) - 1) then
                        if (s_ow = unsigned(output_w) - 1) then
                                conv_complete <= '1';
                        end if;
                    end if;
                    
                    s_ow <= s_ow + 1;
                    s_output_idx <= s_output_idx + 1; 

                    -- when a row is finished, increment the height, and reset width
                    if(s_ow = unsigned(output_w) - 1) then
                        s_ow <= (others => '0');
                        s_oh <= s_oh + 1;
                        if(s_oh(0) = '0' and max_pooling = '1') then -- if max pooling and s_oh is even then roll back the index
                            s_output_idx <= resize((s_output_idx - unsigned(output_w) + 1), s_output_idx'length); -- get us to the beginning of the row
                    end if;
                    end if;


                end if;
            end if;
        end if;
    end process;
end Behavioral;
