To create a new run:
  - create new run directory
  - create constraints directory
    - create constraints file, see top_down_riscv_run/constraints/riscv_core.sdc. The file name should match your top module name
  - create syn directory
    - create rtl directory under your run directory and copy your rtl over
    - create scripts directory and copy all tcl scripts over
    - copy Makefile from top_down_riscv_run/syn