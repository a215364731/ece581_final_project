puts "INFO: Constraints"

set clk_period 1.43

# Only create clock if port exists
if {[llength [get_ports clk]] > 0} {
    create_clock -name clk -period $clk_period [get_ports clk]
}

# Apply max transition if there is at least one cell in the design
if {[llength [get_cells]] > 0} {
    set_max_transition 0.5 [current_design]
}
