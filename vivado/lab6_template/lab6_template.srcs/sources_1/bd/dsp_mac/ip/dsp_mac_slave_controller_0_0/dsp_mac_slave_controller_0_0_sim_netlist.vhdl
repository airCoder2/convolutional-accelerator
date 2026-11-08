-- Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2020.1 (lin64) Build 2902540 Wed May 27 19:54:35 MDT 2020
-- Date        : Sat Nov  7 16:39:01 2026
-- Host        : co2050-06.ece.iastate.edu running 64-bit unknown
-- Command     : write_vhdl -force -mode funcsim
--               /home/umhaihl/machine_learning/lab7/vivado/lab6_template/lab6_template.srcs/sources_1/bd/dsp_mac/ip/dsp_mac_slave_controller_0_0/dsp_mac_slave_controller_0_0_sim_netlist.vhdl
-- Design      : dsp_mac_slave_controller_0_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7z020clg484-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity dsp_mac_slave_controller_0_0_slave_controller is
  port (
    MO_AXIS_TVALID : out STD_LOGIC;
    E : out STD_LOGIC_VECTOR ( 0 to 0 );
    MO_AXIS_TDATA : out STD_LOGIC_VECTOR ( 31 downto 0 );
    acc_valid_in : in STD_LOGIC;
    ACLK : in STD_LOGIC;
    dsp_acc_in : in STD_LOGIC_VECTOR ( 31 downto 0 );
    ARESETN : in STD_LOGIC;
    MO_AXIS_TREADY : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of dsp_mac_slave_controller_0_0_slave_controller : entity is "slave_controller";
end dsp_mac_slave_controller_0_0_slave_controller;

architecture STRUCTURE of dsp_mac_slave_controller_0_0_slave_controller is
  signal \^e\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \^mo_axis_tvalid\ : STD_LOGIC;
  signal p_0_in : STD_LOGIC;
begin
  E(0) <= \^e\(0);
  MO_AXIS_TVALID <= \^mo_axis_tvalid\;
\s_acc_reg_out_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => ACLK,
      CE => \^e\(0),
      D => dsp_acc_in(0),
      Q => MO_AXIS_TDATA(0),
      R => p_0_in
    );
\s_acc_reg_out_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => ACLK,
      CE => \^e\(0),
      D => dsp_acc_in(10),
      Q => MO_AXIS_TDATA(10),
      R => p_0_in
    );
\s_acc_reg_out_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => ACLK,
      CE => \^e\(0),
      D => dsp_acc_in(11),
      Q => MO_AXIS_TDATA(11),
      R => p_0_in
    );
\s_acc_reg_out_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => ACLK,
      CE => \^e\(0),
      D => dsp_acc_in(12),
      Q => MO_AXIS_TDATA(12),
      R => p_0_in
    );
\s_acc_reg_out_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => ACLK,
      CE => \^e\(0),
      D => dsp_acc_in(13),
      Q => MO_AXIS_TDATA(13),
      R => p_0_in
    );
\s_acc_reg_out_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => ACLK,
      CE => \^e\(0),
      D => dsp_acc_in(14),
      Q => MO_AXIS_TDATA(14),
      R => p_0_in
    );
\s_acc_reg_out_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => ACLK,
      CE => \^e\(0),
      D => dsp_acc_in(15),
      Q => MO_AXIS_TDATA(15),
      R => p_0_in
    );
\s_acc_reg_out_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => ACLK,
      CE => \^e\(0),
      D => dsp_acc_in(16),
      Q => MO_AXIS_TDATA(16),
      R => p_0_in
    );
\s_acc_reg_out_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => ACLK,
      CE => \^e\(0),
      D => dsp_acc_in(17),
      Q => MO_AXIS_TDATA(17),
      R => p_0_in
    );
\s_acc_reg_out_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => ACLK,
      CE => \^e\(0),
      D => dsp_acc_in(18),
      Q => MO_AXIS_TDATA(18),
      R => p_0_in
    );
\s_acc_reg_out_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => ACLK,
      CE => \^e\(0),
      D => dsp_acc_in(19),
      Q => MO_AXIS_TDATA(19),
      R => p_0_in
    );
\s_acc_reg_out_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => ACLK,
      CE => \^e\(0),
      D => dsp_acc_in(1),
      Q => MO_AXIS_TDATA(1),
      R => p_0_in
    );
\s_acc_reg_out_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => ACLK,
      CE => \^e\(0),
      D => dsp_acc_in(20),
      Q => MO_AXIS_TDATA(20),
      R => p_0_in
    );
