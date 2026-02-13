//------------------------------------------------------------------------------
//File       : testbench.sv
//Author     : Muhammed Ridan (1BM23EC156)
//Created    : 2026-02-01
//Module     : tb
//Project    : SystemVerilog and Verification (23EC6PE2SV),
//Faculty    : Prof. Ajaykumar Devarapalli
//Description: Testbench with functional coverage for priority encoder.
//------------------------------------------------------------------------------

module tb;

    logic [3:0] in;
    logic [1:0] out;
    logic       valid;

    priority_enc dut (.*);

    // Coverage on input patterns
    covergroup cg_enc;
        cp_in : coverpoint in {
            bins b0 = {1};   // 0001
            bins b1 = {2};   // 0010
            bins b2 = {4};   // 0100
            bins b3 = {8};   // 1000
            bins others = default;
        }
    endgroup

    cg_enc cg = new();

    initial begin
        // Dump setup
        $dumpfile("priority_enc.vcd");
        $dumpvars(0, tb);

        repeat (50) begin
            in = $urandom_range(0, 15);
            #5 cg.sample();
        end

        $display("Coverage: %.2f %%", cg.get_inst_coverage());
        $finish;
    end

endmodule
