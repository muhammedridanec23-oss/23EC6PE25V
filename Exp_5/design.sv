//------------------------------------------------------------------------------
//File       : design.sv
//Author     : Muhammed Ridan (1BM23EC156)
//Created    : 2026-02-01
//Module     : dff
//Project    : SystemVerilog and Verification (23EC6PE2SV),
//Faculty    : Prof. Ajaykumar Devarapalli
//Description: Positive-edge triggered D Flip-Flop with asynchronous reset.
//------------------------------------------------------------------------------

module dff (
    input  logic d,
    input  logic rst,
    input  logic clk,
    output logic q
);

    always_ff @(posedge clk or posedge rst)
        if (rst)
            q <= 1'b0;
        else
            q <= d;

endmodule
