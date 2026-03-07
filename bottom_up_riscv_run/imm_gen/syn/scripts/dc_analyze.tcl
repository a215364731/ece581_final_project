
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
# $rtl_list should be defined in dc_setup.tcl
# -autoread automatically reads the files
# -define SYNTHESIS defines synthesis preprocessor macro

echo "analyze -format sverilog -define SYNTHESIS $rtl_list"
analyze -format sverilog -define SYNTHESIS $rtl_list

# --------------------------------------------------
# Elaborate top-level design
# --------------------------------------------------
# $top_design should be defined in dc_setup.tcl
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
# If add_ios flag is set, source the common add_ios script
# and a design-specific add_ios script
if { [info exists add_ios] && $add_ios } {
    puts "INFO: Inserting I/O pad cells"
    source $script_dir/add_ios.tcl
    source $script_dir/${top_design}.add_ios.tcl
}

puts "INFO: Analyze and Elaborate stage completed"
