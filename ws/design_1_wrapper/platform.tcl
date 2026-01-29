# 
# Usage: To re-create this platform project launch xsct with below options.
# xsct /home/chakra/work/dram_diag_2022/ws/design_1_wrapper/platform.tcl
# 
# OR launch xsct and run below command.
# source /home/chakra/work/dram_diag_2022/ws/design_1_wrapper/platform.tcl
# 
# To create the platform in a different location, modify the -out option of "platform create" command.
# -out option specifies the output directory of the platform project.

platform create -name {design_1_wrapper}\
-hw {/home/chakra/work/dram_diag_2022/design_1_wrapper.xsa}\
-arch {64-bit} -fsbl-target {psu_cortexa53_0} -out {/home/chakra/work/dram_diag_2022/ws}

platform write
domain create -name {standalone_psu_cortexa53_0} -display-name {standalone_psu_cortexa53_0} -os {standalone} -proc {psu_cortexa53_0} -runtime {cpp} -arch {64-bit} -support-app {zynqmp_dram_test}
platform generate -domains 
platform active {design_1_wrapper}
domain active {zynqmp_fsbl}
domain active {zynqmp_pmufw}
domain active {standalone_psu_cortexa53_0}
platform generate -quick
platform generate
