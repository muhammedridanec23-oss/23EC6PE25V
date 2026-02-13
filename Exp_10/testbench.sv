//------------------------------------------------------------------------------
//File       : testbench.sv
//Author     : Muhammed Ridan (1BM23EC156)
//Created    : 2026-02-01
//Module     : tb
//Project    : SystemVerilog and Verification (23EC6PE2SV),
//Faculty    : Prof. Ajaykumar Devarapalli
//Description: Verification of traffic light sequence using sequence bins.
//------------------------------------------------------------------------------

module tb;

    logic clk = 0;
    logic rst;
    light_t color;

    traffic dut (.*);

    // Clock generation
    always #5 clk = ~clk;

    // Sequence bin coverage: enforce correct order
    covergroup cg_light @(posedge clk);
        cp_c : coverpoint color {
            bins cycle = (RED => GREEN => YELLOW => RED);
        }
    endgroup

    cg_light cg = new();

    initial begin
        // Dump setup
        $dumpfile("traffic.vcd");
        $dumpvars(0, tb);

        // Reset
        rst = 1;
        @(posedge clk);
        rst = 0;

        // Run enough cycles to complete multiple sequences
        repeat (10) @(posedge clk);

        $display("Traffic Light Sequence Coverage: %.2f %%",
                 cg.get_inst_coverage());
        $finish;
    end

endmodule
