----------------------------------------------------------------------------------
-- Input & Filter Index Generator
--
-- Gregory Ling, 2024
----------------------------------------------------------------------------------

library work;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity index_gen is
    generic(
        DIM_WIDTH : integer := 32;
        INPUT_ADDR_WIDTH : integer := 32;
        FILTER_ADDR_WIDTH : integer := 32;
        OUTPUT_ADDR_WIDTH : integer := 32
    );
    port(
        filter_w : in std_logic_vector(DIM_WIDTH-1 downto 0); -- Filter dimension width (Filter width)
        filter_h : in std_logic_vector(DIM_WIDTH-1 downto 0); -- Filter dimension height (Filter height)
        filter_c : in std_logic_vector(DIM_WIDTH-1 downto 0); -- Filter dimension channels (Filter channels == Input channels)
        output_w : in std_logic_vector(DIM_WIDTH-1 downto 0); -- Output dimension width (Output width)
        output_h : in std_logic_vector(DIM_WIDTH-1 downto 0); -- Output dimension height (Output height)
        -- ME: THESE ARE AMOUNT TO ADDS TO INPUTS
        input_end_diff_fw : in std_logic_vector(INPUT_ADDR_WIDTH-1 downto 0); -- Amount to add to addr when completing a filter row     (2)
        input_end_diff_fh : in std_logic_vector(INPUT_ADDR_WIDTH-1 downto 0); -- Amount to add to addr when completing a filter column  (6)
        input_end_diff_fc : in std_logic_vector(INPUT_ADDR_WIDTH-1 downto 0); -- Amount to add to addr when completing a filter channel (-17)
        input_end_diff_ow : in std_logic_vector(INPUT_ADDR_WIDTH-1 downto 0); -- Amount to add to addr when completing an output row    (-15)
        
        M_AXIS_TREADY : in std_logic;
        M_AXIS_TDATA_input_addr : out std_logic_vector(INPUT_ADDR_WIDTH-1 downto 0);
        M_AXIS_TDATA_filter_addr : out std_logic_vector(FILTER_ADDR_WIDTH-1 downto 0);
        M_AXIS_TLAST : out std_logic;
        M_AXIS_TVALID : out std_logic;

        conv_idle : in std_logic; -- When the convolution is idle, reset the index generator. Starts counting on falling edge
        rst : in std_logic;
        clk : in std_logic
    );
end index_gen;

architecture Behavioral of index_gen is

    -- BISMILLAH
    signal s_fw : unsigned(DIM_WIDTH-1 downto 0); -- index for keeping track of filter width
    signal s_fh : unsigned(DIM_WIDTH-1 downto 0); -- index for keeping track of filter height
    signal s_fc : unsigned(DIM_WIDTH-1 downto 0); -- index for keeping track of filter channel
    signal s_ow : unsigned(DIM_WIDTH-1 downto 0); -- index for keeping track of output width
    signal s_oh : unsigned(DIM_WIDTH-1 downto 0); -- index for keeping track of output height

    signal s_input_addr  : signed(INPUT_ADDR_WIDTH-1 downto 0);
    signal s_filter_addr : signed(FILTER_ADDR_WIDTH-1 downto 0);

    signal s_conv_done : std_logic; -- single bit to indicate one convolution should be done

begin
    M_AXIS_TDATA_input_addr  <= std_logic_vector(s_input_addr);
    M_AXIS_TDATA_filter_addr <= std_logic_vector(s_filter_addr);

    -- index gen output is allways valid (except for when being reset and after a convolution is done for one layer. Because we should be expecting conv_idle and a reset)
    M_AXIS_TVALID <= '1' when s_conv_done = '0' and conv_idle  = '0' and rst = '1' else '0';

    process(clk)
    begin
        if rising_edge(clk) then
            if (rst = '0' or conv_idle = '1') then
                s_fw <= (others => '0');        
                s_fh <= (others => '0');        
                s_fc <= (others => '0');        
                s_ow <= (others => '0');        
                s_oh <= (others => '0');        

                s_input_addr  <= (others => '0');
                s_filter_addr <= (others => '0');

                M_AXIS_TLAST <= '0';
                s_conv_done <= '0';

            elsif (M_AXIS_TREADY = '1') then

                s_fw <= s_fw + 1; -- increment width by one

                s_filter_addr <= s_filter_addr + 1; -- filter is always incremented by one
                s_input_addr  <= s_input_addr  + 1; -- input is incremented by one only when none of the condtions below is true
                M_AXIS_TLAST <= '0';

                -- when these conditions are met, next cycle should be the end of convolution for a single pixel of a feature map (so I can output tlast)
                if(s_fc = unsigned(filter_c) - 1) then
                    if(s_fh = unsigned(filter_h) - 1) then
                        if (s_fw = unsigned(filter_w) - 2) then
                            -- CONVOLUTION FOR ONE PIXEL IS COMPLE (NEXT CYCLE)
                            M_AXIS_TLAST <= '1';
                        end if;
                    end if;
                end if;

                -- when these conditions are met, next cycle should be the end of convolution for a complete feature map
                if(s_oh = unsigned(output_h) - 1) then
                    if(s_ow = unsigned(output_w) - 1) then
                        if(s_fc = unsigned(filter_c) - 1) then
                            if(s_fh = unsigned(filter_h) - 1) then
                                if (s_fw = unsigned(filter_w) - 1) then
                                    -- CONVOLUTION IS COMPLETE this cycle, so make sure next cycle's index is not valid
                                    s_conv_done <= '1';
                                end if;
                            end if;
                        end if;
                    end if;
                end if;

                
                if (s_fw = unsigned(filter_w) - 1) then
                    s_fw <= (others => '0');
                    s_fh <= s_fh + 1;
                    s_input_addr <= s_input_addr + signed(input_end_diff_fw);

                    if(s_fh = unsigned(filter_h) - 1) then
                        s_fh <= (others => '0');
                        s_fc <= s_fc + 1;
                        s_input_addr <= s_input_addr + signed(input_end_diff_fh);

                        if(s_fc = unsigned(filter_c) - 1) then
                            s_fc <= (others => '0');
                            s_ow <= s_ow + 1;
                            s_input_addr <= s_input_addr + signed(input_end_diff_fc);
                            s_filter_addr <= (others => '0'); -- reset filter address


                            if(s_ow = unsigned(output_w) - 1) then
                                s_ow <= (others => '0');
                                s_oh <= s_oh + 1;
                                s_input_addr <= s_input_addr + signed(input_end_diff_ow);

                                if(s_oh = unsigned(output_h) - 1) then
                                    s_oh <= (others => '0');

                                end if;
                            end if;
                        end if;
                    end if;
                end if;
            end if;
        end if;
    end process;
end Behavioral;
