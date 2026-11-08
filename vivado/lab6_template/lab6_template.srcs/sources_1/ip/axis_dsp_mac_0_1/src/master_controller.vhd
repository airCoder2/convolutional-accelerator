library work;
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity master_controller is
  generic(
      -- Parameters of mac
      -- width of the A (weight) and B (activation) operands going into the dsp, at most 8.
      -- They are the low C_DATA_WIDTH bits of bytes 0 and 1 of the stream data (the software sends sign-extended int8)
      C_DATA_WIDTH : integer := 8
    );
	port (
        ACLK	: in	std_logic;
		ARESETN	: in	std_logic;       

        -- AXIS slave data interface
		S_AXIS_TREADY	: out	std_logic;
		S_AXIS_TDATA	: in	std_logic_vector(15 downto 0);  -- Packed data input
		S_AXIS_TLAST	: in	std_logic;
        S_AXIS_TUSER   : in    std_logic;  
		S_AXIS_TVALID	: in	std_logic;
        S_AXIS_TID     : in    std_logic_vector(7 downto 0);

        bias : in std_logic_vector(31 downto 0);
         
        --- MY OUTS
        mac_A_out         : out std_logic_vector(7 downto 0); -- this is fixed, because the input to my DSP is fixed
        mac_B_out         : out std_logic_vector(7 downto 0); -- this is fixed, because the input to my DSP is fixed
        mac_C_out         : out std_logic_vector(31 downto 0);
        mac_sel_out       : out std_logic; -- this selects which instruction to choose, Either load bias or accumulate
        mac_valid_tlast_out : out std_logic;

        --- MY INS
        slave_ready_in  : in std_logic
     ); -- this comes from slave_controller and is high when the whole pipeline can advance (its output register is empty or the downstream receiver is ready)

-- ME: just letting the synthesis tool know that ACLK is clock, so it can route it diffrently
attribute SIGIS : string; 
attribute SIGIS of ACLK : signal is "Clk"; 

end master_controller;


architecture behavioral of master_controller is

    -- MY SIGNALS: 
    signal s_last_in_reg_out : std_logic;
    signal s_data_in_reg_out : std_logic_vector(15 downto 0);
    signal s_bias_in_reg_out : std_logic_vector(31 downto 0);
    signal s_valid_in_reg_out: std_logic;

    signal s_A_reg_out : std_logic_vector(7 downto 0);
    signal s_B_reg_out : std_logic_vector(7 downto 0);
    signal s_C_reg_out : std_logic_vector(31 downto 0);
    signal s_valid_tlast_reg_out : std_logic;
    signal s_sel_reg_out : std_logic;

    signal s_expected_bias_reg_out : std_logic;
    signal s_muxed_data : std_logic_vector(15 downto 0);


begin
    -- Assignments

    -- Accept new input whenever the pipeline can advance; it only stalls when a finished result is waiting at the output and the downstream receiver is not ready
    S_AXIS_TREADY      <= slave_ready_in;
    mac_A_out           <= s_A_reg_out;
    mac_B_out           <= s_B_reg_out;
    mac_C_out           <= s_C_reg_out;
    mac_sel_out         <= s_sel_reg_out;
    mac_valid_tlast_out <= s_valid_tlast_reg_out;

    s_muxed_data <= s_data_in_reg_out when (s_valid_in_reg_out = '1') else (others => '0');

    process(ACLK) is
    begin
        if rising_edge(ACLK) then
            if ARESETN = '0' then

                s_data_in_reg_out  <= (others => '0');
                s_bias_in_reg_out  <= (others => '0');
                s_last_in_reg_out  <= '0';
                s_valid_in_reg_out <= '0';

                s_A_reg_out <= (others => '0');
                s_B_reg_out <= (others => '0');
                s_C_reg_out <= (others => '0');

                s_valid_tlast_reg_out <= '0';
                s_sel_reg_out <= '0';


                -- initiall arm to load bias
                s_expected_bias_reg_out <= '1';

            elsif slave_ready_in = '1' then

                s_last_in_reg_out <= S_AXIS_TLAST;
                s_valid_in_reg_out <= S_AXIS_TVALID;
                s_data_in_reg_out <= S_AXIS_TDATA;
                s_bias_in_reg_out <= bias;

                s_A_reg_out <= s_muxed_data(7 downto 0);
                s_B_reg_out <= s_muxed_data(15 downto 8);
                s_C_reg_out <= s_bias_in_reg_out;

                s_valid_tlast_reg_out <= s_valid_in_reg_out and s_last_in_reg_out;
                s_sel_reg_out <= s_expected_bias_reg_out;

                -- if data is valid, then set last_state to expected bias.
                -- This way, we know next valid data is going to be bias
                if (s_valid_in_reg_out = '1') then
                    s_expected_bias_reg_out <= s_last_in_reg_out;
                end if;
                

            end if;
        end if;
    end process;

end architecture behavioral;
