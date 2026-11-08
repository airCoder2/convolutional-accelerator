// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.1 (lin64) Build 2902540 Wed May 27 19:54:35 MDT 2020
// Date        : Sat Nov  7 16:39:01 2026
// Host        : co2050-06.ece.iastate.edu running 64-bit unknown
// Command     : write_verilog -force -mode funcsim
//               /home/umhaihl/machine_learning/lab7/vivado/lab6_template/lab6_template.srcs/sources_1/bd/dsp_mac/ip/dsp_mac_slave_controller_0_0/dsp_mac_slave_controller_0_0_sim_netlist.v
// Design      : dsp_mac_slave_controller_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z020clg484-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "dsp_mac_slave_controller_0_0,slave_controller,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* ip_definition_source = "module_ref" *) 
(* x_core_info = "slave_controller,Vivado 2020.1" *) 
(* NotValidForBitStream *)
module dsp_mac_slave_controller_0_0
   (ACLK,
    ARESETN,
    MO_AXIS_TVALID,
    MO_AXIS_TDATA,
    MO_AXIS_TLAST,
    MO_AXIS_TREADY,
    MO_AXIS_TID,
    slave_ready_out,
    dsp_acc_in,
    acc_valid_in);
  (* sigis = "Clk" *) (* x_interface_info = "xilinx.com:signal:clock:1.0 ACLK CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME ACLK, ASSOCIATED_BUSIF MO_AXIS, ASSOCIATED_RESET ARESETN, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.000, CLK_DOMAIN dsp_mac_ACLK_0, INSERT_VIP 0" *) input ACLK;
  (* x_interface_info = "xilinx.com:signal:reset:1.0 ARESETN RST" *) (* x_interface_parameter = "XIL_INTERFACENAME ARESETN, POLARITY ACTIVE_LOW, INSERT_VIP 0" *) input ARESETN;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 MO_AXIS TVALID" *) (* x_interface_parameter = "XIL_INTERFACENAME MO_AXIS, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 8, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 1, FREQ_HZ 100000000, PHASE 0.000, CLK_DOMAIN dsp_mac_ACLK_0, LAYERED_METADATA undef, INSERT_VIP 0" *) output MO_AXIS_TVALID;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 MO_AXIS TDATA" *) output [31:0]MO_AXIS_TDATA;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 MO_AXIS TLAST" *) output MO_AXIS_TLAST;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 MO_AXIS TREADY" *) input MO_AXIS_TREADY;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 MO_AXIS TID" *) output [7:0]MO_AXIS_TID;
  output slave_ready_out;
  input [31:0]dsp_acc_in;
  input acc_valid_in;

  wire \<const0> ;
  wire ACLK;
  wire ARESETN;
  wire [31:0]MO_AXIS_TDATA;
  wire MO_AXIS_TREADY;
  wire MO_AXIS_TVALID;
  wire acc_valid_in;
  wire [31:0]dsp_acc_in;
  wire slave_ready_out;

  assign MO_AXIS_TID[7] = \<const0> ;
  assign MO_AXIS_TID[6] = \<const0> ;
  assign MO_AXIS_TID[5] = \<const0> ;
  assign MO_AXIS_TID[4] = \<const0> ;
  assign MO_AXIS_TID[3] = \<const0> ;
  assign MO_AXIS_TID[2] = \<const0> ;
  assign MO_AXIS_TID[1] = \<const0> ;
  assign MO_AXIS_TID[0] = \<const0> ;
  assign MO_AXIS_TLAST = MO_AXIS_TVALID;
  GND GND
       (.G(\<const0> ));
  dsp_mac_slave_controller_0_0_slave_controller U0
       (.ACLK(ACLK),
        .ARESETN(ARESETN),
        .E(slave_ready_out),
        .MO_AXIS_TDATA(MO_AXIS_TDATA),
        .MO_AXIS_TREADY(MO_AXIS_TREADY),
        .MO_AXIS_TVALID(MO_AXIS_TVALID),
        .acc_valid_in(acc_valid_in),
        .dsp_acc_in(dsp_acc_in));
endmodule

