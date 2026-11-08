// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.1 (lin64) Build 2902540 Wed May 27 19:54:35 MDT 2020
// Date        : Sat Nov  7 16:39:01 2026
// Host        : co2050-06.ece.iastate.edu running 64-bit unknown
// Command     : write_verilog -force -mode synth_stub
//               /home/umhaihl/machine_learning/lab7/vivado/lab6_template/lab6_template.srcs/sources_1/bd/dsp_mac/ip/dsp_mac_slave_controller_0_0/dsp_mac_slave_controller_0_0_stub.v
// Design      : dsp_mac_slave_controller_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg484-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "slave_controller,Vivado 2020.1" *)
module dsp_mac_slave_controller_0_0(ACLK, ARESETN, MO_AXIS_TVALID, MO_AXIS_TDATA, 
  MO_AXIS_TLAST, MO_AXIS_TREADY, MO_AXIS_TID, slave_ready_out, dsp_acc_in, acc_valid_in)
/* synthesis syn_black_box black_box_pad_pin="ACLK,ARESETN,MO_AXIS_TVALID,MO_AXIS_TDATA[31:0],MO_AXIS_TLAST,MO_AXIS_TREADY,MO_AXIS_TID[7:0],slave_ready_out,dsp_acc_in[31:0],acc_valid_in" */;
  input ACLK;
  input ARESETN;
  output MO_AXIS_TVALID;
  output [31:0]MO_AXIS_TDATA;
  output MO_AXIS_TLAST;
  input MO_AXIS_TREADY;
  output [7:0]MO_AXIS_TID;
  output slave_ready_out;
  input [31:0]dsp_acc_in;
  input acc_valid_in;
endmodule
