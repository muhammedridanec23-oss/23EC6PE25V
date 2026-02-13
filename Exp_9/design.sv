//------------------------------------------------------------------------------
//File       : design.sv
//Author     : Muhammed Ridan (1BM23EC156)
//Created    : 2026-02-01
//Module     : fsm_101
//Project    : SystemVerilog and Verification (23EC6PE2SV),
//Faculty    : Prof. Ajaykumar Devarapalli
//Description: Sequence detector for pattern 101 (Moore FSM).
//------------------------------------------------------------------------------

module fsm_101 (
    input  logic clk,
    input  logic rst,
    input  logic in,
    output logic out
);

    typedef enum logic [1:0] {S0, S1, S2} state_t;
    state_t state, next;

    // State register
    always_ff @(posedge clk)
        state <= rst ? S0 : next;

    // Next-state logic
    always_comb begin
        next = state;
        out  = 1'b0;

        case (state)
            S0: if (in)      next = S1;
            S1: if (!in)     next = S2;
                else         next = S1;
            S2: begin
                    if (in) begin
                        next = S1;
                        out  = 1'b1; // 101 detected
                    end else
                        next = S0;
                end
        endcase
    end

endmodule
