--Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2020.1 (lin64) Build 2902540 Wed May 27 19:54:35 MDT 2020
--Date        : Sun Nov  8 04:17:09 2026
--Host        : co2050-06.ece.iastate.edu running 64-bit unknown
--Command     : generate_target axis_dsp_mac_wrapper.bd
--Design      : axis_dsp_mac_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity axis_dsp_mac_wrapper is
  port (
    ACLK : in STD_LOGIC;
    ARESETN : in STD_LOGIC;
    M_AXIS_tdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXIS_tlast : out STD_LOGIC;
    M_AXIS_tready : in STD_LOGIC;
    M_AXIS_tvalid : out STD_LOGIC;
    S_AXIS_tdata : in STD_LOGIC_VECTOR ( 15 downto 0 );
    S_AXIS_tlast : in STD_LOGIC;
    S_AXIS_tready : out STD_LOGIC;
    S_AXIS_tvalid : in STD_LOGIC;
    bias : in STD_LOGIC_VECTOR ( 31 downto 0 )
  );
end axis_dsp_mac_wrapper;

architecture STRUCTURE of axis_dsp_mac_wrapper is
  component axis_dsp_mac is
  port (
    ACLK : in STD_LOGIC;
    ARESETN : in STD_LOGIC;
    bias : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXIS_tdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXIS_tlast : out STD_LOGIC;
    M_AXIS_tvalid : out STD_LOGIC;
    M_AXIS_tready : in STD_LOGIC;
    S_AXIS_tdata : in STD_LOGIC_VECTOR ( 15 downto 0 );
    S_AXIS_tlast : in STD_LOGIC;
    S_AXIS_tvalid : in STD_LOGIC;
    S_AXIS_tready : out STD_LOGIC
  );
  end component axis_dsp_mac;
begin
axis_dsp_mac_i: component axis_dsp_mac
     port map (
      ACLK => ACLK,
      ARESETN => ARESETN,
      M_AXIS_tdata(31 downto 0) => M_AXIS_tdata(31 downto 0),
      M_AXIS_tlast => M_AXIS_tlast,
      M_AXIS_tready => M_AXIS_tready,
      M_AXIS_tvalid => M_AXIS_tvalid,
      S_AXIS_tdata(15 downto 0) => S_AXIS_tdata(15 downto 0),
      S_AXIS_tlast => S_AXIS_tlast,
      S_AXIS_tready => S_AXIS_tready,
      S_AXIS_tvalid => S_AXIS_tvalid,
      bias(31 downto 0) => bias(31 downto 0)
    );
end STRUCTURE;