(* ORIG_REF_NAME = "slave_controller" *) 
module dsp_mac_slave_controller_0_0_slave_controller
   (MO_AXIS_TVALID,
    E,
    MO_AXIS_TDATA,
    acc_valid_in,
    ACLK,
    dsp_acc_in,
    ARESETN,
    MO_AXIS_TREADY);
  output MO_AXIS_TVALID;
  output [0:0]E;
  output [31:0]MO_AXIS_TDATA;
  input acc_valid_in;
  input ACLK;
  input [31:0]dsp_acc_in;
  input ARESETN;
  input MO_AXIS_TREADY;

  wire ACLK;
  wire ARESETN;
  wire [0:0]E;
  wire [31:0]MO_AXIS_TDATA;
  wire MO_AXIS_TREADY;
  wire MO_AXIS_TVALID;
  wire acc_valid_in;
  wire [31:0]dsp_acc_in;
  wire p_0_in;

  FDRE \s_acc_reg_out_reg[0] 
       (.C(ACLK),
        .CE(E),
        .D(dsp_acc_in[0]),
        .Q(MO_AXIS_TDATA[0]),
        .R(p_0_in));
  FDRE \s_acc_reg_out_reg[10] 
       (.C(ACLK),
        .CE(E),
        .D(dsp_acc_in[10]),
        .Q(MO_AXIS_TDATA[10]),
        .R(p_0_in));
  FDRE \s_acc_reg_out_reg[11] 
       (.C(ACLK),
        .CE(E),
        .D(dsp_acc_in[11]),
        .Q(MO_AXIS_TDATA[11]),
        .R(p_0_in));
  FDRE \s_acc_reg_out_reg[12] 
       (.C(ACLK),
        .CE(E),
        .D(dsp_acc_in[12]),
        .Q(MO_AXIS_TDATA[12]),
        .R(p_0_in));
  FDRE \s_acc_reg_out_reg[13] 
       (.C(ACLK),
        .CE(E),
        .D(dsp_acc_in[13]),
        .Q(MO_AXIS_TDATA[13]),
        .R(p_0_in));
  FDRE \s_acc_reg_out_reg[14] 
       (.C(ACLK),
        .CE(E),
        .D(dsp_acc_in[14]),
        .Q(MO_AXIS_TDATA[14]),
        .R(p_0_in));
  FDRE \s_acc_reg_out_reg[15] 
       (.C(ACLK),
        .CE(E),
        .D(dsp_acc_in[15]),
        .Q(MO_AXIS_TDATA[15]),
        .R(p_0_in));
  FDRE \s_acc_reg_out_reg[16] 
       (.C(ACLK),
        .CE(E),
        .D(dsp_acc_in[16]),
        .Q(MO_AXIS_TDATA[16]),
        .R(p_0_in));
  FDRE \s_acc_reg_out_reg[17] 
       (.C(ACLK),
        .CE(E),
        .D(dsp_acc_in[17]),
        .Q(MO_AXIS_TDATA[17]),
        .R(p_0_in));
  FDRE \s_acc_reg_out_reg[18] 
       (.C(ACLK),
        .CE(E),
        .D(dsp_acc_in[18]),
        .Q(MO_AXIS_TDATA[18]),
        .R(p_0_in));
  FDRE \s_acc_reg_out_reg[19] 
       (.C(ACLK),
        .CE(E),
        .D(dsp_acc_in[19]),
        .Q(MO_AXIS_TDATA[19]),
        .R(p_0_in));
  FDRE \s_acc_reg_out_reg[1] 
       (.C(ACLK),
        .CE(E),
        .D(dsp_acc_in[1]),
        .Q(MO_AXIS_TDATA[1]),
        .R(p_0_in));
  FDRE \s_acc_reg_out_reg[20] 
       (.C(ACLK),
        .CE(E),
        .D(dsp_acc_in[20]),
        .Q(MO_AXIS_TDATA[20]),
        .R(p_0_in));
  FDRE \s_acc_reg_out_reg[21] 
       (.C(ACLK),
        .CE(E),
        .D(dsp_acc_in[21]),
        .Q(MO_AXIS_TDATA[21]),
        .R(p_0_in));
  FDRE \s_acc_reg_out_reg[22] 
       (.C(ACLK),
        .CE(E),
        .D(dsp_acc_in[22]),
        .Q(MO_AXIS_TDATA[22]),
        .R(p_0_in));
  FDRE \s_acc_reg_out_reg[23] 
       (.C(ACLK),
        .CE(E),
        .D(dsp_acc_in[23]),
        .Q(MO_AXIS_TDATA[23]),
        .R(p_0_in));
  FDRE \s_acc_reg_out_reg[24] 
       (.C(ACLK),
        .CE(E),
        .D(dsp_acc_in[24]),
        .Q(MO_AXIS_TDATA[24]),
        .R(p_0_in));
  FDRE \s_acc_reg_out_reg[25] 
       (.C(ACLK),
        .CE(E),
        .D(dsp_acc_in[25]),
        .Q(MO_AXIS_TDATA[25]),
        .R(p_0_in));
  FDRE \s_acc_reg_out_reg[26] 
       (.C(ACLK),
        .CE(E),
        .D(dsp_acc_in[26]),
        .Q(MO_AXIS_TDATA[26]),
        .R(p_0_in));
  FDRE \s_acc_reg_out_reg[27] 
       (.C(ACLK),
        .CE(E),
        .D(dsp_acc_in[27]),
        .Q(MO_AXIS_TDATA[27]),
        .R(p_0_in));
  FDRE \s_acc_reg_out_reg[28] 
       (.C(ACLK),
        .CE(E),
        .D(dsp_acc_in[28]),
        .Q(MO_AXIS_TDATA[28]),
        .R(p_0_in));
  FDRE \s_acc_reg_out_reg[29] 
       (.C(ACLK),
        .CE(E),
        .D(dsp_acc_in[29]),
        .Q(MO_AXIS_TDATA[29]),
        .R(p_0_in));
  FDRE \s_acc_reg_out_reg[2] 
       (.C(ACLK),
        .CE(E),
        .D(dsp_acc_in[2]),
        .Q(MO_AXIS_TDATA[2]),
        .R(p_0_in));
  FDRE \s_acc_reg_out_reg[30] 
       (.C(ACLK),
        .CE(E),
        .D(dsp_acc_in[30]),
        .Q(MO_AXIS_TDATA[30]),
        .R(p_0_in));
  FDRE \s_acc_reg_out_reg[31] 
       (.C(ACLK),
        .CE(E),
        .D(dsp_acc_in[31]),
        .Q(MO_AXIS_TDATA[31]),
        .R(p_0_in));
  FDRE \s_acc_reg_out_reg[3] 
       (.C(ACLK),
        .CE(E),
        .D(dsp_acc_in[3]),
        .Q(MO_AXIS_TDATA[3]),
        .R(p_0_in));
  FDRE \s_acc_reg_out_reg[4] 
       (.C(ACLK),
        .CE(E),
        .D(dsp_acc_in[4]),
        .Q(MO_AXIS_TDATA[4]),
        .R(p_0_in));
  FDRE \s_acc_reg_out_reg[5] 
       (.C(ACLK),
        .CE(E),
        .D(dsp_acc_in[5]),
        .Q(MO_AXIS_TDATA[5]),
        .R(p_0_in));
  FDRE \s_acc_reg_out_reg[6] 
       (.C(ACLK),
        .CE(E),
        .D(dsp_acc_in[6]),
        .Q(MO_AXIS_TDATA[6]),
        .R(p_0_in));
  FDRE \s_acc_reg_out_reg[7] 
       (.C(ACLK),
        .CE(E),
        .D(dsp_acc_in[7]),
        .Q(MO_AXIS_TDATA[7]),
        .R(p_0_in));
  FDRE \s_acc_reg_out_reg[8] 
       (.C(ACLK),
        .CE(E),
        .D(dsp_acc_in[8]),
        .Q(MO_AXIS_TDATA[8]),
        .R(p_0_in));
  FDRE \s_acc_reg_out_reg[9] 
       (.C(ACLK),
        .CE(E),
        .D(dsp_acc_in[9]),
        .Q(MO_AXIS_TDATA[9]),
        .R(p_0_in));
  LUT1 #(
    .INIT(2'h1)) 
    s_acc_valid_reg_out_i_1
       (.I0(ARESETN),
        .O(p_0_in));
  FDRE s_acc_valid_reg_out_reg
       (.C(ACLK),
        .CE(E),
        .D(acc_valid_in),
        .Q(MO_AXIS_TVALID),
        .R(p_0_in));
  LUT2 #(
    .INIT(4'hB)) 
    slave_ready_out_INST_0
       (.I0(MO_AXIS_TREADY),
        .I1(MO_AXIS_TVALID),
        .O(E));
endmodule
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
