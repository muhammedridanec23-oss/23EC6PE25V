//------------------------------------------------------------------------------
//File       : testbench.sv
//Author     : Muhammed Ridan (1BM23EC156)
//Created    : 2026-02-01
//Module     : tb
//Project    : SystemVerilog and Verification (23EC6PE2SV),
//Faculty    : Prof. Ajaykumar Devarapalli
//Description: Functional coverage based verification of ALU opcodes.
//------------------------------------------------------------------------------

module tb;

    logic [7:0] a, b, y;
    opcode_e   op;

    alu dut (.*);

    // Coverage: tracks all enum values automatically
    covergroup cg_alu;
        cp_op : coverpoint op;
    endgroup

    cg_alu cg = new();

    initial begin
        // Dump setup
        $dumpfile("alu.vcd");
        $dumpvars(0, tb);

        repeat (50) begin
            a  = $urandom();
            b  = $urandom();
            op = opcode_e'($urandom_range(0, 3));
            #5 cg.sample();
        end

        $display("Coverage: %.2f %%", cg.get_inst_coverage());
        $finish;
    end

endmodule