\s_acc_reg_out_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => ACLK,
      CE => \^e\(0),
      D => dsp_acc_in(21),
      Q => MO_AXIS_TDATA(21),
      R => p_0_in
    );
\s_acc_reg_out_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => ACLK,
      CE => \^e\(0),
      D => dsp_acc_in(22),
      Q => MO_AXIS_TDATA(22),
      R => p_0_in
    );
\s_acc_reg_out_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => ACLK,
      CE => \^e\(0),
      D => dsp_acc_in(23),
      Q => MO_AXIS_TDATA(23),
      R => p_0_in
    );
\s_acc_reg_out_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => ACLK,
      CE => \^e\(0),
      D => dsp_acc_in(24),
      Q => MO_AXIS_TDATA(24),
      R => p_0_in
    );
\s_acc_reg_out_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => ACLK,
      CE => \^e\(0),
      D => dsp_acc_in(25),
      Q => MO_AXIS_TDATA(25),
      R => p_0_in
    );
\s_acc_reg_out_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => ACLK,
      CE => \^e\(0),
      D => dsp_acc_in(26),
      Q => MO_AXIS_TDATA(26),
      R => p_0_in
    );
\s_acc_reg_out_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => ACLK,
      CE => \^e\(0),
      D => dsp_acc_in(27),
      Q => MO_AXIS_TDATA(27),
      R => p_0_in
    );
\s_acc_reg_out_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => ACLK,
      CE => \^e\(0),
      D => dsp_acc_in(28),
      Q => MO_AXIS_TDATA(28),
      R => p_0_in
    );
\s_acc_reg_out_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => ACLK,
      CE => \^e\(0),
      D => dsp_acc_in(29),
      Q => MO_AXIS_TDATA(29),
      R => p_0_in
    );
\s_acc_reg_out_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => ACLK,
      CE => \^e\(0),
      D => dsp_acc_in(2),
      Q => MO_AXIS_TDATA(2),
      R => p_0_in
    );
\s_acc_reg_out_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => ACLK,
      CE => \^e\(0),
      D => dsp_acc_in(30),
      Q => MO_AXIS_TDATA(30),
      R => p_0_in
    );
\s_acc_reg_out_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => ACLK,
      CE => \^e\(0),
      D => dsp_acc_in(31),
      Q => MO_AXIS_TDATA(31),
      R => p_0_in
    );
\s_acc_reg_out_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => ACLK,
      CE => \^e\(0),
      D => dsp_acc_in(3),
      Q => MO_AXIS_TDATA(3),
      R => p_0_in
    );
\s_acc_reg_out_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => ACLK,
      CE => \^e\(0),
      D => dsp_acc_in(4),
      Q => MO_AXIS_TDATA(4),
      R => p_0_in
    );
\s_acc_reg_out_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => ACLK,
      CE => \^e\(0),
      D => dsp_acc_in(5),
      Q => MO_AXIS_TDATA(5),
      R => p_0_in
    );
\s_acc_reg_out_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => ACLK,
      CE => \^e\(0),
      D => dsp_acc_in(6),
      Q => MO_AXIS_TDATA(6),
      R => p_0_in
    );
\s_acc_reg_out_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => ACLK,
      CE => \^e\(0),
      D => dsp_acc_in(7),
      Q => MO_AXIS_TDATA(7),
      R => p_0_in
    );
\s_acc_reg_out_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => ACLK,
      CE => \^e\(0),
      D => dsp_acc_in(8),
      Q => MO_AXIS_TDATA(8),
      R => p_0_in
    );
\s_acc_reg_out_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => ACLK,
      CE => \^e\(0),
      D => dsp_acc_in(9),
      Q => MO_AXIS_TDATA(9),
      R => p_0_in
    );
s_acc_valid_reg_out_i_1: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => ARESETN,
      O => p_0_in
    );
s_acc_valid_reg_out_reg: unisim.vcomponents.FDRE
     port map (
      C => ACLK,
      CE => \^e\(0),
      D => acc_valid_in,
      Q => \^mo_axis_tvalid\,
      R => p_0_in
    );
