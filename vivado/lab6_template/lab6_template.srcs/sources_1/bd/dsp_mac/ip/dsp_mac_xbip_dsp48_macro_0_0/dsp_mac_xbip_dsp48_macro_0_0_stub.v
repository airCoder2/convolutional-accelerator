// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.1 (lin64) Build 2902540 Wed May 27 19:54:35 MDT 2020
// Date        : Sat Nov  7 16:38:26 2026
// Host        : co2050-06.ece.iastate.edu running 64-bit unknown
// Command     : write_verilog -force -mode synth_stub
//               /home/umhaihl/machine_learning/lab7/vivado/lab6_template/lab6_template.srcs/sources_1/bd/dsp_mac/ip/dsp_mac_xbip_dsp48_macro_0_0/dsp_mac_xbip_dsp48_macro_0_0_stub.v
// Design      : dsp_mac_xbip_dsp48_macro_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg484-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "xbip_dsp48_macro_v3_0_17,Vivado 2020.1" *)
module dsp_mac_xbip_dsp48_macro_0_0(CLK, CE, SEL, A, B, C, P)
/* synthesis syn_black_box black_box_pad_pin="CLK,CE,SEL[0:0],A[7:0],B[7:0],C[31:0],P[47:0]" */;
  input CLK;
  input CE;
  input [0:0]SEL;
  input [7:0]A;
  input [7:0]B;
  input [31:0]C;
  output [47:0]P;
endmodule
