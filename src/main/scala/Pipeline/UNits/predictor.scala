package Pipeline

import chisel3._
import chisel3.util._

class Predictor extends Module {
  val io = IO(new Bundle {
    val taken = Input(Bool())
    val isBtype = Input(Bool())
    val prediction = Output(Bool())
  })

  // Define states as constants
  val StronglyTaken = 0.U(2.W)
  val WeaklyTaken = 1.U(2.W)
  val WeaklyNotTaken = 2.U(2.W)
  val StronglyNotTaken = 3.U(2.W)

  // State register
  val currentState = RegInit(StronglyNotTaken)
  val nextState = WireDefault(currentState)

  // Update current state on clock edge
  when(io.isBtype) {
    switch(currentState) {
      is(StronglyNotTaken) {
        nextState := Mux(io.taken, WeaklyNotTaken, StronglyNotTaken)
      }
      is(WeaklyNotTaken) {
        nextState := Mux(io.taken, WeaklyTaken, StronglyNotTaken)
      }
      is(WeaklyTaken) {
        nextState := Mux(io.taken, StronglyTaken, WeaklyNotTaken)
      }
      is(StronglyTaken) {
        nextState := Mux(io.taken, StronglyTaken, WeaklyTaken)
      }
    }
  }

  // Assign the current state to next state on positive edge
  currentState := nextState

  // Output prediction based on state
  io.prediction := (currentState === StronglyTaken || currentState === WeaklyTaken)
}