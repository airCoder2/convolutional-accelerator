-- Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2020.1 (lin64) Build 2902540 Wed May 27 19:54:35 MDT 2020
-- Date        : Sat Nov  7 16:39:01 2026
-- Host        : co2050-06.ece.iastate.edu running 64-bit unknown
-- Command     : write_vhdl -force -mode synth_stub
--               /home/umhaihl/machine_learning/lab7/vivado/lab6_template/lab6_template.srcs/sources_1/bd/dsp_mac/ip/dsp_mac_slave_controller_0_0/dsp_mac_slave_controller_0_0_stub.vhdl
-- Design      : dsp_mac_slave_controller_0_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7z020clg484-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity dsp_mac_slave_controller_0_0 is
  Port ( 
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

end dsp_mac_slave_controller_0_0;

architecture stub of dsp_mac_slave_controller_0_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "ACLK,ARESETN,MO_AXIS_TVALID,MO_AXIS_TDATA[31:0],MO_AXIS_TLAST,MO_AXIS_TREADY,MO_AXIS_TID[7:0],slave_ready_out,dsp_acc_in[31:0],acc_valid_in";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "slave_controller,Vivado 2020.1";
begin
end;
