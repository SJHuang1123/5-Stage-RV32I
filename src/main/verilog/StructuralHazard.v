module StructuralHazard(
  input        clock,
               reset,
  input  [4:0] io_rs1,
               io_rs2,
  input        io_MEM_WB_regWr,
  input  [4:0] io_MEM_WB_Rd,
  output       io_fwd_rs1,
               io_fwd_rs2
);

  assign io_fwd_rs1 = io_MEM_WB_regWr & io_MEM_WB_Rd == io_rs1;
  assign io_fwd_rs2 = io_MEM_WB_regWr & io_MEM_WB_Rd == io_rs2;
endmodule