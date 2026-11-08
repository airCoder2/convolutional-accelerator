-- Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2020.1 (lin64) Build 2902540 Wed May 27 19:54:35 MDT 2020
-- Date        : Sat Nov  7 16:38:24 2026
-- Host        : co2050-06.ece.iastate.edu running 64-bit unknown
-- Command     : write_vhdl -force -mode synth_stub
--               /home/umhaihl/machine_learning/lab7/vivado/lab6_template/lab6_template.srcs/sources_1/bd/dsp_mac/ip/dsp_mac_shift_reg_0_1/dsp_mac_shift_reg_0_1_stub.vhdl
-- Design      : dsp_mac_shift_reg_0_1
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7z020clg484-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity dsp_mac_shift_reg_0_1 is
  Port ( 
    i_clk : in STD_LOGIC;
    i_reset : in STD_LOGIC;
    i_CE : in STD_LOGIC;
    i_data : in STD_LOGIC;
    o_data : out STD_LOGIC
  );

end dsp_mac_shift_reg_0_1;

architecture stub of dsp_mac_shift_reg_0_1 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "i_clk,i_reset,i_CE,i_data,o_data";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "shift_reg,Vivado 2020.1";
begin
end;
