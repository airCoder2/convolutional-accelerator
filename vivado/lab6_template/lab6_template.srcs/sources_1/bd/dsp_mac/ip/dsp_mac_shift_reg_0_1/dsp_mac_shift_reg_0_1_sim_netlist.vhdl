-- Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2020.1 (lin64) Build 2902540 Wed May 27 19:54:35 MDT 2020
-- Date        : Sat Nov  7 16:38:24 2026
-- Host        : co2050-06.ece.iastate.edu running 64-bit unknown
-- Command     : write_vhdl -force -mode funcsim
--               /home/umhaihl/machine_learning/lab7/vivado/lab6_template/lab6_template.srcs/sources_1/bd/dsp_mac/ip/dsp_mac_shift_reg_0_1/dsp_mac_shift_reg_0_1_sim_netlist.vhdl
-- Design      : dsp_mac_shift_reg_0_1
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7z020clg484-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity dsp_mac_shift_reg_0_1_shift_reg is
  port (
    o_data : out STD_LOGIC;
    i_CE : in STD_LOGIC;
    i_clk : in STD_LOGIC;
    i_data : in STD_LOGIC;
    i_reset : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of dsp_mac_shift_reg_0_1_shift_reg : entity is "shift_reg";
end dsp_mac_shift_reg_0_1_shift_reg;

architecture STRUCTURE of dsp_mac_shift_reg_0_1_shift_reg is
  signal p_0_in : STD_LOGIC;
  signal p_1_in : STD_LOGIC_VECTOR ( 3 downto 1 );
begin
\s_shift_reg[3]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => i_reset,
      O => p_0_in
    );
\s_shift_reg_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => i_clk,
      CE => i_CE,
      D => i_data,
      Q => p_1_in(1),
      R => p_0_in
    );
\s_shift_reg_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => i_clk,
      CE => i_CE,
      D => p_1_in(1),
      Q => p_1_in(2),
      R => p_0_in
    );
\s_shift_reg_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => i_clk,
      CE => i_CE,
      D => p_1_in(2),
      Q => p_1_in(3),
      R => p_0_in
    );
\s_shift_reg_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => i_clk,
      CE => i_CE,
      D => p_1_in(3),
      Q => o_data,
      R => p_0_in
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity dsp_mac_shift_reg_0_1 is
  port (
    i_clk : in STD_LOGIC;
    i_reset : in STD_LOGIC;
    i_CE : in STD_LOGIC;
    i_data : in STD_LOGIC;
    o_data : out STD_LOGIC
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of dsp_mac_shift_reg_0_1 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of dsp_mac_shift_reg_0_1 : entity is "dsp_mac_shift_reg_0_1,shift_reg,{}";
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of dsp_mac_shift_reg_0_1 : entity is "yes";
  attribute ip_definition_source : string;
  attribute ip_definition_source of dsp_mac_shift_reg_0_1 : entity is "module_ref";
  attribute x_core_info : string;
  attribute x_core_info of dsp_mac_shift_reg_0_1 : entity is "shift_reg,Vivado 2020.1";
end dsp_mac_shift_reg_0_1;

architecture STRUCTURE of dsp_mac_shift_reg_0_1 is
  attribute sigis : string;
  attribute sigis of i_clk : signal is "Clk";
  attribute x_interface_info : string;
  attribute x_interface_info of i_clk : signal is "xilinx.com:signal:clock:1.0 i_clk CLK";
  attribute x_interface_parameter : string;
  attribute x_interface_parameter of i_clk : signal is "XIL_INTERFACENAME i_clk, ASSOCIATED_RESET i_reset, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.000, CLK_DOMAIN dsp_mac_ACLK_0, INSERT_VIP 0";
  attribute x_interface_info of i_reset : signal is "xilinx.com:signal:reset:1.0 i_reset RST";
  attribute x_interface_parameter of i_reset : signal is "XIL_INTERFACENAME i_reset, POLARITY ACTIVE_LOW, INSERT_VIP 0";
begin
U0: entity work.dsp_mac_shift_reg_0_1_shift_reg
     port map (
      i_CE => i_CE,
      i_clk => i_clk,
      i_data => i_data,
      i_reset => i_reset,
      o_data => o_data
    );
end STRUCTURE;
