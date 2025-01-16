package Pipeline
import chisel3._
import chisel3.util._

class Branch extends Module {
  val io = IO(new Bundle {
    val fnct3 = Input(UInt(3.W))
    val branch = Input(Bool())
    val arg_x = Input(SInt(32.W))
    val arg_y = Input(SInt(32.W))
    val pred = Input(Bool())   // predicted result of whether branch is taken or not
    val actual = Output(Bool()) // actual result of whether branch is taken or not
    val flush = Output(Bool())
  })
  io.actual := false.B
  io.flush := false.B
  val temp = WireDefault(false.B)  
  when(io.branch) {
    // beq
    when(io.fnct3 === 0.U) {
      io.actual := io.arg_x === io.arg_y
      temp := io.arg_x === io.arg_y
    }
    // bne
    .elsewhen(io.fnct3 === 1.U) {
      io.actual := io.arg_x =/= io.arg_y
      temp := io.arg_x =/= io.arg_y
    }
    // blt
    .elsewhen(io.fnct3 === 4.U) {
      io.actual := io.arg_x < io.arg_y
      temp := io.arg_x < io.arg_y
    }
    // bge
    .elsewhen(io.fnct3 === 5.U) {
      io.actual := io.arg_x >= io.arg_y
      temp := io.arg_x >= io.arg_y
    }
    // bltu (unsigned less than)
    .elsewhen(io.fnct3 === 6.U) {
      io.actual := io.arg_x.asUInt < io.arg_y.asUInt
      temp := io.arg_x < io.arg_y
    }
    // bgeu (unsigned greater than or equal)
    .elsewhen(io.fnct3 === 7.U) {
      io.actual := io.arg_x.asUInt >= io.arg_y.asUInt
      temp := io.arg_x >= io.arg_y
    }
    io.flush := io.pred ^ temp
  }
}
