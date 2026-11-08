--Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2020.1 (lin64) Build 2902540 Wed May 27 19:54:35 MDT 2020
--Date        : Sat Nov  7 19:53:53 2026
--Host        : co2050-06.ece.iastate.edu running 64-bit unknown
--Command     : generate_target axis_dsp_mac.bd
--Design      : axis_dsp_mac
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity axis_dsp_mac is
  port (
    ACLK : in STD_LOGIC;
    ARESETN : in STD_LOGIC;
    M_AXIS_tdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXIS_tid : out STD_LOGIC_VECTOR ( 7 downto 0 );
    M_AXIS_tlast : out STD_LOGIC;
    M_AXIS_tready : in STD_LOGIC;
    M_AXIS_tvalid : out STD_LOGIC;
    S_AXIS_tdata : in STD_LOGIC_VECTOR ( 15 downto 0 );
    S_AXIS_tid : in STD_LOGIC_VECTOR ( 7 downto 0 );
    S_AXIS_tlast : in STD_LOGIC;
    S_AXIS_tready : out STD_LOGIC;
    S_AXIS_tuser : in STD_LOGIC;
    S_AXIS_tvalid : in STD_LOGIC;
    bias : in STD_LOGIC_VECTOR ( 31 downto 0 )
  );
  attribute CORE_GENERATION_INFO : string;
  attribute CORE_GENERATION_INFO of axis_dsp_mac : entity is "axis_dsp_mac,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=axis_dsp_mac,x_ipVersion=1.00.a,x_ipLanguage=VHDL,numBlks=5,numReposBlks=5,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=3,numPkgbdBlks=0,bdsource=USER,synth_mode=OOC_per_IP}";
  attribute HW_HANDOFF : string;
  attribute HW_HANDOFF of axis_dsp_mac : entity is "axis_dsp_mac.hwdef";
end axis_dsp_mac;

