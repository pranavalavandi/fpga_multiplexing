# 
# Usage: To re-create this platform project launch xsct with below options.
# xsct C:\Users\pala8831\Documents\fpga_multiplexing\zturn_base_project\vitis_project_platform\platform.tcl
# 
# OR launch xsct and run below command.
# source C:\Users\pala8831\Documents\fpga_multiplexing\zturn_base_project\vitis_project_platform\platform.tcl
# 
# To create the platform in a different location, modify the -out option of "platform create" command.
# -out option specifies the output directory of the platform project.

platform create -name {vitis_project_platform}\
-hw {C:\Users\pala8831\Documents\fpga_multiplexing\zturn_base_project\top_wrapper.xsa}\
-proc {ps7_cortexa9_0} -os {standalone} -fsbl-target {psu_cortexa53_0} -out {C:/Users/pala8831/Documents/fpga_multiplexing/zturn_base_project}

platform write
platform generate -domains 
platform active {vitis_project_platform}
platform generate
bsp reload
bsp config stdin "ps7_uart_1"
bsp config stdout "ps7_uart_1"
bsp write
bsp reload
catch {bsp regenerate}
platform generate -domains standalone_domain 
