
# =================================================
# RTL ? DC Synthesis Makefile
# Location : syn/Makefile
# Author   : Venkatesh Patil
# =================================================

# -----------------------------
# User-configurable variables
# -----------------------------
TOP        ?= regfile
DC_SHELL   ?= dc_shell
# UNIX environment variable (pwd)
WARD := $(shell pwd)

# Directories
SYN_DIR     := $(WARD)
WORK_DIR    := $(SYN_DIR)/work
SCRIPTDIR   := $(SYN_DIR)/scripts
LOGDIR      := $(SYN_DIR)/logs
RTLDIR		:= $(SYN_DIR)/rtl

export RTLDIR
# -----------------------------
# Default target
# -----------------------------
.DEFAULT_GOAL := help

# -----------------------------
# Phony targets
# -----------------------------
.PHONY: dc clean help

# -----------------------------
# DC synthesis
# -----------------------------
dc:
	@mkdir -p $(LOGDIR)
	@echo "=============================================="
	@echo " Running Design Compiler"
	@echo " Design : $(TOP)"
	@echo "=============================================="
	$(DC_SHELL) -64bit -f $(SCRIPTDIR)/dc_top.tcl \
		-x "set top_design $(TOP)" | tee $(LOGDIR)/$(TOP).dc.log

# -----------------------------
# Cleanup
# -----------------------------
clean:
	@echo "Cleaning synthesis outputs..."
	rm -rf work reports ../reports ../outputs outputs logs
	rm -rf alib* ../work
	rm -f ./alu* ./control* ./imm_gen* ./instr_mem* ./pc* ./regfile* ./riscv_core* ./data_mem*
	rm -f ./ALU* ./CONTROL* ./IMM_GEN* ./INSTR_MEM* ./PC* ./REGFILE* ./RISCV_CORE* ./DATA_MEM*
	rm -f command.log default.svf

# ------------------------------------
# Delete unwanted files
# ------------------------------------

.PHONY: clean_up_for_submission help

clean_for_submission:
	@echo "=================================================="
	@echo " Cleaning Design Compiler generated files"
	@echo " (Safe for ECE-581 submission)"
	@echo "=================================================="
	@rm -rf \
		alib-* \
		work \
		command.log \
		default.svf \
		*.pvl \
		*.syn \
		*.mr
	@echo " Cleanup complete."

# -----------------------------
# Help (supports: make help, make --help)
# -----------------------------
help:
	@echo ""
	@echo "=============================================="
	@echo " RTL ? DC Synthesis Flow"
	@echo "=============================================="
	@echo ""
	@echo "USAGE:"
	@echo "  make dc TOP=<design_name>"
	@echo ""
	@echo "VARIABLES:"
	@echo "  TOP        Top-level RTL module (default: alu)"
	@echo "  DC_SHELL   Design Compiler executable (default: dc_shell)"
	@echo "  LOGDIR     Directory for log files (default: logs)"
	@echo ""
	@echo "TARGETS:"
	@echo "  dc         Run synthesis in Synopsys DC"
	@echo "  clean      Remove all generated files"
	@echo "  make clean_for_submission - Remove tool clutter only (recommended for submission)"
	@echo "  help       Display this help message"
	@echo ""
	@echo "EXAMPLES:"
	@echo "  make dc TOP=riscv_core"
	@echo "  make dc TOP=pc"
	@echo "  make clean"
	@echo "  make clean_up_for_submission"
	@echo ""
	@echo "=============================================="
