package Pipeline
import chisel3._
import chisel3.util._

class PCSelector extends Module {
  val io = IO(new Bundle {
    val isBtype = Input(Bool())
    val PC4_new = Input(UInt(32.W))
    val PC4_old = Input(UInt(32.W))
    val target_old = Input(UInt(32.W))
    val target_new = Input(UInt(32.W))
    val prediction = Input(Bool())
    val actual = Input(Bool())
    val flush = Input(Bool())
    val PC = Output(UInt(32.W))
  })

  // Default value for PC
  io.PC := 0.U

  when(io.flush) {
    io.PC := Mux(io.actual, io.target_old, io.PC4_old)
  }.otherwise {
    when(io.isBtype) {
      io.PC := Mux(io.prediction, io.target_new, io.PC4_new)
    }.otherwise {
      io.PC := io.PC4_new
    }
  }
}
