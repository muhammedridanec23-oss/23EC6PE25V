//------------------------------------------------------------------------------
//File       : design.sv
//Author     : Muhammed Ridan (1BM23EC156)
//Created    : 2026-02-01
//Module     : fifo
//Project    : SystemVerilog and Verification (23EC6PE2SV),
//Faculty    : Prof. Ajaykumar Devarapalli
//Description: Simple FIFO control logic using counter-based fullness check.
//------------------------------------------------------------------------------

module fifo (
    input  logic       clk,
    input  logic       wr,
    input  logic       rd,
    input  logic [7:0] din,
    output logic       full,
    output logic       empty
);

    logic [3:0] cnt = 0;

    assign full  = (cnt == 4'd15);
    assign empty = (cnt == 4'd0);

    always_ff @(posedge clk) begin
        if (wr && !full)
            cnt <= cnt + 1'b1;
        else if (rd && !empty)
            cnt <= cnt - 1'b1;
    end

endmodule
