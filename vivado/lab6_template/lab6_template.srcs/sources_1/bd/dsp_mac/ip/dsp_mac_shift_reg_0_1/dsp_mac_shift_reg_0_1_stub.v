// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.1 (lin64) Build 2902540 Wed May 27 19:54:35 MDT 2020
// Date        : Sat Nov  7 16:38:24 2026
// Host        : co2050-06.ece.iastate.edu running 64-bit unknown
// Command     : write_verilog -force -mode synth_stub
//               /home/umhaihl/machine_learning/lab7/vivado/lab6_template/lab6_template.srcs/sources_1/bd/dsp_mac/ip/dsp_mac_shift_reg_0_1/dsp_mac_shift_reg_0_1_stub.v
// Design      : dsp_mac_shift_reg_0_1
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg484-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "shift_reg,Vivado 2020.1" *)
module dsp_mac_shift_reg_0_1(i_clk, i_reset, i_CE, i_data, o_data)
/* synthesis syn_black_box black_box_pad_pin="i_clk,i_reset,i_CE,i_data,o_data" */;
  input i_clk;
  input i_reset;
  input i_CE;
  input i_data;
  output o_data;
endmodule
