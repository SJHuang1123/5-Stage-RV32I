module BranchForward(
  input        clock,
               reset,
  input  [4:0] io_ID_EX_RD,
               io_EX_MEM_RD,
               io_MEM_WB_RD,
  input        io_ID_EX_memRd,
               io_EX_MEM_memRd,
               io_MEM_WB_memRd,
  input  [4:0] io_rs1,
               io_rs2,
  input        io_ctrl_branch,
  output [3:0] io_forward_rs1,
               io_forward_rs2
);
    wire _GEN = (|io_ID_EX_RD) & ~io_ID_EX_memRd;
    wire _GEN_0 = io_ID_EX_RD == io_rs1;
    wire _GEN_1 = io_ID_EX_RD == io_rs2;
    wire _GEN_2 = _GEN_0 & _GEN_1;
    wire _GEN_3 = (|io_EX_MEM_RD) & ~io_EX_MEM_memRd;
    wire _GEN_4 = io_EX_MEM_RD == io_rs1;
    wire _GEN_5 = io_EX_MEM_RD == io_rs2;
    wire _GEN_6 = (|io_ID_EX_RD) & _GEN_0;
    wire _GEN_7 = _GEN_6 & _GEN_1;
    wire _GEN_8 = _GEN_4 & _GEN_5 & ~_GEN_7;
    wire _GEN_9 = _GEN_4 & ~_GEN_6;
    wire _GEN_10 = (|io_ID_EX_RD) & _GEN_1;
    wire _GEN_11 = (|io_MEM_WB_RD) & ~io_MEM_WB_memRd;
    wire _GEN_12 = io_MEM_WB_RD == io_rs1;
    wire _GEN_13 = io_MEM_WB_RD == io_rs2;
    wire _GEN_14 = (|io_EX_MEM_RD) & _GEN_4;
    wire _GEN_15 = _GEN_12 & _GEN_13 & ~_GEN_7 & ~(_GEN_14 & _GEN_5);
    wire _GEN_16 = _GEN_12 & ~_GEN_6 & ~_GEN_14;
    assign io_forward_rs1 =
    io_ctrl_branch
      ? (_GEN_11 & (_GEN_15 | _GEN_16)
           ? 4'h3
           : _GEN_3 & (_GEN_8 | _GEN_9) ? 4'h2 : {3'h0, _GEN & (_GEN_2 | _GEN_0)})
      : _GEN & _GEN_0
          ? 4'h6
          : _GEN_3 & _GEN_4 & ~_GEN_6
              ? 4'h7
              : (|io_EX_MEM_RD) & io_EX_MEM_memRd & _GEN_4 & ~_GEN_6
                  ? 4'h9
                  : _GEN_11 & _GEN_12 & ~_GEN_6 & ~_GEN_14
                      ? 4'h8
                      : (|io_MEM_WB_RD) & io_MEM_WB_memRd & _GEN_12 & ~_GEN_6 & ~_GEN_14
                          ? 4'hA
                          : 4'h0;
    assign io_forward_rs2 =
        io_ctrl_branch
        ? (_GEN_11
            & (_GEN_15 | ~(_GEN_16 | ~(_GEN_13 & ~_GEN_10 & ~((|io_EX_MEM_RD) & _GEN_5))))
            ? 4'h3
            : _GEN_3 & (_GEN_8 | ~(_GEN_9 | ~(_GEN_5 & ~_GEN_10)))
                ? 4'h2
                : _GEN ? (_GEN_2 ? 4'h1 : _GEN_0 ? 4'h0 : {3'h0, _GEN_1}) : 4'h0)
        : 4'h0;
endmodule