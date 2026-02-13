//------------------------------------------------------------------------------
//File       : testbench.sv
//Author     : Muhammed Ridan (1BM23EC156)
//Created    : 2026-02-01
//Module     : tb
//Project    : SystemVerilog and Verification (23EC6PE2SV),
//Faculty    : Prof. Ajaykumar Devarapalli
//Description: FIFO verification using SystemVerilog interface and coverage.
//------------------------------------------------------------------------------

interface fifo_if (input logic clk);
    logic wr, rd;
    logic full, empty;
    logic [7:0] din;
endinterface

module tb;

    bit clk = 0;
    always #5 clk = ~clk;

    fifo_if vif (clk);

    fifo dut (
        .clk   (clk),
        .wr    (vif.wr),
        .rd    (vif.rd),
        .din   (vif.din),
        .full  (vif.full),
        .empty (vif.empty)
    );

    // Coverage: attempt write when FIFO is full
    covergroup cg_fifo @(posedge clk);
        cross_wr_full : cross vif.wr, vif.full;
    endgroup

    cg_fifo cg = new();

    initial begin
        // Dump setup
        $dumpfile("fifo.vcd");
        $dumpvars(0, tb);

        vif.rd  = 0;
        vif.din = 8'h00;

        // Fill FIFO
        vif.wr = 1;
        repeat (18) @(posedge clk);

        // Hold full without writing (CRUCIAL for coverage)
        vif.wr = 0;
        repeat (3) @(posedge clk);

        $display("Coverage: %.2f %%", cg.get_inst_coverage());
        $finish;
    end


endmodule
