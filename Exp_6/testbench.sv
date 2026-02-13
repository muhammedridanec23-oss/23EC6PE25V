//------------------------------------------------------------------------------
//File       : testbench.sv
//Author     : Muhammed Ridan (1BM23EC156)
//Created    : 2026-02-01
//Module     : tb
//Project    : SystemVerilog and Verification (23EC6PE2SV),
//Faculty    : Prof. Ajaykumar Devarapalli
//Description: Verification of 4-bit counter rollover using transition bins.
//------------------------------------------------------------------------------

module tb;

    logic clk = 0;
    logic rst;
    logic [3:0] count;

    counter dut (.*);

    // Clock generation
    always #5 clk = ~clk;

    // Coverage with transition bin for rollover
    covergroup cg_count @(posedge clk);
        cp_val : coverpoint count {
            bins zero = {0};
            bins max  = {15};
            bins roll = (15 => 0); // Critical wrap-around check
        }
    endgroup

    cg_count cg = new();

    initial begin
        // Dump setup
        $dumpfile("counter.vcd");
        $dumpvars(0, tb);

        rst = 1;
        #20 rst = 0;

        // Run enough cycles to force wrap-around
        repeat (40) @(posedge clk);

        $display("Count coverage: %.2f %%", cg.cp_val.get_coverage());


        $finish;
    end

endmodule
