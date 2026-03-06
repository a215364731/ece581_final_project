
####################################################
# For ECE-581 Class
# Author: Venkatesh Patil (v.p@pdx.edu)
# Modular Script: Setup libraries for Synopsys DC
# Configures target and link libraries for synthesis
####################################################

puts "INFO: Setting up libraries..."

# --------------------------------------------------
# Base library directories
# --------------------------------------------------
# lib_dir should be a common variable defined in dc_setup.tcl
# synthetic_library is the DW Foundation library for synthesis
set lib_dir /pkgs/synopsys/2020/32_28nm/SAED32_EDK/lib
set synthetic_library /pkgs/synopsys/2020/design_compiler/syn/Q-2019.12-SP3/libraries/syn/dw_foundation.sldb

# --------------------------------------------------
# Construct search path for all library types
# --------------------------------------------------
# lib_types should be defined in dc_setup.tcl
set search_path ""
foreach lib $lib_types { lappend search_path $lib }
# Add local directory at the end of search path
lappend search_path .

# --------------------------------------------------
# Construct link_library for Design Compiler
# Includes all standard cells, I/Os, SRAMs, PLLs, and DW Foundation
# --------------------------------------------------
set link_library ""
foreach path $search_path {
    foreach corner $synth_corners {
        foreach sublib $sub_lib_type {
            foreach dbfile [glob -nocomplain $path/$sublib$corner.db] {
                lappend link_library $dbfile
            }
        }
    }
}
# Append DW Foundation and wildcard for other libraries
lappend link_library $synthetic_library *
# Apply to DC
set_app_var link_library $link_library

# --------------------------------------------------
# Construct target_library for synthesis output
# Only includes target corner libraries (HVT/RVT)
# --------------------------------------------------
set target_library ""
foreach path $lib_types_target {
    foreach corner $synth_corners_target {
        foreach sublib $sub_lib_type_target {
            foreach dbfile [glob -nocomplain $path/$sublib$corner*.db] {
                lappend target_library $dbfile
            }
        }
    }
}
set_app_var target_library $target_library

# include  R/V/L VT libraries explicitly as needed.
lappend link_library $lib_dir/stdcell_rvt/db_nldm/saed32rvt_ss0p95v125c.db
lappend link_library $lib_dir/stdcell_hvt/db_nldm/saed32hvt_ss0p95v125c.db
lappend link_library $lib_dir/stdcell_lvt/db_nldm/saed32lvt_ss0p95v125c.db
puts "INFO: Library setup completed"
