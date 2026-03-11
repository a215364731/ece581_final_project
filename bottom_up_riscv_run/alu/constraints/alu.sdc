# 1. Create a Virtual Clock
# Updated to match your Top-Down "barely failing" period
create_clock -name vclk -period 1.41

# 2. Input Delay (Instruction Fetch)
# We assume Instruction Memory is fast; data arrives 0.3ns into the cycle.
set_input_delay 0.1 -clock vclk [all_inputs]

# 3. Output Delay (Time reserved for ALU, RF, and DMEM)
# We increase this slightly relative to the period. 
# This gives downstream modules 0.81ns to complete their work.
set_output_delay 0.5 -clock vclk [all_outputs]

# 4. Environment Attributes
set_driving_cell -lib_cell INVX2_LVT [all_inputs]
set_load 0.05 [all_outputs]

# 5. Group Paths
group_path -name COMBO -from [all_inputs] -to [all_outputs]
