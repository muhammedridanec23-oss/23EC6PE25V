//------------------------------------------------------------------------------
//File       : testbench.sv
//Author     : Muhammed Ridan (1BM23EC156)
//Created    : 2026-02-01
//Module     : tb
//Project    : SystemVerilog and Verification (23EC6PE2SV),
//Faculty    : Prof. Ajaykumar Devarapalli
//Description: Constraint-driven verification of DFF with functional coverage.
//------------------------------------------------------------------------------

class packet;
    rand bit d, rst;

    // Reset active only ~10% of the time
    constraint c1 { rst dist {0:=90, 1:=10}; }
endclass

module tb;

    logic clk = 0;
    logic rst, d, q;

    dff dut (.*);

    // Clock generation
    always #5 clk = ~clk;

    // Coverage sampled on clock edge
    covergroup cg @(posedge clk);
        cross_rst_d : cross rst, d;
    endgroup

    cg     c_inst = new();
    packet pkt    = new();

    initial begin
        // Dump setup
        $dumpfile("dff.vcd");
        $dumpvars(0, tb);

        repeat (100) begin
            pkt.randomize();
            rst <= pkt.rst;
            d   <= pkt.d;
            @(posedge clk);
        end

        $display("Coverage: %.2f %%", c_inst.get_inst_coverage());
        $finish;
    end

endmodule
