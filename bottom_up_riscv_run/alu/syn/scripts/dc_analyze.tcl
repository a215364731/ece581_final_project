####################################################
# For ECE-581 Class
# Author: Venkatesh Patil (v.p@pdx.edu)
# Modular Script: Analyze and Elaborate RTL
# for Synopsys Design Compiler (DC)
# Sources I/O insertion scripts if enabled
####################################################

puts "INFO: Starting Analyze and Elaborate stage"

# --------------------------------------------------
# Analyze the RTL
# --------------------------------------------------
echo "analyze -format sverilog -define SYNTHESIS $rtl_list"
analyze -format sverilog -define SYNTHESIS $rtl_list

# --------------------------------------------------
# Elaborate top-level design
# --------------------------------------------------
elaborate $top_design
current_design $top_design
link

# --------------------------------------------------
# Standardize names for hierarchical output
# --------------------------------------------------
change_names -rules verilog -hierarchy

# --------------------------------------------------
# Optional: Insert I/O pad cells
# --------------------------------------------------
if { [info exists add_ios] && $add_ios } {
    puts "INFO: Inserting I/O pad cells"
    source $script_dir/add_ios.tcl
    source $script_dir/${top_design}.add_ios.tcl
}

puts "INFO: Analyze and Elaborate stage completed"
