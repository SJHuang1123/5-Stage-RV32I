//> using scala "2.13.12"
//> using dep "org.chipsalliance::chisel:6.6.0"
//> using plugin "org.chipsalliance:::chisel-plugin:6.6.0"
//> using options "-unchecked", "-deprecation", "-language:reflectiveCalls", "-feature", "-Xcheckinit", "-Xfatal-warnings", "-Ywarn-dead-code", "-Ywarn-unused", "-Ymacro-annotations"

import chisel3._
// _root_ disambiguates from package chisel3.util.circt if user imports chisel3.util._
import _root_.circt.stage.ChiselStage

import chisel3.util.experimental.loadMemoryFromFile

class InstMem(initFile: String) extends Module {
  val io = IO(new Bundle {
    val addr        =   Input(UInt(32.W))       // Address input to fetch instruction
    val data        =   Output(UInt(32.W))      // Output instruction
  })
  val imem = Mem(1024, UInt(32.W))
  loadMemoryFromFile(imem, initFile)
  io.data := imem(io.addr/4.U)
}

object Main extends App {
  println(
    ChiselStage.emitSystemVerilog(
      gen = new InstMem("test.txt"),
      firtoolOpts = Array("-disable-all-randomization", "-strip-debug-info")
    )
  )
}
