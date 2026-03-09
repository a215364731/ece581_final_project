# 1. Create a Virtual Clock
# This clock exists only in the timing engine, not on a physical pin.
create_clock -name vclk -period 1.7

# 2. Input Delay (Instruction Fetch Time)
# Instruction bits arrive from the Instruction Memory/Buffer.
# We assume they take ~0.4ns to become stable at the Control inputs.
set_input_delay 0.4 -clock vclk [all_inputs]

# 3. Output Delay (Time for Downstream Logic)
# Control signals (RegWrite, ALUSrc, etc.) go to the RF and ALU.
# We reserve 0.9ns for those modules to perform their tasks.
# 1.7 (Period) - 0.4 (Input) - 0.9 (Output) = 0.4ns for Control logic.
set_output_delay 0.9 -clock vclk [all_outputs]

# 4. Environment Attributes
# We use a standard inverter to drive the inputs and a small load.
set_driving_cell -lib_cell INVX2_LVT [all_inputs]
set_load 0.05 [all_outputs]

# 5. Group Paths
# This helps the report clearly show the combinational "in-to-out" paths.
group_path -name COMBO -from [all_inputs] -to [all_outputs]
