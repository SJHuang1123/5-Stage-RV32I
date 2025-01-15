package Pipeline
import chisel3._
import chisel3.util._

class BTB extends Module {
  val io = IO(new Bundle {
    val inst = Input(UInt(32.W))
    val PC = Input(UInt(32.W))
    val isBtype = Output(Bool())
    val target = Output(UInt(32.W))
  })

  // Compute immediate value
  val imm = Cat(Fill(23, io.inst(7)), io.inst(30, 26), io.inst(11, 8))

  // Compute target
  io.target := Mux(io.inst(6, 0) === "b1100011".U, io.PC + imm.asUInt, io.PC + 4.U)

  // Determine if instruction is B-type
  io.isBtype := io.inst(6, 0) === "b1100011".U
}