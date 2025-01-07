module PC (
    input [31:0] in,
    input clk,
    input reset,
    output [31:0] out,
);
    reg [31:0] PC;
    always @(posedge clk or reset) begin
        if(reset) PC = 32'b0;
        else PC <= in;
    end
    assign out = PC;
endmodule