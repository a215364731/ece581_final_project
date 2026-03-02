module control (
    input  wire [6:0] opcode,
    input  wire [2:0] funct3,
    input  wire [6:0] funct7,
    output reg        reg_write,
    output reg        mem_read,
    output reg        mem_write,
    output reg        mem_to_reg,
    output reg        alu_src,
    output reg        branch,
    output reg [3:0]  alu_ctrl
);

    always @(*) begin
        // Default values
        reg_write = 0;
        mem_read  = 0;
        mem_write = 0;
        mem_to_reg= 0;
        alu_src   = 0;
        branch    = 0;
        alu_ctrl  = 4'b0000;

        case (opcode)

            7'b0110011: begin // R-type
                reg_write = 1;
                case ({funct7, funct3})
                    10'b0000000_000: alu_ctrl = 4'b0000; // ADD
                    10'b0100000_000: alu_ctrl = 4'b0001; // SUB
                    10'b0000000_111: alu_ctrl = 4'b0010; // AND
                    10'b0000000_110: alu_ctrl = 4'b0011; // OR
                    default: alu_ctrl = 4'b0000;
                endcase
            end

            7'b0010011: begin // ADDI
                reg_write = 1;
                alu_src   = 1;
                alu_ctrl  = 4'b0000;
            end

            7'b0000011: begin // LW
                reg_write = 1;
                mem_read  = 1;
                mem_to_reg= 1;
                alu_src   = 1;
                alu_ctrl  = 4'b0000;
            end

            7'b0100011: begin // SW
                mem_write = 1;
                alu_src   = 1;
                alu_ctrl  = 4'b0000;
            end

            7'b1100011: begin // BEQ
                branch   = 1;
                alu_ctrl = 4'b0001;
            end

        endcase
    end

endmodule