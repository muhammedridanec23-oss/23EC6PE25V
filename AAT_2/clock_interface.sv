// -----------------------------------------------------------------------------
// File        : clock_interface.sv
// Author      : Muhammed Ridan (1BM23EC156)
// Created     : 2026-02-28
// Module      : clock_interface
// Project     : SystemVerilog and Verification (23EC6PE2SV),
//               Faculty: Prof. Ajaykumar Devarapalli
// Description : Digital clock interface module
// -----------------------------------------------------------------------------

interface clock_interface (input logic clk);

    logic reset;
    logic [5:0] seconds;
    logic [5:0] minutes;

    modport DUT (
        input  clk,
        input  reset,
        output seconds,
        output minutes
    );

    modport TB (
        input  clk,
        output reset,
        input  seconds,
        input  minutes
    );

endinterface