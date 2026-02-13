//------------------------------------------------------------------------------
// File        : testbench.sv
// Author      : Muhammed Ridan (1BM23EC156)
// Created     : 2026-01-28
// Module      : tb
// Project     : SystemVerilog and Verification (23EC6PE2SV),
//               Faculty: Prof. Ajaykumar Devarapalli
// Description : Simple testbench for and_gate. Randomizes inputs and uses a
//               covergroup to measure input combination coverage.
//------------------------------------------------------------------------------
`timescale 1ns/1ps

module tb;

    logic a, b, y;
    and_gate dut(.*);   // Implicit port connection by signal name

    covergroup cg_and;
        cp_a     : coverpoint a;
        cp_b     : coverpoint b;
        cross_ab : cross cp_a, cp_b; // Tracks all (a,b) input combinations
    endgroup

    cg_and cg;          // Covergroup handle

    initial begin
        $dumpfile("dump.vcd"); // Enables waveform viewing (GTKWave)
        $dumpvars;

        cg = new();     // Create covergroup instance

        repeat (20) begin
            a = $urandom();
            b = $urandom();
            #5;
            cg.sample(); // Records coverage for current values
        end

        $display("Final Coverage = %0.2f %%", cg.get_inst_coverage());
    end

endmodule

