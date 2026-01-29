# Usage with Vitis IDE:
# In Vitis IDE create a Single Application Debug launch configuration,
# change the debug type to 'Attach to running target' and provide this 
# tcl script in 'Execute Script' option.
# Path of this script: /home/chakra/work/dram_diag_2022/ws/dram_diag_system/_ide/scripts/debugger_dram_diag-default.tcl
# 
# 
# Usage with xsct:
# To debug using xsct, launch xsct and run below command
# source /home/chakra/work/dram_diag_2022/ws/dram_diag_system/_ide/scripts/debugger_dram_diag-default.tcl
# 
connect -url tcp:127.0.0.1:3121
source /tools/Xilinx/Vitis/2022.1/scripts/vitis/util/zynqmp_utils.tcl
targets -set -nocase -filter {name =~"APU*" && jtag_cable_name =~ "Digilent JTAG-HS2 210249993013" && jtag_device_ctx=="jsn-JTAG-HS2-210249993013-5ba00477-0"}
rst -system
after 3000
targets -set -nocase -filter {name =~"APU*" && jtag_cable_name =~ "Digilent JTAG-HS2 210249993013" && jtag_device_ctx=="jsn-JTAG-HS2-210249993013-5ba00477-0"}
loadhw -hw /home/chakra/work/dram_diag_2022/ws/design_1_wrapper/export/design_1_wrapper/hw/design_1_wrapper.xsa -mem-ranges [list {0x80000000 0xbfffffff} {0x400000000 0x5ffffffff} {0x1000000000 0x7fffffffff}] -regs
configparams force-mem-access 1
targets -set -nocase -filter {name =~"APU*" && jtag_cable_name =~ "Digilent JTAG-HS2 210249993013" && jtag_device_ctx=="jsn-JTAG-HS2-210249993013-5ba00477-0"}
set mode [expr [mrd -value 0xFF5E0200] & 0xf]
targets -set -nocase -filter {name =~ "*A53*#0" && jtag_cable_name =~ "Digilent JTAG-HS2 210249993013" && jtag_device_ctx=="jsn-JTAG-HS2-210249993013-5ba00477-0"}
rst -processor
dow /home/chakra/work/dram_diag_2022/ws/design_1_wrapper/export/design_1_wrapper/sw/design_1_wrapper/boot/fsbl.elf
set bp_40_43_fsbl_bp [bpadd -addr &XFsbl_Exit]
con -block -timeout 60
bpremove $bp_40_43_fsbl_bp
targets -set -nocase -filter {name =~ "*A53*#0" && jtag_cable_name =~ "Digilent JTAG-HS2 210249993013" && jtag_device_ctx=="jsn-JTAG-HS2-210249993013-5ba00477-0"}
rst -processor
dow /home/chakra/work/dram_diag_2022/ws/dram_diag/Debug/dram_diag.elf
configparams force-mem-access 0
targets -set -nocase -filter {name =~ "*A53*#0" && jtag_cable_name =~ "Digilent JTAG-HS2 210249993013" && jtag_device_ctx=="jsn-JTAG-HS2-210249993013-5ba00477-0"}
con
