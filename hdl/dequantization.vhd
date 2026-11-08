----------------------------------------------------------------------------------
-- Dequantization Unit
--
-- Gregory Ling, 2024
----------------------------------------------------------------------------------

library work;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity dequantization is
    generic(
        C_DATA_WIDTH : integer := 32;
        C_TID_WIDTH : integer := 1;
        C_OUT_WIDTH : integer := 8
    );
    port(
        S_AXIS_TREADY : out std_logic;
        S_AXIS_TDATA  : in  std_logic_vector(C_DATA_WIDTH-1 downto 0);
        S_AXIS_TLAST  : in  std_logic;
        S_AXIS_TID    : in  std_logic_vector(C_TID_WIDTH-1 downto 0);
        S_AXIS_TVALID : in  std_logic;

        relu : in std_logic;
        q_scale : in std_logic_vector(C_DATA_WIDTH-1 downto 0);
        q_zero : in std_logic_vector(C_OUT_WIDTH-1 downto 0);

        M_AXIS_TREADY : in  std_logic;
        M_AXIS_TDATA  : out std_logic_vector(C_OUT_WIDTH-1 downto 0);
        M_AXIS_TLAST  : out std_logic;
        M_AXIS_TID    : out std_logic_vector(C_TID_WIDTH-1 downto 0);
        M_AXIS_TVALID : out std_logic;

        clk : in std_logic;
        rst : in std_logic
    );
end dequantization;

architecture Behavioral of dequantization is

    signal s_reg_s_axis_tdata  : std_logic_vector(C_DATA_WIDTH-1 downto 0);
    signal s_product : signed(2*C_DATA_WIDTH-1 downto 0);
    signal s_scaled  : signed(C_DATA_WIDTH-1 downto 0);
    signal s_relued  : signed(C_DATA_WIDTH-1 downto 0);
    signal s_zeroed  : signed(C_DATA_WIDTH-1 downto 0);
    
    signal s_quantized_value : signed(C_OUT_WIDTH-1 downto 0);

begin
    -- EXP: so basically we need to export the correct M from python that allows us to do
    --      fixed point math rather than a floating point one. Testbench generator also implements it this way


    -- q_scale is really the M that has to be calcuated offline
    s_product <= signed(S_AXIS_TDATA) * signed(q_scale);

    -- scale
    s_scaled <= s_product(2*C_DATA_WIDTH-1 downto C_DATA_WIDTH);

    -- relue
    s_relued <= (others => '0') when (s_scaled < 0 and relu = '1') else s_scaled;

    -- add the zero point of the next layer
    s_zeroed <= s_relued + signed(q_zero);

    -- saturate
    s_quantized_value <= to_signed(127, C_OUT_WIDTH)  when s_zeroed > 127 else
                     to_signed(-128, C_OUT_WIDTH) when s_zeroed < -128 else
                     s_zeroed(C_OUT_WIDTH-1 downto 0);

    dequantize_reg: entity work.axis_register_slice
        generic map(
            C_DATA_WIDTH => C_OUT_WIDTH,
            C_TID_WIDTH => C_TID_WIDTH
        )
        port map(
            S_AXIS_TREADY => S_AXIS_TREADY, 
            S_AXIS_TDATA => std_logic_vector(s_quantized_value),
            S_AXIS_TLAST => S_AXIS_TLAST,
            S_AXIS_TID => S_AXIS_TID,
            S_AXIS_TVALID => S_AXIS_TVALID, 

            M_AXIS_TREADY => M_AXIS_TREADY,
            M_AXIS_TDATA => M_AXIS_TDATA,
            M_AXIS_TLAST => M_AXIS_TLAST,
            M_AXIS_TID => M_AXIS_TID,
            M_AXIS_TVALID => M_AXIS_TVALID,
            
            rst => rst,
            clk => clk
        );

end Behavioral;
