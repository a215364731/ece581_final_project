# 1. Create the Clock
# Period updated to match the Top-Down "barely failing" point
create_clock [get_ports clk] -name clk -period 1.41

# 2. Input Delay
# Lowered to 0.4ns. This assumes the ALU/Control are very fast.
# Internal logic window: 1.41 - 0.4 (input) - 0.4 (output) = 0.61ns.
set_input_delay 0.4 -clock clk [remove_from_collection [all_inputs] [get_ports clk]]

# 3. Output Delay
# Lowered to 0.4ns to give the memory more internal time to meet 1.41ns.
set_output_delay 0.4 -clock clk [all_outputs]

# 4. Driving Cell & Load
set_driving_cell -lib_cell INVX2_LVT [remove_from_collection [all_inputs] [get_ports clk]]
set_load 0.05 [all_outputs]

# 5. Area Constraint
set_max_area 0
