//------------------------------------------------------------------------------
//File       : testbench.sv
//Author     : Muhammed Ridan (1BM23EC156)
//Created    : 2026-02-01
//Module     : tb
//Project    : SystemVerilog and Verification (23EC6PE2SV),
//Faculty    : Prof. Ajaykumar Devarapalli
//Description: Whitebox coverage of FSM internal states using hierarchical access.
//------------------------------------------------------------------------------

module tb;

    logic clk = 0;
    logic rst, in, out;

    fsm_101 dut (.*);

    // Clock generation
    always #5 clk = ~clk;

    // Whitebox coverage: internal FSM state
    covergroup cg_fsm @(posedge clk);
        cp_state : coverpoint dut.state;
    endgroup

    cg_fsm cg = new();

    initial begin
        // Dump setup
        $dumpfile("fsm_101.vcd");
        $dumpvars(0, tb);

        // Reset
        rst = 1; in = 0;
        @(posedge clk);
        rst = 0;

        // Drive stimulus (forces all states)
        repeat (20) begin
            in = $urandom_range(0,1);
            @(posedge clk);
        end

        $display("FSM State Coverage: %.2f %%", cg.get_inst_coverage());
        $finish;
    end

endmodule
