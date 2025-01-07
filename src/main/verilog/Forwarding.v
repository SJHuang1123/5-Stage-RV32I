module Forwarding(
  input        clock,
               reset,
  input  [4:0] io_IDEX_rs1,
               io_IDEX_rs2,
               io_EXMEM_rd,
  input        io_EXMEM_regWr,
  input  [4:0] io_MEMWB_rd,
  input        io_MEMWB_regWr,
  output [1:0] io_forward_a,
               io_forward_b
);

  wire _GEN = io_EXMEM_regWr & (|io_EXMEM_rd);
  wire _GEN_0 = _GEN & io_EXMEM_rd == io_IDEX_rs1;
  wire _GEN_1 = io_EXMEM_rd == io_IDEX_rs2;
  wire _GEN_2 = _GEN_0 & _GEN_1;
  wire _GEN_3 = _GEN & _GEN_1;
  wire _GEN_4 = io_MEMWB_regWr & (|io_MEMWB_rd);
  wire _GEN_5 = _GEN_4 & io_MEMWB_rd == io_IDEX_rs1;
  wire _GEN_6 = io_MEMWB_rd == io_IDEX_rs2;
  wire _GEN_7 = _GEN_5 & _GEN_6 & ~_GEN_2;
  wire _GEN_8 = _GEN_4 & _GEN_6 & ~_GEN_3;
  assign io_forward_a =
    _GEN_7 | ~(_GEN_8 | ~(_GEN_5 & ~_GEN_0))
      ? 2'h1
      : _GEN_2 ? 2'h2 : _GEN_3 ? 2'h0 : {_GEN_0, 1'h0};
  assign io_forward_b = _GEN_7 | _GEN_8 ? 2'h1 : {_GEN_2 | _GEN_3, 1'h0};
endmodule