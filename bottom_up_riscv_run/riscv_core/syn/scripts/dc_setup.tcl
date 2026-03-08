
####################################################
# For ECE-581 Class
# Author: Venkatesh Patil (v.p@pdx.edu)
# Modular Script: Initialization and setup for DC
# Sets design-independent variables: corners, libs, RTL, clocks, directories
####################################################

puts "INFO: Setup and reset"

# --------------------------------------------------
# Reset previous designs if any
# --------------------------------------------------
if { [list_designs] != 0 } {
    reset_design
    remove_design -designs
}

# --------------------------------------------------
# Design / Flow Options
# --------------------------------------------------
# These control optional features of the flow
set add_ios 0                        ;# Insert IO pad cells
set pad_design 1                      ;# Pad the design
set dc_floorplanning 1                ;# Enable floorplanning
set enable_dft 0                      ;# Enable DFT (0 = off)
set innovus_enable_manual_macro_placement 0 ;# Manual macro placement in Innovus

set design_size {580 580}             ;# Width x Height of the design
set design_io_border 310              ;# Border for IO placement

# --------------------------------------------------
# Library base directory
# --------------------------------------------------
# Can override via environment variable LIB_DIR
if { [info exists ::env(LIB_DIR)] } {
    set lib_dir $::env(LIB_DIR)
} else {
    set lib_dir /pkgs/synopsys/2020/32_28nm/SAED32_EDK/lib
}

# --------------------------------------------------
# RTL Files
# --------------------------------------------------
# List of RTL files for the design
# top_design must be set in top-level script or Makefile

# --------------------------------------------------
# RTL directory (from Makefile)
# --------------------------------------------------
if { [info exists ::env(RTLDIR)] } {
    set rtl_dir $::env(RTLDIR)
} else {
    error "RTLDIR not set. Run DC via Makefile."
}

puts "INFO: RTL directory = $rtl_dir"
set rtl_list [list ${rtl_dir}/${top_design}.sv ]

# --------------------------------------------------
# Corner / Timing settings
# --------------------------------------------------
set slow_corner "ss0p95v125c_2p25v ss0p95v125c ss0p75v125c_i0p75v"
set fast_corner "ff0p95vn40c ff1p16vn40c_2p75v ff1p16vn40c"

set synth_corners $slow_corner
set synth_corners_target "ss0p95v125c"
set synth_corners_slow $slow_corner
set synth_corners_fast $fast_corner

set slow_metal Cmax_125
set fast_metal Cmax_125

# --------------------------------------------------
# Library types for DC
# --------------------------------------------------
# Libraries used in link_library and target_library
set lib_types "$lib_dir/io_std/db_nldm $lib_dir/sram_lp/db_nldm $lib_dir/pll/db_nldm"
set ndm_types "$lib_dir/stdcell_rvt/ndm $lib_dir/stdcell_hvt/ndm $lib_dir/sram_lp/ndm $lib_dir/io_std/ndm $lib_dir/pll/ndm"

# Enable for NLDM libraries
set lib_types_target {}
lappend lib_types_target "$lib_dir/stdcell_rvt/db_nldm"
lappend lib_types_target "$lib_dir/stdcell_hvt/db_nldm"
lappend lib_types_target "$lib_dir/stdcell_lvt/db_nldm"


# Enable for CCS libraries
#set lib_types_target {}
#lappend lib_types_target "$lib_dir/stdcell_rvt/db_ccs"
#lappend lib_types_target "$lib_dir/stdcell_hvt/db_ccs"
#lappend lib_types_target "$lib_dir/stdcell_lvt/db_ccs"


set sub_lib_type "saed32?vt_ saed32sramlp_ saed32io_wb_ saed32pll_"

# Choose Multi-vt target library
set sub_lib_type_target {}
lappend sub_lib_type_target "saed32rvt_"
lappend sub_lib_type_target "saed32hvt_"
lappend sub_lib_type_target "saed32lvt_"


# LEF files for floorplanning
set lef_types [list \ 
    $lib_dir/stdcell_hvt/lef \
    $lib_dir/stdcell_rvt/lef \
    $lib_dir/stdcell_lvt/lef \
    $lib_dir/sram_lp/lef \
    $lib_dir/io_std/lef \
    $lib_dir/pll/lef \
]
set sub_lef_type "saed32nm_?vt_*.lef saed32_sram_lp_*.lef saed32io_std_wb saed32_PLL.lef"

# Milkyway libraries for ICC2 / DC
set mwlib_types [list \
    $lib_dir/stdcell_hvt/milkyway \
    $lib_dir/stdcell_rvt/milkyway \
    $lib_dir/stdcell_lvt/milkyway \
    $lib_dir/io_std/milkyway \
    $lib_dir/sram_lp/milkyway \
    $lib_dir/pll/milkyway \
]
set sub_mwlib_type "saed32nm_?vt_* saed32sram_lp saed32io_wb_* SAED32_PLL_FR*"

# --------------------------------------------------
# Project directories
# --------------------------------------------------
file mkdir ../work
file mkdir ../reports
file mkdir ../outputs

puts "INFO: DC setup complete for ${top_design}"
