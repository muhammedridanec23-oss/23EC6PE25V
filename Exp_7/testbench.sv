//------------------------------------------------------------------------------
//File       : testbench.sv
//Author     : Muhammed Ridan (1BM23EC156)
//Created    : 2026-02-01
//Module     : tb
//Project    : SystemVerilog and Verification (23EC6PE2SV),
//Faculty    : Prof. Ajaykumar Devarapalli
//Description: Reference-model based verification of SISO shift register.
//------------------------------------------------------------------------------

module tb;

    logic clk = 0;
    logic si, so;

    siso dut (.*);

    // Clock generation
    always #5 clk = ~clk;

    // Reference model
    logic [3:0] q_ref = 0;

    initial begin
    // Dump setup
    $dumpfile("siso.vcd");
    $dumpvars(0, tb);

    q_ref = 4'b0;   // Initialize reference model

    // Warm-up cycles (ignore Xs from DUT)
    repeat (4) begin
        si = $urandom();
        @(posedge clk);
        q_ref = {q_ref[2:0], si};
    end

    // Actual checking
    repeat (16) begin
        si = $urandom();
        @(posedge clk);
        q_ref = {q_ref[2:0], si};
        #1;

        if (so !== q_ref[3])
            $error("Mismatch! Expected so=%0b, Got so=%0b",
                    q_ref[3], so);
    end

    $display("Shift Register Test PASSED");
    $finish;
	end


endmodule
