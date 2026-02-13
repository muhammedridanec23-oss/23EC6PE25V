//------------------------------------------------------------------------------
//File       : design.sv
//Author     : Muhammed Ridan (1BM23EC156)
//Created    : 2026-02-01
//Module     : mux2to1
//Project    : SystemVerilog and Verification (23EC6PE2SV),
//Faculty    : Prof. Ajaykumar Devarapalli
//Description: 2-input Multipexer used for basic functional coverage example.
//------------------------------------------------------------------------------

module mux2to1 (
  input logic [7:0] a, b,
  input logic sel,
  output logic [7:0] y
);
  assign y = sel ? b : a;
endmodule