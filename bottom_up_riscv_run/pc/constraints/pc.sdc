# 1. Ensure the clock is attached to the physical port
# Replace 'clk' with the actual name of your clock port if different
create_clock [get_ports clk] -name clk -period 1.7

# 2. Check if there are any non-clock inputs (like 'reset' or 'stall')
# If you have inputs, they NEED an input delay or they will be unconstrained
set_input_delay 0.2 -clock clk [remove_from_collection [all_inputs] [get_ports clk]]

# 3. Apply output delay
# Using 1.5 is very aggressive (leaves only 0.2ns for the PC logic).
# If it fails, try 1.2 first.
set_output_delay 1.5 -clock clk [all_outputs]

# 4. Force DC to recognize the ports
set_drive 1 [all_inputs]
set_load 0.1 [all_outputs]