architecture STRUCTURE of axis_dsp_mac is
  component axis_dsp_mac_shift_reg_0_0 is
  port (
    i_clk : in STD_LOGIC;
    i_reset : in STD_LOGIC;
    i_CE : in STD_LOGIC;
    i_data : in STD_LOGIC;
    o_data : out STD_LOGIC
  );
  end component axis_dsp_mac_shift_reg_0_0;
  component axis_dsp_mac_xbip_dsp48_macro_0_0 is
  port (
    CLK : in STD_LOGIC;
    CE : in STD_LOGIC;
    SEL : in STD_LOGIC_VECTOR ( 0 to 0 );
    A : in STD_LOGIC_VECTOR ( 7 downto 0 );
    B : in STD_LOGIC_VECTOR ( 7 downto 0 );
    C : in STD_LOGIC_VECTOR ( 31 downto 0 );
    P : out STD_LOGIC_VECTOR ( 47 downto 0 )
  );
  end component axis_dsp_mac_xbip_dsp48_macro_0_0;
  component axis_dsp_mac_xlslice_0_0 is
  port (
    Din : in STD_LOGIC_VECTOR ( 47 downto 0 );
    Dout : out STD_LOGIC_VECTOR ( 31 downto 0 )
  );
  end component axis_dsp_mac_xlslice_0_0;
  component axis_dsp_mac_slave_controller_0_0 is
  port (
    ACLK : in STD_LOGIC;
    ARESETN : in STD_LOGIC;
    M_AXIS_TVALID : out STD_LOGIC;
    M_AXIS_TDATA : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXIS_TLAST : out STD_LOGIC;
    M_AXIS_TREADY : in STD_LOGIC;
    M_AXIS_TID : out STD_LOGIC_VECTOR ( 7 downto 0 );
    slave_ready_out : out STD_LOGIC;
    dsp_acc_in : in STD_LOGIC_VECTOR ( 31 downto 0 );
    acc_valid_in : in STD_LOGIC
  );
  end component axis_dsp_mac_slave_controller_0_0;
  component axis_dsp_mac_master_controller_0_0 is
  port (
    ACLK : in STD_LOGIC;
    ARESETN : in STD_LOGIC;
    S_AXIS_TREADY : out STD_LOGIC;
    S_AXIS_TDATA : in STD_LOGIC_VECTOR ( 15 downto 0 );
    S_AXIS_TLAST : in STD_LOGIC;
    S_AXIS_TUSER : in STD_LOGIC;
    S_AXIS_TVALID : in STD_LOGIC;
    S_AXIS_TID : in STD_LOGIC_VECTOR ( 7 downto 0 );
    bias : in STD_LOGIC_VECTOR ( 31 downto 0 );
    mac_A_out : out STD_LOGIC_VECTOR ( 7 downto 0 );
    mac_B_out : out STD_LOGIC_VECTOR ( 7 downto 0 );
    mac_C_out : out STD_LOGIC_VECTOR ( 31 downto 0 );
    mac_sel_out : out STD_LOGIC;
    mac_valid_tlast_out : out STD_LOGIC;
    slave_ready_in : in STD_LOGIC
  );
  end component axis_dsp_mac_master_controller_0_0;
  signal \^m_axis_tdata\ : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal \^m_axis_tid\ : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal \^m_axis_tlast\ : STD_LOGIC;
  signal \^m_axis_tready\ : STD_LOGIC;
  signal \^m_axis_tvalid\ : STD_LOGIC;
  signal \^s_axis_tdata\ : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal \^s_axis_tid\ : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal \^s_axis_tlast\ : STD_LOGIC;
  signal \^s_axis_tready\ : STD_LOGIC;
  signal \^s_axis_tuser\ : STD_LOGIC;
  signal \^s_axis_tvalid\ : STD_LOGIC;
  signal master_controller_0_mac_A_out : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal master_controller_0_mac_B_out : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal master_controller_0_mac_C_out : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal master_controller_0_mac_sel_out : STD_LOGIC;
  signal master_controller_0_mac_valid_tlast_out : STD_LOGIC;
  signal shift_reg_0_o_data : STD_LOGIC;
  signal slave_controller_0_slave_ready_out : STD_LOGIC;
  signal xbip_dsp48_macro_0_P : STD_LOGIC_VECTOR ( 47 downto 0 );
  signal xlslice_0_Dout : STD_LOGIC_VECTOR ( 31 downto 0 );
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of ACLK : signal is "xilinx.com:signal:clock:1.0 CLK.ACLK CLK";
  attribute X_INTERFACE_PARAMETER : string;
  attribute X_INTERFACE_PARAMETER of ACLK : signal is "XIL_INTERFACENAME CLK.ACLK, ASSOCIATED_BUSIF M_AXIS:S_AXIS, ASSOCIATED_RESET ARESETN, CLK_DOMAIN axis_dsp_mac_ACLK_0, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0.000";
  attribute X_INTERFACE_INFO of ARESETN : signal is "xilinx.com:signal:reset:1.0 RST.ARESETN RST";
  attribute X_INTERFACE_PARAMETER of ARESETN : signal is "XIL_INTERFACENAME RST.ARESETN, INSERT_VIP 0, POLARITY ACTIVE_LOW";
  attribute X_INTERFACE_INFO of M_AXIS_tlast : signal is "xilinx.com:interface:axis:1.0 M_AXIS TLAST";
  attribute X_INTERFACE_INFO of M_AXIS_tready : signal is "xilinx.com:interface:axis:1.0 M_AXIS TREADY";
  attribute X_INTERFACE_INFO of M_AXIS_tvalid : signal is "xilinx.com:interface:axis:1.0 M_AXIS TVALID";
  attribute X_INTERFACE_INFO of S_AXIS_tlast : signal is "xilinx.com:interface:axis:1.0 S_AXIS ";
  attribute X_INTERFACE_INFO of S_AXIS_tready : signal is "xilinx.com:interface:axis:1.0 S_AXIS ";
  attribute X_INTERFACE_INFO of S_AXIS_tuser : signal is "xilinx.com:interface:axis:1.0 S_AXIS ";
  attribute X_INTERFACE_INFO of S_AXIS_tvalid : signal is "xilinx.com:interface:axis:1.0 S_AXIS ";
  attribute X_INTERFACE_INFO of M_AXIS_tdata : signal is "xilinx.com:interface:axis:1.0 M_AXIS TDATA";
  attribute X_INTERFACE_PARAMETER of M_AXIS_tdata : signal is "XIL_INTERFACENAME M_AXIS, CLK_DOMAIN axis_dsp_mac_ACLK_0, FREQ_HZ 100000000, HAS_TKEEP 0, HAS_TLAST 1, HAS_TREADY 1, HAS_TSTRB 0, INSERT_VIP 0, LAYERED_METADATA undef, PHASE 0.000, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 8, TUSER_WIDTH 0";
  attribute X_INTERFACE_INFO of M_AXIS_tid : signal is "xilinx.com:interface:axis:1.0 M_AXIS TID";
  attribute X_INTERFACE_INFO of S_AXIS_tdata : signal is "xilinx.com:interface:axis:1.0 S_AXIS ";
  attribute X_INTERFACE_PARAMETER of S_AXIS_tdata : signal is "XIL_INTERFACENAME S_AXIS, CLK_DOMAIN axis_dsp_mac_ACLK_0, FREQ_HZ 100000000, HAS_TKEEP 0, HAS_TLAST 1, HAS_TREADY 1, HAS_TSTRB 0, INSERT_VIP 0, LAYERED_METADATA undef, PHASE 0.000, TDATA_NUM_BYTES 2, TDEST_WIDTH 0, TID_WIDTH 8, TUSER_WIDTH 1";
  attribute X_INTERFACE_INFO of S_AXIS_tid : signal is "xilinx.com:interface:axis:1.0 S_AXIS ";
