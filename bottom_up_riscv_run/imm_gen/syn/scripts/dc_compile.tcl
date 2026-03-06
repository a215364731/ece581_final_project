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

compile_ultra -scan

change_names -rules verilog -hierarchy
