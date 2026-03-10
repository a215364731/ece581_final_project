# 1. Clock Definition
# Using the 1.41ns period to match your Top-Down baseline
create_clock [get_ports clk] -name clk -period 1.41

# 2. Input Delay
# Keeping this at 0.2ns. This is the time for 'rst' to arrive.
set_input_delay 0.2 -clock clk [remove_from_collection [all_inputs] [get_ports clk]]

# 3. Output Delay (The Budget Adjustment)
# Old logic: 1.7 - 1.5 = 0.2ns logic window.
# New logic: 1.41 - 1.2 = 0.21ns logic window.
# We must reduce the output delay to stay within the 1.41ns cycle.
set_output_delay 1.2 -clock clk [all_outputs]

# 4. Environment
set_drive 1 [all_inputs]
set_load 0.1 [all_outputs]
