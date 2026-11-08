// (c) Copyright 1995-2026 Xilinx, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
// 
// DO NOT MODIFY THIS FILE.

// IP VLNV: user.org:user:dsp_mac:1.0
// IP Revision: 2

// The following must be inserted into your Verilog file for this
// core to be instantiated. Change the instance name and port connections
// (in parentheses) to your own signal names.

//----------- Begin Cut here for INSTANTIATION Template ---// INST_TAG
dsp_mac_0 your_instance_name (
  .ACLK(ACLK),                      // input wire ACLK
  .ARESETN(ARESETN),                // input wire ARESETN
  .MO_AXIS_tdata(MO_AXIS_tdata),    // output wire [31 : 0] MO_AXIS_tdata
  .MO_AXIS_tid(MO_AXIS_tid),        // output wire [7 : 0] MO_AXIS_tid
  .MO_AXIS_tlast(MO_AXIS_tlast),    // output wire MO_AXIS_tlast
  .MO_AXIS_tready(MO_AXIS_tready),  // input wire MO_AXIS_tready
  .MO_AXIS_tvalid(MO_AXIS_tvalid),  // output wire MO_AXIS_tvalid
  .SD_AXIS_tdata(SD_AXIS_tdata),    // input wire [31 : 0] SD_AXIS_tdata
  .SD_AXIS_tid(SD_AXIS_tid),        // input wire [7 : 0] SD_AXIS_tid
  .SD_AXIS_tlast(SD_AXIS_tlast),    // input wire SD_AXIS_tlast
  .SD_AXIS_tready(SD_AXIS_tready),  // output wire SD_AXIS_tready
  .SD_AXIS_tuser(SD_AXIS_tuser),    // input wire SD_AXIS_tuser
  .SD_AXIS_tvalid(SD_AXIS_tvalid)  // input wire SD_AXIS_tvalid
);
// INST_TAG_END ------ End INSTANTIATION Template ---------

