//------------------------------------------------------------------------------
//File       : design.sv
//Author     : Muhammed Ridan (1BM23EC156)
//Created    : 2026-02-01
//Module     : alu
//Project    : SystemVerilog and Verification (23EC6PE2SV),
//Faculty    : Prof. Ajaykumar Devarapalli
//Description: Simple 8-bit ALU using enum-based opcode.
//------------------------------------------------------------------------------

typedef enum bit [1:0] {ADD, SUB, AND, OR} opcode_e;

module alu (
    input  logic  [7:0] a,
    input  logic  [7:0] b,
    input  opcode_e     op,
    output logic  [7:0] y
);

    always_comb
        case (op)
            ADD: y = a + b;
            SUB: y = a - b;
            AND: y = a & b;
            OR : y = a | b;
        endcase

endmodule
