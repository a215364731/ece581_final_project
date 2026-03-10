# -------------------------------------------------------------------------
# 1. Clock Definition
# -------------------------------------------------------------------------
# Matching the Top-Down period of 1.41ns
# Duty cycle is 50% (0.705ns)
create_clock [get_ports clk] -name clk -period 1.41 -waveform {0 0.705}

# -------------------------------------------------------------------------
# 2. Input Delays
# -------------------------------------------------------------------------
set_input_delay 0.2 -clock clk [get_ports rst]

# 'instruction' must match the input_delay used in the Control leaf SDC (0.3ns)
# to ensure consistent timing at the top level.
set_input_delay 0.3 -clock clk [get_ports instruction[*]]

# -------------------------------------------------------------------------
# 3. Output Delays
# -------------------------------------------------------------------------
# Reduced to 0.4ns to give internal signals more time to reach the pads
set_output_delay 0.4 -clock clk [get_ports debug_pc[*]]
set_output_delay 0.4 -clock clk [get_ports debug_wb_data[*]]

# -------------------------------------------------------------------------
# 4. Environment and Design Rules
# -------------------------------------------------------------------------
set_load 0.05 [all_outputs]
set_driving_cell -lib_cell INVX2_LVT [remove_from_collection [all_inputs] [get_ports clk]]

# Crucial for hierarchical assembly to fix port-to-port connections
set_fix_multiple_port_nets -all -buffer_constants

# -------------------------------------------------------------------------
# 5. Area Constraint
# -------------------------------------------------------------------------
set_max_area 0
