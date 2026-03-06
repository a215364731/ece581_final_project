##################################################
# Top Level Synthesis Script 
# Sets up top-design name and sources scripts files
# Author: Venkatesh Patil (v.p@pdx.edu)
# ################################################
puts "=== DC TOP START ==="

if { [info exists ::env(TOP)] } {
    set top_design $::env(TOP)
} elseif { ![info exists top_design] } {
    set top_design riscv_core
}


set script_dir [file dirname [info script]]

source -echo -verbose $script_dir/dc_setup.tcl
source -echo -verbose $script_dir/dc_libraries.tcl
source -echo -verbose $script_dir/dc_analyze.tcl
source -echo -verbose $script_dir/dc_constraints.tcl
source -echo -verbose $script_dir/dc_compile.tcl
source -echo -verbose $script_dir/dc_reports.tcl
source -echo -verbose $script_dir/dc_outputs.tcl

puts "=== DC TOP END ==="
