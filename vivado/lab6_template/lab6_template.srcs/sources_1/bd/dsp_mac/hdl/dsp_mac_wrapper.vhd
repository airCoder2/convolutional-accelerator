--Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2020.1 (lin64) Build 2902540 Wed May 27 19:54:35 MDT 2020
--Date        : Sat Nov  7 16:22:29 2026
--Host        : co2050-06.ece.iastate.edu running 64-bit unknown
--Command     : generate_target dsp_mac_wrapper.bd
--Design      : dsp_mac_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity dsp_mac_wrapper is
  port (
    ACLK : in STD_LOGIC;
    ARESETN : in STD_LOGIC;
    MO_AXIS_tdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    MO_AXIS_tid : out STD_LOGIC_VECTOR ( 7 downto 0 );
    MO_AXIS_tlast : out STD_LOGIC;
    MO_AXIS_tready : in STD_LOGIC;
    MO_AXIS_tvalid : out STD_LOGIC;
    SD_AXIS_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    SD_AXIS_tid : in STD_LOGIC_VECTOR ( 7 downto 0 );
    SD_AXIS_tlast : in STD_LOGIC;
    SD_AXIS_tready : out STD_LOGIC;
    SD_AXIS_tuser : in STD_LOGIC;
    SD_AXIS_tvalid : in STD_LOGIC
  );
end dsp_mac_wrapper;

architecture STRUCTURE of dsp_mac_wrapper is
  component dsp_mac is
  port (
    ACLK : in STD_LOGIC;
    ARESETN : in STD_LOGIC;
    SD_AXIS_tid : in STD_LOGIC_VECTOR ( 7 downto 0 );
    SD_AXIS_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    SD_AXIS_tlast : in STD_LOGIC;
    SD_AXIS_tuser : in STD_LOGIC;
    SD_AXIS_tvalid : in STD_LOGIC;
    SD_AXIS_tready : out STD_LOGIC;
    MO_AXIS_tid : out STD_LOGIC_VECTOR ( 7 downto 0 );
    MO_AXIS_tdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    MO_AXIS_tlast : out STD_LOGIC;
    MO_AXIS_tvalid : out STD_LOGIC;
    MO_AXIS_tready : in STD_LOGIC
  );
  end component dsp_mac;
begin
dsp_mac_i: component dsp_mac
     port map (
      ACLK => ACLK,
      ARESETN => ARESETN,
      MO_AXIS_tdata(31 downto 0) => MO_AXIS_tdata(31 downto 0),
      MO_AXIS_tid(7 downto 0) => MO_AXIS_tid(7 downto 0),
      MO_AXIS_tlast => MO_AXIS_tlast,
      MO_AXIS_tready => MO_AXIS_tready,
      MO_AXIS_tvalid => MO_AXIS_tvalid,
      SD_AXIS_tdata(31 downto 0) => SD_AXIS_tdata(31 downto 0),
      SD_AXIS_tid(7 downto 0) => SD_AXIS_tid(7 downto 0),
      SD_AXIS_tlast => SD_AXIS_tlast,
      SD_AXIS_tready => SD_AXIS_tready,
      SD_AXIS_tuser => SD_AXIS_tuser,
      SD_AXIS_tvalid => SD_AXIS_tvalid
    );
end STRUCTURE;
