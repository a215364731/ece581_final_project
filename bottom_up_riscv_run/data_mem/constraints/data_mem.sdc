# 1. Create the Clock
create_clock [get_ports clk] -name clk -period 1.7

# 2. Relaxed Input Delay
# We are reducing this from 1.0 to 0.5ns. 
# This gives the DMEM 1.2ns of internal time instead of 0.7ns.
set_input_delay 0.5 -clock clk [remove_from_collection [all_inputs] [get_ports clk]]

# 3. Aggressive Output Delay
# We keep this at 0.5ns to ensure the read data can travel back to the RF.
set_output_delay 0.5 -clock clk [all_outputs]

# 4. Driving Cell & Load (More realistic for SAED32 library)
# Instead of set_drive 1, using a specific library cell is more accurate.
set_driving_cell -lib_cell INVX2_LVT [remove_from_collection [all_inputs] [get_ports clk]]
set_load 0.05 [all_outputs]

# 5. Optional: Area Constraint
# Since memories can bloat, you can set a max area if needed.
# set_max_area 0
