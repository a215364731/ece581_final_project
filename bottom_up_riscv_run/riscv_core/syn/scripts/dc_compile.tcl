####################################################
# For ECE-581 Class
# Author: Venaktesh Patil (v.p@pdx.edu)
# Modular Script to compile given RTL design for 
# Synopsys DC compiler
# Preserves hierarchy
# Modify as needed.
# #################################################

puts "INFO: Compile"

set_dont_use [get_lib_cells */DELLN*]
uniquify

read_ddc ../../alu/outputs/alu.dc.ddc
read_ddc ../../control/outputs/control.dc.ddc
read_ddc ../../regfile/outputs/regfile.dc.ddc
read_ddc ../../data_mem/outputs/data_mem.dc.ddc
read_ddc ../../imm_gen/outputs/imm_gen.dc.ddc
read_ddc ../../pc/outputs/pc.dc.ddc

current_design riscv_core

link
set_dont_touch [get_designs {alu control regfile data_mem imm_gen pc}]

compile_ultra -scan

change_names -rules verilog -hierarchy
