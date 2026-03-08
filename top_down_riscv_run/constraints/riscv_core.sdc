
puts "INFO: Constraints"


set clk_period  1.41

create_clock -name clk -period $clk_period   [get_ports clk]

set_max_transition 0.5 [current_design]
