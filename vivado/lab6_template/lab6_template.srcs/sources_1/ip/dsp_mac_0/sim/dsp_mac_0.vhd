-- (c) Copyright 1995-2026 Xilinx, Inc. All rights reserved.
-- 
-- This file contains confidential and proprietary information
-- of Xilinx, Inc. and is protected under U.S. and
-- international copyright and other intellectual property
-- laws.
-- 
-- DISCLAIMER
-- This disclaimer is not a license and does not grant any
-- rights to the materials distributed herewith. Except as
-- otherwise provided in a valid license issued to you by
-- Xilinx, and to the maximum extent permitted by applicable
-- law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
-- WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
-- AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
-- BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
-- INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
-- (2) Xilinx shall not be liable (whether in contract or tort,
-- including negligence, or under any other theory of
-- liability) for any loss or damage of any kind or nature
-- related to, arising under or in connection with these
-- materials, including for any direct, or any indirect,
-- special, incidental, or consequential loss or damage
-- (including loss of data, profits, goodwill, or any type of
-- loss or damage suffered as a result of any action brought
-- by a third party) even if such damage or loss was
-- reasonably foreseeable or Xilinx had been advised of the
-- possibility of the same.
-- 
-- CRITICAL APPLICATIONS
-- Xilinx products are not designed or intended to be fail-
-- safe, or for use in any application requiring fail-safe
-- performance, such as life-support or safety devices or
-- systems, Class III medical devices, nuclear facilities,
-- applications related to the deployment of airbags, or any
-- other applications that could lead to death, personal
-- injury, or severe property or environmental damage
-- (individually and collectively, "Critical
-- Applications"). Customer assumes the sole risk and
-- liability of any use of Xilinx products in Critical
-- Applications, subject only to applicable laws and
-- regulations governing limitations on product liability.
-- 
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
-- PART OF THIS FILE AT ALL TIMES.
-- 
-- DO NOT MODIFY THIS FILE.

-- IP VLNV: user.org:user:dsp_mac:1.0
-- IP Revision: 2

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY dsp_mac_0 IS
  PORT (
    ACLK : IN STD_LOGIC;
    ARESETN : IN STD_LOGIC;
    MO_AXIS_tdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    MO_AXIS_tid : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    MO_AXIS_tlast : OUT STD_LOGIC;
    MO_AXIS_tready : IN STD_LOGIC;
    MO_AXIS_tvalid : OUT STD_LOGIC;
    SD_AXIS_tdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    SD_AXIS_tid : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    SD_AXIS_tlast : IN STD_LOGIC;
    SD_AXIS_tready : OUT STD_LOGIC;
    SD_AXIS_tuser : IN STD_LOGIC;
    SD_AXIS_tvalid : IN STD_LOGIC
  );
END dsp_mac_0;

ARCHITECTURE dsp_mac_0_arch OF dsp_mac_0 IS
  ATTRIBUTE DowngradeIPIdentifiedWarnings : STRING;
  ATTRIBUTE DowngradeIPIdentifiedWarnings OF dsp_mac_0_arch: ARCHITECTURE IS "yes";
  COMPONENT dsp_mac IS
    PORT (
      ACLK : IN STD_LOGIC;
      ARESETN : IN STD_LOGIC;
      MO_AXIS_tdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      MO_AXIS_tid : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      MO_AXIS_tlast : OUT STD_LOGIC;
      MO_AXIS_tready : IN STD_LOGIC;
      MO_AXIS_tvalid : OUT STD_LOGIC;
      SD_AXIS_tdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      SD_AXIS_tid : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      SD_AXIS_tlast : IN STD_LOGIC;
      SD_AXIS_tready : OUT STD_LOGIC;
      SD_AXIS_tuser : IN STD_LOGIC;
      SD_AXIS_tvalid : IN STD_LOGIC
    );
  END COMPONENT dsp_mac;
  ATTRIBUTE IP_DEFINITION_SOURCE : STRING;
  ATTRIBUTE IP_DEFINITION_SOURCE OF dsp_mac_0_arch: ARCHITECTURE IS "IPI";
  ATTRIBUTE X_INTERFACE_INFO : STRING;
  ATTRIBUTE X_INTERFACE_PARAMETER : STRING;
  ATTRIBUTE X_INTERFACE_INFO OF SD_AXIS_tvalid: SIGNAL IS "xilinx.com:interface:axis:1.0 SD_AXIS TVALID";
  ATTRIBUTE X_INTERFACE_INFO OF SD_AXIS_tuser: SIGNAL IS "xilinx.com:interface:axis:1.0 SD_AXIS TUSER";
  ATTRIBUTE X_INTERFACE_INFO OF SD_AXIS_tready: SIGNAL IS "xilinx.com:interface:axis:1.0 SD_AXIS TREADY";
  ATTRIBUTE X_INTERFACE_INFO OF SD_AXIS_tlast: SIGNAL IS "xilinx.com:interface:axis:1.0 SD_AXIS TLAST";
  ATTRIBUTE X_INTERFACE_INFO OF SD_AXIS_tid: SIGNAL IS "xilinx.com:interface:axis:1.0 SD_AXIS TID";
  ATTRIBUTE X_INTERFACE_PARAMETER OF SD_AXIS_tdata: SIGNAL IS "XIL_INTERFACENAME SD_AXIS, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 8, TUSER_WIDTH 1, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 1, LAYERED_METADATA undef, FREQ_HZ 100000000, PHASE 0.000, INSERT_VIP 0";
  ATTRIBUTE X_INTERFACE_INFO OF SD_AXIS_tdata: SIGNAL IS "xilinx.com:interface:axis:1.0 SD_AXIS TDATA";
  ATTRIBUTE X_INTERFACE_INFO OF MO_AXIS_tvalid: SIGNAL IS "xilinx.com:interface:axis:1.0 MO_AXIS TVALID";
  ATTRIBUTE X_INTERFACE_INFO OF MO_AXIS_tready: SIGNAL IS "xilinx.com:interface:axis:1.0 MO_AXIS TREADY";
  ATTRIBUTE X_INTERFACE_INFO OF MO_AXIS_tlast: SIGNAL IS "xilinx.com:interface:axis:1.0 MO_AXIS TLAST";
  ATTRIBUTE X_INTERFACE_INFO OF MO_AXIS_tid: SIGNAL IS "xilinx.com:interface:axis:1.0 MO_AXIS TID";
  ATTRIBUTE X_INTERFACE_PARAMETER OF MO_AXIS_tdata: SIGNAL IS "XIL_INTERFACENAME MO_AXIS, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 8, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 1, LAYERED_METADATA undef, FREQ_HZ 100000000, PHASE 0.000, INSERT_VIP 0";
  ATTRIBUTE X_INTERFACE_INFO OF MO_AXIS_tdata: SIGNAL IS "xilinx.com:interface:axis:1.0 MO_AXIS TDATA";
  ATTRIBUTE X_INTERFACE_PARAMETER OF ARESETN: SIGNAL IS "XIL_INTERFACENAME RST.ARESETN, POLARITY ACTIVE_LOW, INSERT_VIP 0";
  ATTRIBUTE X_INTERFACE_INFO OF ARESETN: SIGNAL IS "xilinx.com:signal:reset:1.0 RST.ARESETN RST";
  ATTRIBUTE X_INTERFACE_PARAMETER OF ACLK: SIGNAL IS "XIL_INTERFACENAME CLK.ACLK, FREQ_HZ 100000000, PHASE 0.000, ASSOCIATED_BUSIF SD_AXIS:MO_AXIS, ASSOCIATED_RESET ARESETN_0:ARESETN, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0";
  ATTRIBUTE X_INTERFACE_INFO OF ACLK: SIGNAL IS "xilinx.com:signal:clock:1.0 CLK.ACLK CLK";
BEGIN
  U0 : dsp_mac
    PORT MAP (
      ACLK => ACLK,
      ARESETN => ARESETN,
      MO_AXIS_tdata => MO_AXIS_tdata,
      MO_AXIS_tid => MO_AXIS_tid,
      MO_AXIS_tlast => MO_AXIS_tlast,
      MO_AXIS_tready => MO_AXIS_tready,
      MO_AXIS_tvalid => MO_AXIS_tvalid,
      SD_AXIS_tdata => SD_AXIS_tdata,
      SD_AXIS_tid => SD_AXIS_tid,
      SD_AXIS_tlast => SD_AXIS_tlast,
      SD_AXIS_tready => SD_AXIS_tready,
      SD_AXIS_tuser => SD_AXIS_tuser,
      SD_AXIS_tvalid => SD_AXIS_tvalid
    );
END dsp_mac_0_arch;
