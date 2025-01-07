module HazardDetection(
  input         clock,
                reset,
  input  [31:0] io_IF_ID_inst,
  input         io_ID_EX_memRead,
  input  [4:0]  io_ID_EX_rd,
  input  [31:0] io_pc_in,
                io_current_pc,
  output        io_inst_forward,
                io_pc_forward,
                io_ctrl_forward,
  output [31:0] io_inst_out,
                io_pc_out,
                io_current_pc_out
);

  wire io_pc_forward_0 =
    io_ID_EX_memRead
    & (io_ID_EX_rd == io_IF_ID_inst[19:15] | io_ID_EX_rd == io_IF_ID_inst[24:20]);
  assign io_inst_forward = io_pc_forward_0;
  assign io_pc_forward = io_pc_forward_0;
  assign io_ctrl_forward = io_pc_forward_0;
  assign io_inst_out = io_IF_ID_inst;
  assign io_pc_out = io_pc_in;
  assign io_current_pc_out = io_current_pc;
endmodule