module riscv_core (
    input  wire        clk,
    input  wire        rst,
    input wire [31:0] instruction,
    output wire [31:0] debug_pc,
    output wire [31:0] debug_wb_data
);

    wire [31:0] pc_current, pc_next;

    wire [4:0]  rs1, rs2, rd;
    wire [31:0] reg_data1, reg_data2;
    wire [31:0] imm;
    wire [31:0] alu_result;
    wire        zero;

    wire        reg_write;
    wire        mem_read;
    wire        mem_write;
    wire        mem_to_reg;
    wire        alu_src;
    wire        branch;
    wire [3:0]  alu_ctrl;

    wire [31:0] mem_data;
    wire [31:0] write_back;

    assign debug_pc = pc_current;
    assign debug_wb_data = write_back;

    //----------------------------------
    // PC
    //----------------------------------
    pc pc_inst (
        .clk(clk),
        .rst(rst),
        .pc_next(pc_next),
        .pc(pc_current)
    );

    assign pc_next = (branch && zero) ? pc_current + imm : pc_current + 4;

    //----------------------------------
    // Decode fields
    //----------------------------------
    assign rs1 = instruction[19:15];
    assign rs2 = instruction[24:20];
    assign rd  = instruction[11:7];

    //----------------------------------
    // Control
    //----------------------------------
    control ctrl (
        .opcode(instruction[6:0]),
        .funct3(instruction[14:12]),
        .funct7(instruction[31:25]),
        .reg_write(reg_write),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .mem_to_reg(mem_to_reg),
        .alu_src(alu_src),
        .branch(branch),
        .alu_ctrl(alu_ctrl)
    );

    //----------------------------------
    // Register File
    //----------------------------------
    regfile rf (
        .clk(clk),
        .we(reg_write),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .wd(write_back),
        .rd1(reg_data1),
        .rd2(reg_data2)
    );

    //----------------------------------
    // Immediate Generator
    //----------------------------------
    imm_gen immgen (
        .instruction(instruction),
        .imm(imm)
    );

    //----------------------------------
    // ALU
    //----------------------------------
    wire [31:0] alu_input2 = alu_src ? imm : reg_data2;

    alu alu_inst (
        .a(reg_data1),
        .b(alu_input2),
        .alu_ctrl(alu_ctrl),
        .result(alu_result),
        .zero(zero)
    );

    //----------------------------------
    // Data Memory
    //----------------------------------
    data_mem dmem (
        .clk(clk),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .addr(alu_result),
        .write_data(reg_data2),
        .read_data(mem_data)
    );

    //----------------------------------
    // Write Back
    //----------------------------------
    assign write_back = mem_to_reg ? mem_data : alu_result;

endmodule