slave_ready_out_INST_0: unisim.vcomponents.LUT2
    generic map(
      INIT => X"B"
    )
        port map (
      I0 => MO_AXIS_TREADY,
      I1 => \^mo_axis_tvalid\,
      O => \^e\(0)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity dsp_mac_slave_controller_0_0 is
  port (
    ACLK : in STD_LOGIC;
    ARESETN : in STD_LOGIC;
    MO_AXIS_TVALID : out STD_LOGIC;
    MO_AXIS_TDATA : out STD_LOGIC_VECTOR ( 31 downto 0 );
    MO_AXIS_TLAST : out STD_LOGIC;
    MO_AXIS_TREADY : in STD_LOGIC;
    MO_AXIS_TID : out STD_LOGIC_VECTOR ( 7 downto 0 );
    slave_ready_out : out STD_LOGIC;
    dsp_acc_in : in STD_LOGIC_VECTOR ( 31 downto 0 );
    acc_valid_in : in STD_LOGIC
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of dsp_mac_slave_controller_0_0 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of dsp_mac_slave_controller_0_0 : entity is "dsp_mac_slave_controller_0_0,slave_controller,{}";
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of dsp_mac_slave_controller_0_0 : entity is "yes";
  attribute ip_definition_source : string;
  attribute ip_definition_source of dsp_mac_slave_controller_0_0 : entity is "module_ref";
  attribute x_core_info : string;
  attribute x_core_info of dsp_mac_slave_controller_0_0 : entity is "slave_controller,Vivado 2020.1";
end dsp_mac_slave_controller_0_0;

architecture STRUCTURE of dsp_mac_slave_controller_0_0 is
  signal \<const0>\ : STD_LOGIC;
  signal \^mo_axis_tvalid\ : STD_LOGIC;
  attribute sigis : string;
  attribute sigis of ACLK : signal is "Clk";
  attribute x_interface_info : string;
  attribute x_interface_info of ACLK : signal is "xilinx.com:signal:clock:1.0 ACLK CLK";
  attribute x_interface_parameter : string;
  attribute x_interface_parameter of ACLK : signal is "XIL_INTERFACENAME ACLK, ASSOCIATED_BUSIF MO_AXIS, ASSOCIATED_RESET ARESETN, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.000, CLK_DOMAIN dsp_mac_ACLK_0, INSERT_VIP 0";
  attribute x_interface_info of ARESETN : signal is "xilinx.com:signal:reset:1.0 ARESETN RST";
  attribute x_interface_parameter of ARESETN : signal is "XIL_INTERFACENAME ARESETN, POLARITY ACTIVE_LOW, INSERT_VIP 0";
  attribute x_interface_info of MO_AXIS_TLAST : signal is "xilinx.com:interface:axis:1.0 MO_AXIS TLAST";
  attribute x_interface_info of MO_AXIS_TREADY : signal is "xilinx.com:interface:axis:1.0 MO_AXIS TREADY";
  attribute x_interface_info of MO_AXIS_TVALID : signal is "xilinx.com:interface:axis:1.0 MO_AXIS TVALID";
  attribute x_interface_parameter of MO_AXIS_TVALID : signal is "XIL_INTERFACENAME MO_AXIS, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 8, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 1, FREQ_HZ 100000000, PHASE 0.000, CLK_DOMAIN dsp_mac_ACLK_0, LAYERED_METADATA undef, INSERT_VIP 0";
  attribute x_interface_info of MO_AXIS_TDATA : signal is "xilinx.com:interface:axis:1.0 MO_AXIS TDATA";
  attribute x_interface_info of MO_AXIS_TID : signal is "xilinx.com:interface:axis:1.0 MO_AXIS TID";
begin
  MO_AXIS_TID(7) <= \<const0>\;
  MO_AXIS_TID(6) <= \<const0>\;
  MO_AXIS_TID(5) <= \<const0>\;
  MO_AXIS_TID(4) <= \<const0>\;
  MO_AXIS_TID(3) <= \<const0>\;
  MO_AXIS_TID(2) <= \<const0>\;
  MO_AXIS_TID(1) <= \<const0>\;
  MO_AXIS_TID(0) <= \<const0>\;
  MO_AXIS_TLAST <= \^mo_axis_tvalid\;
  MO_AXIS_TVALID <= \^mo_axis_tvalid\;
GND: unisim.vcomponents.GND
     port map (
      G => \<const0>\
    );
U0: entity work.dsp_mac_slave_controller_0_0_slave_controller
     port map (
      ACLK => ACLK,
      ARESETN => ARESETN,
      E(0) => slave_ready_out,
      MO_AXIS_TDATA(31 downto 0) => MO_AXIS_TDATA(31 downto 0),
      MO_AXIS_TREADY => MO_AXIS_TREADY,
      MO_AXIS_TVALID => \^mo_axis_tvalid\,
      acc_valid_in => acc_valid_in,
      dsp_acc_in(31 downto 0) => dsp_acc_in(31 downto 0)
    );
end STRUCTURE;
