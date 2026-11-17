#
# This file was created by Xilinx Vitis tool.
#


#
# tools
#

RM = rm -f
RMDIR = rm -rf



#
# variables
#

SDCARD_GEN = sdcard_gen
GENERATE_BIF = ::scw::generate_bif

XPFM_PATH = /home/umhaihl/machine_learning/lab7/cpp_stuff/workspace/sw_test_platform/export/sw_test_platform/sw_test_platform.xpfm
SYS_CONFIG = sw_test_platform
DOMAINS = standalone_domain
BIF_PATH = /home/umhaihl/machine_learning/lab7/cpp_stuff/workspace/sw_test_system/Debug/system.bif

BITSTREAM_PATH = /home/umhaihl/machine_learning/lab7/cpp_stuff/workspace/sw_test/_ide/bitstream/inshaAllah_last_xsa.bit
SD_FILES = --elf /home/umhaihl/machine_learning/lab7/cpp_stuff/workspace/sw_test/Debug/sw_test.elf,ps7_cortexa9_0

GENERATE_BIF_XSCT_CMD = ${GENERATE_BIF} -xpfm ${XPFM_PATH} -domains ${DOMAINS} -bifpath ${BIF_PATH}

#
# primary build targets
#

all: package

package:
	-@echo Generating bif file for the system project
	-@echo Executing command \'${GENERATE_BIF_XSCT_CMD}\' on XSCT
	-@echo "connect -u TCP:localhost:40829; tcf send_command $$::xsdb::curchan xsdb eval s es [list \"${GENERATE_BIF_XSCT_CMD}\"]" | xsct
	${SDCARD_GEN} --xpfm ${XPFM_PATH} --sys_config ${SYS_CONFIG} --bif ${BIF_PATH} --bitstream ${BITSTREAM_PATH} ${SD_FILES}

clean:
	$(RMDIR) ./_sds
	${RMDIR} package
	${RM} system.bif

.PHONY: all package clean


