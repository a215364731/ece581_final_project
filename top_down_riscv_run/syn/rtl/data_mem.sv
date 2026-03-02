module data_mem (
    input  wire        clk,
    input  wire        mem_read,
    input  wire        mem_write,
    input  wire [31:0] addr,
    input  wire [31:0] write_data,
    output reg  [31:0] read_data
);

    reg [31:0] memory [0:255];

    always @(posedge clk) begin
        if (mem_write)
            memory[addr[9:2]] <= write_data;

        if (mem_read)
            read_data <= memory[addr[9:2]];
    end

endmodule