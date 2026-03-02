####################################################
# For ECE-581 Class
# Author: Venaktesh Patil (v.p@pdx.edu)
# Modular Script for setting up outputs from
# Synopsys DC compiler.
#
#
# #################################################

puts "INFO: Outputs"

write -hier -format verilog -output ../outputs/${top_design}.dc.vg
write -hier -format ddc     -output ../outputs/${top_design}.dc.ddc
save_upf ../outputs/${top_design}.dc.upf
