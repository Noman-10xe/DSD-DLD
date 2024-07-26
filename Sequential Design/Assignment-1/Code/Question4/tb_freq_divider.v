//`timescale 1ns/1ns

module tb_freq_divider;
    reg clk, rst;
    wire y;

    freq_divider m1 (
        .clk(clk),
        .rst(rst),
        .y(y)
    );

    initial begin
        $dumpvars;
        clk = 0;
        rst = 0;
    end

    always #5 clk = ~clk; // clock generator

    initial begin
        
        rst = 0;
        @(posedge clk);

        rst = 1;
        repeat (5) @(posedge clk);

        if (y != 0) begin
            $display("Initial Output is Incorrect");
        end
        rst = 0;

        // Test sequence
        repeat (6) @(posedge clk);
        
        if (y != 1) begin
            $display("Failed to divide the frequency by 10 after reset");
        end
        repeat (30) @(posedge clk);

        rst = 1;
        repeat (3) @(posedge clk);
        if (y != 0) begin
            $display("Error: Output is Incorrect");
        end

        rst = 0;

        repeat (5.5) @(posedge clk); 
        //@(negedge clk);
        if (y != 1) begin
            $display("Failed to divide the frequency by 10 after reset");
            $finish;
        end
        repeat (22) @(posedge clk);

        $display("All test cases Passed");

        $finish;
    end
endmodule