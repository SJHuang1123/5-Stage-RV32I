module Dmemory_1024x32(
  input  [9:0]  R0_addr,
  input         R0_en,
                R0_clk,
  output [31:0] R0_data,
  input  [9:0]  W0_addr,
  input         W0_en,
                W0_clk,
  input  [31:0] W0_data
);

  reg [31:0] Memory[0:1023];
  always @(posedge W0_clk) begin
    if (W0_en & 1'h1)
      Memory[W0_addr] <= W0_data;
  end // always @(posedge)
  assign R0_data = R0_en ? Memory[R0_addr] : 32'bx;
endmodule

module DataMemory(
  input         clock,
                reset,
  input  [31:0] io_addr,
                io_dataIn,
  input         io_mem_read,
                io_mem_write,
  output [31:0] io_dataOut
  );

  wire [31:0] _Dmemory_ext_R0_data;
  Dmemory_1024x32 Dmemory_ext (
    .R0_addr (io_addr[9:0]),
    .R0_en   (io_mem_read),
    .R0_clk  (clock),
    .R0_data (_Dmemory_ext_R0_data),
    .W0_addr (io_addr[9:0]),
    .W0_en   (io_mem_write),
    .W0_clk  (clock),
    .W0_data (io_dataIn)
  );
  assign io_dataOut = io_mem_read ? _Dmemory_ext_R0_data : 32'h0;
endmodule