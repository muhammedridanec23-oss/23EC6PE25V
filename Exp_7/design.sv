//------------------------------------------------------------------------------
//File       : design.sv
//Author     : Muhammed Ridan (1BM23EC156)
//Created    : 2026-02-01
//Module     : siso
//Project    : SystemVerilog and Verification (23EC6PE2SV),
//Faculty    : Prof. Ajaykumar Devarapalli
//Description: 4-bit Serial-In Serial-Out (SISO) shift register.
//------------------------------------------------------------------------------

module siso (
    input  logic clk,
    input  logic si,
    output logic so
);

    logic [3:0] q;

    assign so = q[3];

    always_ff @(posedge clk)
        q <= {q[2:0], si};

endmodule
