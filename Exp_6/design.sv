//------------------------------------------------------------------------------
//File       : design.sv
//Author     : Muhammed Ridan (1BM23EC156)
//Created    : 2026-02-01
//Module     : counter
//Project    : SystemVerilog and Verification (23EC6PE2SV),
//Faculty    : Prof. Ajaykumar Devarapalli
//Description: 4-bit synchronous up-counter with reset.
//------------------------------------------------------------------------------

module counter (
    input  logic       clk,
    input  logic       rst,
    output logic [3:0] count
);

    always_ff @(posedge clk)
        if (rst)
            count <= 4'd0;
        else
            count <= count + 1'b1;

endmodule
