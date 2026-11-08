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

-- IP VLNV: xilinx.com:module_ref:master_controller:1.0
-- IP Revision: 1

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY dsp_mac_master_controller_0_0 IS
  PORT (
    ACLK : IN STD_LOGIC;
    ARESETN : IN STD_LOGIC;
    SD_AXIS_TREADY : OUT STD_LOGIC;
    SD_AXIS_TDATA : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    SD_AXIS_TLAST : IN STD_LOGIC;
    SD_AXIS_TUSER : IN STD_LOGIC;
    SD_AXIS_TVALID : IN STD_LOGIC;
    SD_AXIS_TID : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    mac_A_out : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    mac_B_out : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    mac_C_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    mac_sel_out : OUT STD_LOGIC;
    mac_valid_tlast_out : OUT STD_LOGIC;
    slave_ready_in : IN STD_LOGIC
  );
END dsp_mac_master_controller_0_0;

ARCHITECTURE dsp_mac_master_controller_0_0_arch OF dsp_mac_master_controller_0_0 IS
  ATTRIBUTE DowngradeIPIdentifiedWarnings : STRING;
  ATTRIBUTE DowngradeIPIdentifiedWarnings OF dsp_mac_master_controller_0_0_arch: ARCHITECTURE IS "yes";
  COMPONENT master_controller IS
    GENERIC (
      C_DATA_WIDTH : INTEGER
    );
    PORT (
      ACLK : IN STD_LOGIC;
      ARESETN : IN STD_LOGIC;
      SD_AXIS_TREADY : OUT STD_LOGIC;
      SD_AXIS_TDATA : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      SD_AXIS_TLAST : IN STD_LOGIC;
      SD_AXIS_TUSER : IN STD_LOGIC;
      SD_AXIS_TVALID : IN STD_LOGIC;
      SD_AXIS_TID : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      mac_A_out : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      mac_B_out : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      mac_C_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      mac_sel_out : OUT STD_LOGIC;
      mac_valid_tlast_out : OUT STD_LOGIC;
      slave_ready_in : IN STD_LOGIC
    );
  END COMPONENT master_controller;
  ATTRIBUTE IP_DEFINITION_SOURCE : STRING;
  ATTRIBUTE IP_DEFINITION_SOURCE OF dsp_mac_master_controller_0_0_arch: ARCHITECTURE IS "module_ref";
  ATTRIBUTE X_INTERFACE_INFO : STRING;
  ATTRIBUTE X_INTERFACE_PARAMETER : STRING;
  ATTRIBUTE X_INTERFACE_INFO OF SD_AXIS_TID: SIGNAL IS "xilinx.com:interface:axis:1.0 SD_AXIS TID";
  ATTRIBUTE X_INTERFACE_INFO OF SD_AXIS_TVALID: SIGNAL IS "xilinx.com:interface:axis:1.0 SD_AXIS TVALID";
  ATTRIBUTE X_INTERFACE_INFO OF SD_AXIS_TUSER: SIGNAL IS "xilinx.com:interface:axis:1.0 SD_AXIS TUSER";
  ATTRIBUTE X_INTERFACE_INFO OF SD_AXIS_TLAST: SIGNAL IS "xilinx.com:interface:axis:1.0 SD_AXIS TLAST";
  ATTRIBUTE X_INTERFACE_INFO OF SD_AXIS_TDATA: SIGNAL IS "xilinx.com:interface:axis:1.0 SD_AXIS TDATA";
  ATTRIBUTE X_INTERFACE_PARAMETER OF SD_AXIS_TREADY: SIGNAL IS "XIL_INTERFACENAME SD_AXIS, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 8, TUSER_WIDTH 1, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 1, FREQ_HZ 100000000, PHASE 0.000, CLK_DOMAIN dsp_mac_ACLK_0, LAYERED_METADATA undef, INSERT_VIP 0";
  ATTRIBUTE X_INTERFACE_INFO OF SD_AXIS_TREADY: SIGNAL IS "xilinx.com:interface:axis:1.0 SD_AXIS TREADY";
  ATTRIBUTE X_INTERFACE_PARAMETER OF ARESETN: SIGNAL IS "XIL_INTERFACENAME ARESETN, POLARITY ACTIVE_LOW, INSERT_VIP 0";
  ATTRIBUTE X_INTERFACE_INFO OF ARESETN: SIGNAL IS "xilinx.com:signal:reset:1.0 ARESETN RST";
  ATTRIBUTE X_INTERFACE_PARAMETER OF ACLK: SIGNAL IS "XIL_INTERFACENAME ACLK, ASSOCIATED_BUSIF SD_AXIS, ASSOCIATED_RESET ARESETN, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.000, CLK_DOMAIN dsp_mac_ACLK_0, INSERT_VIP 0";
  ATTRIBUTE X_INTERFACE_INFO OF ACLK: SIGNAL IS "xilinx.com:signal:clock:1.0 ACLK CLK";
BEGIN
  U0 : master_controller
    GENERIC MAP (
      C_DATA_WIDTH => 8
    )
    PORT MAP (
      ACLK => ACLK,
      ARESETN => ARESETN,
      SD_AXIS_TREADY => SD_AXIS_TREADY,
      SD_AXIS_TDATA => SD_AXIS_TDATA,
      SD_AXIS_TLAST => SD_AXIS_TLAST,
      SD_AXIS_TUSER => SD_AXIS_TUSER,
      SD_AXIS_TVALID => SD_AXIS_TVALID,
      SD_AXIS_TID => SD_AXIS_TID,
      mac_A_out => mac_A_out,
      mac_B_out => mac_B_out,
      mac_C_out => mac_C_out,
      mac_sel_out => mac_sel_out,
      mac_valid_tlast_out => mac_valid_tlast_out,
      slave_ready_in => slave_ready_in
    );
END dsp_mac_master_controller_0_0_arch;