begin
  M_AXIS_tdata(31 downto 0) <= \^m_axis_tdata\(31 downto 0);
  M_AXIS_tid(7 downto 0) <= \^m_axis_tid\(7 downto 0);
  M_AXIS_tlast <= \^m_axis_tlast\;
  M_AXIS_tvalid <= \^m_axis_tvalid\;
  S_AXIS_tready <= \^s_axis_tready\;
  \^m_axis_tready\ <= M_AXIS_tready;
  \^s_axis_tdata\(15 downto 0) <= S_AXIS_tdata(15 downto 0);
  \^s_axis_tid\(7 downto 0) <= S_AXIS_tid(7 downto 0);
  \^s_axis_tlast\ <= S_AXIS_tlast;
  \^s_axis_tuser\ <= S_AXIS_tuser;
  \^s_axis_tvalid\ <= S_AXIS_tvalid;
master_controller_0: component axis_dsp_mac_master_controller_0_0
     port map (
      ACLK => ACLK,
      ARESETN => ARESETN,
      S_AXIS_TDATA(15 downto 0) => \^s_axis_tdata\(15 downto 0),
      S_AXIS_TID(7 downto 0) => \^s_axis_tid\(7 downto 0),
      S_AXIS_TLAST => \^s_axis_tlast\,
      S_AXIS_TREADY => \^s_axis_tready\,
      S_AXIS_TUSER => \^s_axis_tuser\,
      S_AXIS_TVALID => \^s_axis_tvalid\,
      bias(31 downto 0) => bias(31 downto 0),
      mac_A_out(7 downto 0) => master_controller_0_mac_A_out(7 downto 0),
      mac_B_out(7 downto 0) => master_controller_0_mac_B_out(7 downto 0),
      mac_C_out(31 downto 0) => master_controller_0_mac_C_out(31 downto 0),
      mac_sel_out => master_controller_0_mac_sel_out,
      mac_valid_tlast_out => master_controller_0_mac_valid_tlast_out,
      slave_ready_in => slave_controller_0_slave_ready_out
    );
shift_reg_0: component axis_dsp_mac_shift_reg_0_0
     port map (
      i_CE => slave_controller_0_slave_ready_out,
      i_clk => ACLK,
      i_data => master_controller_0_mac_valid_tlast_out,
      i_reset => ARESETN,
      o_data => shift_reg_0_o_data
    );
slave_controller_0: component axis_dsp_mac_slave_controller_0_0
     port map (
      ACLK => ACLK,
      ARESETN => ARESETN,
      M_AXIS_TDATA(31 downto 0) => \^m_axis_tdata\(31 downto 0),
      M_AXIS_TID(7 downto 0) => \^m_axis_tid\(7 downto 0),
      M_AXIS_TLAST => \^m_axis_tlast\,
      M_AXIS_TREADY => \^m_axis_tready\,
      M_AXIS_TVALID => \^m_axis_tvalid\,
      acc_valid_in => shift_reg_0_o_data,
      dsp_acc_in(31 downto 0) => xlslice_0_Dout(31 downto 0),
      slave_ready_out => slave_controller_0_slave_ready_out
    );
xbip_dsp48_macro_0: component axis_dsp_mac_xbip_dsp48_macro_0_0
     port map (
      A(7 downto 0) => master_controller_0_mac_A_out(7 downto 0),
      B(7 downto 0) => master_controller_0_mac_B_out(7 downto 0),
      C(31 downto 0) => master_controller_0_mac_C_out(31 downto 0),
      CE => slave_controller_0_slave_ready_out,
      CLK => ACLK,
      P(47 downto 0) => xbip_dsp48_macro_0_P(47 downto 0),
      SEL(0) => master_controller_0_mac_sel_out
    );
xlslice_0: component axis_dsp_mac_xlslice_0_0
     port map (
      Din(47 downto 0) => xbip_dsp48_macro_0_P(47 downto 0),
      Dout(31 downto 0) => xlslice_0_Dout(31 downto 0)
    );
end STRUCTURE;
