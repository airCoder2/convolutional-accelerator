// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.1 (lin64) Build 2902540 Wed May 27 19:54:35 MDT 2020
// Date        : Sat Nov  7 16:38:26 2026
// Host        : co2050-06.ece.iastate.edu running 64-bit unknown
// Command     : write_verilog -force -mode funcsim
//               /home/umhaihl/machine_learning/lab7/vivado/lab6_template/lab6_template.srcs/sources_1/bd/dsp_mac/ip/dsp_mac_xbip_dsp48_macro_0_0/dsp_mac_xbip_dsp48_macro_0_0_sim_netlist.v
// Design      : dsp_mac_xbip_dsp48_macro_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z020clg484-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "dsp_mac_xbip_dsp48_macro_0_0,xbip_dsp48_macro_v3_0_17,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "xbip_dsp48_macro_v3_0_17,Vivado 2020.1" *) 
(* NotValidForBitStream *)
module dsp_mac_xbip_dsp48_macro_0_0
   (CLK,
    CE,
    SEL,
    A,
    B,
    C,
    P);
  (* x_interface_info = "xilinx.com:signal:clock:1.0 clk_intf CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME clk_intf, ASSOCIATED_BUSIF p_intf:pcout_intf:carrycascout_intf:carryout_intf:bcout_intf:acout_intf:concat_intf:d_intf:c_intf:b_intf:a_intf:bcin_intf:acin_intf:pcin_intf:carryin_intf:carrycascin_intf:sel_intf, ASSOCIATED_RESET SCLR:SCLRD:SCLRA:SCLRB:SCLRCONCAT:SCLRC:SCLRM:SCLRP:SCLRSEL, ASSOCIATED_CLKEN CE:CED:CED1:CED2:CED3:CEA:CEA1:CEA2:CEA3:CEA4:CEB:CEB1:CEB2:CEB3:CEB4:CECONCAT:CECONCAT3:CECONCAT4:CECONCAT5:CEC:CEC1:CEC2:CEC3:CEC4:CEC5:CEM:CEP:CESEL:CESEL1:CESEL2:CESEL3:CESEL4:CESEL5, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.000, CLK_DOMAIN dsp_mac_ACLK_0, INSERT_VIP 0" *) input CLK;
  (* x_interface_info = "xilinx.com:signal:clockenable:1.0 ce_intf CE" *) (* x_interface_parameter = "XIL_INTERFACENAME ce_intf, POLARITY ACTIVE_LOW" *) input CE;
  (* x_interface_info = "xilinx.com:signal:data:1.0 sel_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME sel_intf, LAYERED_METADATA undef" *) input [0:0]SEL;
  (* x_interface_info = "xilinx.com:signal:data:1.0 a_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME a_intf, LAYERED_METADATA undef" *) input [7:0]A;
  (* x_interface_info = "xilinx.com:signal:data:1.0 b_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME b_intf, LAYERED_METADATA undef" *) input [7:0]B;
  (* x_interface_info = "xilinx.com:signal:data:1.0 c_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME c_intf, LAYERED_METADATA undef" *) input [31:0]C;
  (* x_interface_info = "xilinx.com:signal:data:1.0 p_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME p_intf, LAYERED_METADATA xilinx.com:interface:datatypes:1.0 {DATA {datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type generated dependency width format long minimum {} maximum {}} value 48} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0} real {fixed {fractwidth {attribs {resolve_type generated dependency fractwidth format long minimum {} maximum {}} value 0} signed {attribs {resolve_type immediate dependency {} format bool minimum {} maximum {}} value true}}}}} DATA_WIDTH 48}" *) output [47:0]P;

  wire [7:0]A;
  wire [7:0]B;
  wire [31:0]C;
  wire CE;
  wire CLK;
  wire [47:0]P;
  wire [0:0]SEL;
  wire NLW_U0_CARRYCASCOUT_UNCONNECTED;
  wire NLW_U0_CARRYOUT_UNCONNECTED;
  wire [29:0]NLW_U0_ACOUT_UNCONNECTED;
  wire [17:0]NLW_U0_BCOUT_UNCONNECTED;
  wire [47:0]NLW_U0_PCOUT_UNCONNECTED;

  (* C_A_WIDTH = "8" *) 
  (* C_B_WIDTH = "8" *) 
  (* C_CONCAT_WIDTH = "48" *) 
  (* C_CONSTANT_1 = "1" *) 
  (* C_C_WIDTH = "32" *) 
  (* C_D_WIDTH = "18" *) 
  (* C_HAS_A = "1" *) 
  (* C_HAS_ACIN = "0" *) 
  (* C_HAS_ACOUT = "0" *) 
  (* C_HAS_B = "1" *) 
  (* C_HAS_BCIN = "0" *) 
  (* C_HAS_BCOUT = "0" *) 
  (* C_HAS_C = "1" *) 
  (* C_HAS_CARRYCASCIN = "0" *) 
  (* C_HAS_CARRYCASCOUT = "0" *) 
  (* C_HAS_CARRYIN = "0" *) 
  (* C_HAS_CARRYOUT = "0" *) 
  (* C_HAS_CE = "1" *) 
  (* C_HAS_CEA = "0" *) 
  (* C_HAS_CEB = "0" *) 
  (* C_HAS_CEC = "0" *) 
  (* C_HAS_CECONCAT = "0" *) 
  (* C_HAS_CED = "0" *) 
  (* C_HAS_CEM = "0" *) 
  (* C_HAS_CEP = "0" *) 
  (* C_HAS_CESEL = "0" *) 
  (* C_HAS_CONCAT = "0" *) 
  (* C_HAS_D = "0" *) 
  (* C_HAS_INDEP_CE = "0" *) 
  (* C_HAS_INDEP_SCLR = "0" *) 
  (* C_HAS_PCIN = "0" *) 
  (* C_HAS_PCOUT = "0" *) 
  (* C_HAS_SCLR = "0" *) 
  (* C_HAS_SCLRA = "0" *) 
  (* C_HAS_SCLRB = "0" *) 
  (* C_HAS_SCLRC = "0" *) 
  (* C_HAS_SCLRCONCAT = "0" *) 
  (* C_HAS_SCLRD = "0" *) 
  (* C_HAS_SCLRM = "0" *) 
  (* C_HAS_SCLRP = "0" *) 
  (* C_HAS_SCLRSEL = "0" *) 
  (* C_LATENCY = "-1" *) 
  (* C_MODEL_TYPE = "0" *) 
  (* C_OPMODES = "000000000010010100000000,000000000000110000000000" *) 
  (* C_P_LSB = "0" *) 
  (* C_P_MSB = "47" *) 
  (* C_REG_CONFIG = "00000000000011100111100111100100" *) 
  (* C_SEL_WIDTH = "1" *) 
  (* C_TEST_CORE = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "zynq" *) 
  (* KEEP_HIERARCHY = "soft" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  dsp_mac_xbip_dsp48_macro_0_0_xbip_dsp48_macro_v3_0_17 U0
       (.A(A),
        .ACIN({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .ACOUT(NLW_U0_ACOUT_UNCONNECTED[29:0]),
        .B(B),
        .BCIN({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .BCOUT(NLW_U0_BCOUT_UNCONNECTED[17:0]),
        .C(C),
        .CARRYCASCIN(1'b0),
        .CARRYCASCOUT(NLW_U0_CARRYCASCOUT_UNCONNECTED),
        .CARRYIN(1'b0),
        .CARRYOUT(NLW_U0_CARRYOUT_UNCONNECTED),
        .CE(CE),
        .CEA(1'b1),
        .CEA1(1'b1),
        .CEA2(1'b1),
        .CEA3(1'b1),
        .CEA4(1'b1),
        .CEB(1'b1),
        .CEB1(1'b1),
        .CEB2(1'b1),
        .CEB3(1'b1),
        .CEB4(1'b1),
        .CEC(1'b1),
        .CEC1(1'b1),
        .CEC2(1'b1),
        .CEC3(1'b1),
        .CEC4(1'b1),
        .CEC5(1'b1),
        .CECONCAT(1'b1),
        .CECONCAT3(1'b1),
        .CECONCAT4(1'b1),
        .CECONCAT5(1'b1),
        .CED(1'b1),
        .CED1(1'b1),
        .CED2(1'b1),
        .CED3(1'b1),
        .CEM(1'b1),
        .CEP(1'b1),
        .CESEL(1'b1),
        .CESEL1(1'b1),
        .CESEL2(1'b1),
        .CESEL3(1'b1),
        .CESEL4(1'b1),
        .CESEL5(1'b1),
        .CLK(CLK),
        .CONCAT({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .D({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .P(P),
        .PCIN({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .PCOUT(NLW_U0_PCOUT_UNCONNECTED[47:0]),
        .SCLR(1'b0),
        .SCLRA(1'b0),
        .SCLRB(1'b0),
        .SCLRC(1'b0),
        .SCLRCONCAT(1'b0),
        .SCLRD(1'b0),
        .SCLRM(1'b0),
        .SCLRP(1'b0),
        .SCLRSEL(1'b0),
        .SEL(SEL));
endmodule

(* C_A_WIDTH = "8" *) (* C_B_WIDTH = "8" *) (* C_CONCAT_WIDTH = "48" *) 
(* C_CONSTANT_1 = "1" *) (* C_C_WIDTH = "32" *) (* C_D_WIDTH = "18" *) 
(* C_HAS_A = "1" *) (* C_HAS_ACIN = "0" *) (* C_HAS_ACOUT = "0" *) 
(* C_HAS_B = "1" *) (* C_HAS_BCIN = "0" *) (* C_HAS_BCOUT = "0" *) 
(* C_HAS_C = "1" *) (* C_HAS_CARRYCASCIN = "0" *) (* C_HAS_CARRYCASCOUT = "0" *) 
(* C_HAS_CARRYIN = "0" *) (* C_HAS_CARRYOUT = "0" *) (* C_HAS_CE = "1" *) 
(* C_HAS_CEA = "0" *) (* C_HAS_CEB = "0" *) (* C_HAS_CEC = "0" *) 
(* C_HAS_CECONCAT = "0" *) (* C_HAS_CED = "0" *) (* C_HAS_CEM = "0" *) 
(* C_HAS_CEP = "0" *) (* C_HAS_CESEL = "0" *) (* C_HAS_CONCAT = "0" *) 
(* C_HAS_D = "0" *) (* C_HAS_INDEP_CE = "0" *) (* C_HAS_INDEP_SCLR = "0" *) 
(* C_HAS_PCIN = "0" *) (* C_HAS_PCOUT = "0" *) (* C_HAS_SCLR = "0" *) 
(* C_HAS_SCLRA = "0" *) (* C_HAS_SCLRB = "0" *) (* C_HAS_SCLRC = "0" *) 
(* C_HAS_SCLRCONCAT = "0" *) (* C_HAS_SCLRD = "0" *) (* C_HAS_SCLRM = "0" *) 
(* C_HAS_SCLRP = "0" *) (* C_HAS_SCLRSEL = "0" *) (* C_LATENCY = "-1" *) 
(* C_MODEL_TYPE = "0" *) (* C_OPMODES = "000000000010010100000000,000000000000110000000000" *) (* C_P_LSB = "0" *) 
(* C_P_MSB = "47" *) (* C_REG_CONFIG = "00000000000011100111100111100100" *) (* C_SEL_WIDTH = "1" *) 
(* C_TEST_CORE = "0" *) (* C_VERBOSITY = "0" *) (* C_XDEVICEFAMILY = "zynq" *) 
(* ORIG_REF_NAME = "xbip_dsp48_macro_v3_0_17" *) (* downgradeipidentifiedwarnings = "yes" *) 
module dsp_mac_xbip_dsp48_macro_0_0_xbip_dsp48_macro_v3_0_17
   (CLK,
    CE,
    SCLR,
    SEL,
    CARRYCASCIN,
    CARRYIN,
    PCIN,
    ACIN,
    BCIN,
    A,
    B,
    C,
    D,
    CONCAT,
    ACOUT,
    BCOUT,
    CARRYOUT,
    CARRYCASCOUT,
    PCOUT,
    P,
    CED,
    CED1,
    CED2,
    CED3,
    CEA,
    CEA1,
    CEA2,
    CEA3,
    CEA4,
    CEB,
    CEB1,
    CEB2,
    CEB3,
    CEB4,
    CECONCAT,
    CECONCAT3,
    CECONCAT4,
    CECONCAT5,
    CEC,
    CEC1,
    CEC2,
    CEC3,
    CEC4,
    CEC5,
    CEM,
    CEP,
    CESEL,
    CESEL1,
    CESEL2,
    CESEL3,
    CESEL4,
    CESEL5,
    SCLRD,
    SCLRA,
    SCLRB,
    SCLRCONCAT,
    SCLRC,
    SCLRM,
    SCLRP,
    SCLRSEL);
  input CLK;
  input CE;
  input SCLR;
  input [0:0]SEL;
  input CARRYCASCIN;
  input CARRYIN;
  input [47:0]PCIN;
  input [29:0]ACIN;
  input [17:0]BCIN;
  input [7:0]A;
  input [7:0]B;
  input [31:0]C;
  input [17:0]D;
  input [47:0]CONCAT;
  output [29:0]ACOUT;
  output [17:0]BCOUT;
  output CARRYOUT;
  output CARRYCASCOUT;
  output [47:0]PCOUT;
  output [47:0]P;
  input CED;
  input CED1;
  input CED2;
  input CED3;
  input CEA;
  input CEA1;
  input CEA2;
  input CEA3;
  input CEA4;
  input CEB;
  input CEB1;
  input CEB2;
  input CEB3;
  input CEB4;
  input CECONCAT;
  input CECONCAT3;
  input CECONCAT4;
  input CECONCAT5;
  input CEC;
  input CEC1;
  input CEC2;
  input CEC3;
  input CEC4;
  input CEC5;
  input CEM;
  input CEP;
  input CESEL;
  input CESEL1;
  input CESEL2;
  input CESEL3;
  input CESEL4;
  input CESEL5;
  input SCLRD;
  input SCLRA;
  input SCLRB;
  input SCLRCONCAT;
  input SCLRC;
  input SCLRM;
  input SCLRP;
  input SCLRSEL;

  wire [7:0]A;
  wire [29:0]ACIN;
  wire [29:0]ACOUT;
  wire [7:0]B;
  wire [17:0]BCIN;
  wire [17:0]BCOUT;
  wire [31:0]C;
  wire CARRYCASCIN;
  wire CARRYCASCOUT;
  wire CARRYIN;
  wire CARRYOUT;
  wire CE;
  wire CLK;
  wire [47:0]P;
  wire [47:0]PCIN;
  wire [47:0]PCOUT;
  wire [0:0]SEL;

  (* C_A_WIDTH = "8" *) 
  (* C_B_WIDTH = "8" *) 
  (* C_CONCAT_WIDTH = "48" *) 
  (* C_CONSTANT_1 = "1" *) 
  (* C_C_WIDTH = "32" *) 
  (* C_D_WIDTH = "18" *) 
  (* C_HAS_A = "1" *) 
  (* C_HAS_ACIN = "0" *) 
  (* C_HAS_ACOUT = "0" *) 
  (* C_HAS_B = "1" *) 
  (* C_HAS_BCIN = "0" *) 
  (* C_HAS_BCOUT = "0" *) 
  (* C_HAS_C = "1" *) 
  (* C_HAS_CARRYCASCIN = "0" *) 
  (* C_HAS_CARRYCASCOUT = "0" *) 
  (* C_HAS_CARRYIN = "0" *) 
  (* C_HAS_CARRYOUT = "0" *) 
  (* C_HAS_CE = "1" *) 
  (* C_HAS_CEA = "0" *) 
  (* C_HAS_CEB = "0" *) 
  (* C_HAS_CEC = "0" *) 
  (* C_HAS_CECONCAT = "0" *) 
  (* C_HAS_CED = "0" *) 
  (* C_HAS_CEM = "0" *) 
  (* C_HAS_CEP = "0" *) 
  (* C_HAS_CESEL = "0" *) 
  (* C_HAS_CONCAT = "0" *) 
  (* C_HAS_D = "0" *) 
  (* C_HAS_INDEP_CE = "0" *) 
  (* C_HAS_INDEP_SCLR = "0" *) 
  (* C_HAS_PCIN = "0" *) 
  (* C_HAS_PCOUT = "0" *) 
  (* C_HAS_SCLR = "0" *) 
  (* C_HAS_SCLRA = "0" *) 
  (* C_HAS_SCLRB = "0" *) 
  (* C_HAS_SCLRC = "0" *) 
  (* C_HAS_SCLRCONCAT = "0" *) 
  (* C_HAS_SCLRD = "0" *) 
  (* C_HAS_SCLRM = "0" *) 
  (* C_HAS_SCLRP = "0" *) 
  (* C_HAS_SCLRSEL = "0" *) 
  (* C_LATENCY = "-1" *) 
  (* C_MODEL_TYPE = "0" *) 
  (* C_OPMODES = "000000000010010100000000,000000000000110000000000" *) 
  (* C_P_LSB = "0" *) 
  (* C_P_MSB = "47" *) 
  (* C_REG_CONFIG = "00000000000011100111100111100100" *) 
  (* C_SEL_WIDTH = "1" *) 
  (* C_TEST_CORE = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "zynq" *) 
  (* KEEP_HIERARCHY = "soft" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  dsp_mac_xbip_dsp48_macro_0_0_xbip_dsp48_macro_v3_0_17_viv i_synth
       (.A(A),
        .ACIN(ACIN),
        .ACOUT(ACOUT),
        .B(B),
        .BCIN(BCIN),
        .BCOUT(BCOUT),
        .C(C),
        .CARRYCASCIN(CARRYCASCIN),
        .CARRYCASCOUT(CARRYCASCOUT),
        .CARRYIN(CARRYIN),
        .CARRYOUT(CARRYOUT),
        .CE(CE),
        .CEA(1'b0),
        .CEA1(1'b0),
        .CEA2(1'b0),
        .CEA3(1'b0),
        .CEA4(1'b0),
        .CEB(1'b0),
        .CEB1(1'b0),
        .CEB2(1'b0),
        .CEB3(1'b0),
        .CEB4(1'b0),
        .CEC(1'b0),
        .CEC1(1'b0),
        .CEC2(1'b0),
        .CEC3(1'b0),
        .CEC4(1'b0),
        .CEC5(1'b0),
        .CECONCAT(1'b0),
        .CECONCAT3(1'b0),
        .CECONCAT4(1'b0),
        .CECONCAT5(1'b0),
        .CED(1'b0),
        .CED1(1'b0),
        .CED2(1'b0),
        .CED3(1'b0),
        .CEM(1'b0),
        .CEP(1'b0),
        .CESEL(1'b0),
        .CESEL1(1'b0),
        .CESEL2(1'b0),
        .CESEL3(1'b0),
        .CESEL4(1'b0),
        .CESEL5(1'b0),
        .CLK(CLK),
        .CONCAT({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .D({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .P(P),
        .PCIN(PCIN),
        .PCOUT(PCOUT),
        .SCLR(1'b0),
        .SCLRA(1'b0),
        .SCLRB(1'b0),
        .SCLRC(1'b0),
        .SCLRCONCAT(1'b0),
        .SCLRD(1'b0),
        .SCLRM(1'b0),
        .SCLRP(1'b0),
        .SCLRSEL(1'b0),
        .SEL(SEL));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2020.1"
`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="cds_rsa_key", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=64)
`pragma protect key_block
mVSg04jx48ohF6ET+GPgL/18xNlqSjc68SAwWWVL7ETIEhL/N/IEEa794563sOuKxSt0Kl67y+94
UB0egY5nGg==

`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
lmyXeW6W5x34OcR/9HBy5DakFHbrAP2VPoaQ3ab68lLfG02ITRD3w7EdbM/TyvDE2AithtcpGANE
xoGGRFEy5XpfEmD0vRdB2QdH78Q3znXmRJJRNPPn0gBDy8HiV5ndsmD/LeinHmOe8eK7LpDgq37J
/At5o0EqFZW3WjRL3sk=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
ScNmNM0W62HGNpFgTi5FAXgfrWYsig59kPYL2q8QE5KGweGkCLDCL7Hkobrafd5P88QLcDON+uhX
IyI83xgtYqHn9XvdBn8HqJzARuJNNTON3Zj7Cg0wwXEkJtSsBQmXcAr8B8YlHB5Ot1eWfmo01yW2
ucT2GUyoADNv1dAw9b6BSTAsVTnSGRaLEFNmWdsXqE9NxNE2TgfO5x/a8DTy3f4g5X7/hJLCKpg4
wudzUxG+uR7hx57H8Q09kX8BvU+C37l5Ltf3PNYwwUbKRz/EM4tLYtmrZC9s12buYcsYbj6wNTU7
3gzKdMayi7u7lq3LMlQDerpr0jYxylPt4GrIOA==

`pragma protect key_keyowner="ATRENTA", key_keyname="ATR-SG-2015-RSA-3", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
e87Uz7OgoObx921b4TAOTFPf7RdEkGb5ZVAdacGLXY7GMiPCfCc7YMl+VeJl5YDir0JYQiTkbhLh
mLscEPt5ONOoiBzAJqkKFldx6auMyo+P/7DiauuYIbPgkW7umqOxwZfrmjnw20eMtarltmzr6AGp
6aopNGbAJEL+hwyM5JFo5kit3y/Ea4LUEzIW9ld9DY+p0Ihvdhdfy0zQmToIHb/Np9zzKX8tpOC3
Fa4uXF8qCvbeUJr6LjjXyQB+06m7Lz0C23RJ4hC9KIerHxpF3jfuAzHKSvlLatWH1Yh0cIKx7k/y
DKMp82d5B3CU6d7/9rRzzzXEniDDeg47rWYfDg==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
N9AuFk0bI81JYG49sYg/AXtRGVFdClaczQEWHn/vG0tDAjhQ2qA0GYN+86AxMP6Eq5ZUOynxdshU
bN1lWaCpVjK938uUJqRzJ07jB62cIexo8C/g1/2x8b1jzFGqoZaH8XuvvhE2jws7SBqjDWp6QqwF
DccZxmM0BtqxnQ0vOxg=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
ksqAObrv2EPWm9QjMQbS9Jri8+lbIuMSp3qiCFd7V5lqBbL7GPCdYLZeldgitO6uJU6g/HJUdlqY
vAtACW1AEC8JJxRRn91cFSbi+kvg64hC5Vnug+KdRN6vjapzUK4c/DIOy6/+2jRigEC+IX4vaS+x
i+Oi2k1i9ZiAzw7qzBPTCbiy3fIyNxT8GQf6HanMu/28I8MRYfhgvQ7ol1S003awbKh+hQ0F0PzV
QKh9CDlIz8s1WyXc+huI2QS1FG60KK6XWZ0aalbB+Lt5+x9Z8uV4zUAwJB1XlcNRMiM5SkjkIg9r
y6yFAGmNR5T5BqgWguE62jSBd9Zfnh8JXP2NOQ==

`pragma protect key_keyowner="Real Intent", key_keyname="RI-RSA-KEY-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
yejHCke96a3eh+No32kwjUcXbwCyaPKyFR3prOsF6TJCbrqwfvvxDeC6TSDIUBXnczwcjZGdrJzh
kWpgjQJo/+Fhj4Ofu3XGUwSa6fkycuNX9V9NKeCjQKWKmMwRn7y3etJWdJ9gQzeiKRshRI1cO1mT
xKbyArTNkWP2ZyuWXsKVeN/uv2UAnGmIkXXlm+ydbtEEypSYfKGvayajQjpQkN9HKz13nMpeuMc9
6DMCTp2atZYYbmvMLGsYr48d8enLKwx68sd7DuvTAfi41FUDiRNDI4vopTU0JcRKcjXGPRMY8yoc
XZdRPSINaUGZCdPmtfc2gza4Uxt7sTq51XGfrg==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2019_11", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
qGh3mlgVn/697cVM/wVbbB7SoNiFJgOKvbMq77owzjnL3crAcnY8GFt3Q08R5QyrP2hHuw8Lswju
dXYOZ3/oAi7aUy1kyPLhuKPWeWxo3+dYvubUpGt2JG+EAT+jldyl+H25jnvNn+t3heQmGgAsd2nd
MIq2UzPXQ2RVJZa9xZCPPHg1CnXHeNMi4uv/6DX4+JoQGVTyGQXjGOxnxJ5b8V7W4BbY/opssAME
iaFMorNt/wd5IaLUhZ9xN1hAax910Vrp1kXD6WAysFoxMIabE4Oq3hm6M7fi2AGw5K+4HIYSfrvh
X+3VnMAwckadGO97+iJkxqNFTAR1vyW1StWhFw==

`pragma protect key_keyowner="Metrics Technologies Inc.", key_keyname="DSim", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
Pui+6jIzuAMgIrqBhLPkObysF1xlKfNhOoUcMAEnnCukOSOFRG7FlFnE35Y7dv5tVrcj1zyjpjBM
sXZv8anrAKSRvqeJBa6ob74VpJPjY03nbvpX9cKAy/35SoT0G/h13Vq3R2V8237P13necwIXQCfi
FgiqLcEwSK/bMDkKeuJaUpwJpR8qwpPU/FFCN+14kb6y7BVbAlPLvxPiBFnHkQ0W9XitUAeU5Av4
b/BxC9luLD7NZ4l0iN1eD7w84NtO4AbC9x8FYMuqAJcqo8/Zjs/UMMfZBMLhUGeSSe0TmZVZxuPo
q7heU5cfCjNVluZN/Uc2IX1ahWmYJ5tO7GDp5A==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
MjudKAdd273Il3sUF+Ww1sYOqkyI4tqMofUQcDq0Y+2TaWiN/QSkA0GTzAoa4iowG/3eB9F+l4oE
YKhl6Og8eokDwtvOxTmaOL7f2/7euXOlStM791qYhjrjp9NjRdVM0XfGiswqXkthesVl4GMY8I9G
giqsNpVf1jD2yS7C2eReOyUPJScnmmrt2kiEouIMv+CccLH54WCtzquML01pv+IZSGL1SoVrFVNx
ChOjOroPhHmsxN4i3y76M4p0fg4eMcUMulewN13qvLxaYqNmQ8NkzU51fO5e+HjmJf+RL9pQo6lz
b1b5eCAFwGl9YPURmhI2oeteI7tvvVJRcz7RAA==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
QaRFlyTqjInAZrqlLlASlM+DydfhADDP2WkUF5uY/r/dcGgmm9CYn+Su3sFC0/C9k2Eo7e1UsBVj
QLXtigLhCh6qZNEYrrIVtMYMjAff/6yh2h7zVyR4nGVnEWI74gto01YknyTaO0e3SRpvcFH/ONFU
htBJ7EmybdAqKq7nOaNCh0Jz813LPU3anUAQUNp7N8rYxs26YUzG4Y3bc0Cv6q3EQQBrQBQZyymn
tc6QMRjn+DL6w9ss43dOALbpYL6Nbq9Yt6nhUrO5KgmMc+heuasSwXqsFcH3tnCTvuPm3PtAFMRy
7UxIZTVQfjWk+zIz1fxft9AXiIeLrGMEGEJioQ==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 56128)
`pragma protect data_block
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
`pragma protect end_protected
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
