`timescale 10ns/1ns

module tb_toggle_circuit;

reg button;
reg clk;
reg rst;
wire y;

toggle_circuit uut (
    .button(button),
    .clk(clk),
    .rst(rst),
    .y(y)
);

initial begin
    // Initialize inputs
    button = 0;
    clk = 0;
    rst = 1;
    $dumpvars;

    repeat (5) @(posedge clk);

    // Release reset
    rst = 0;

    // Check initial output
    $display("Checking initial output...");

    if (y != 0) begin
    $display("Error: Initial output is incorrect");
    $finish;
    end

    @(posedge clk)
    // Test button toggle
    $display("Toggling button and checking output...");
    button = 1;
    @(posedge clk);
    if (y != 0) begin
        $display("Error: Output did not toggle on");
        $finish;
    end

    repeat (5) @(posedge clk)
    // Test button toggle again
    $display("Toggling button again and checking output...");
    button = 0;
    repeat(2) @(posedge clk);
    if (y != 0) begin
        $display("Error: Output did not toggle off");
        $finish;
    end

    //Remember State
    $display("Toggling button again and checking output...");
    button = 1;
    @(posedge clk)
    button = 0;
    repeat(2) @(posedge clk);
    if (y != 1) begin
        $display("Error: Output was not remembered");
        $finish;
    end

    // Repeat toggle test 10 times
    $display("Repeating toggle test 10 times...");
    
    repeat (10) button = @(posedge clk) ~button;

    repeat (10) begin
        @(posedge clk);
        if (y != button) begin
            $display("Error: Output did not toggle correctly");
            $finish;
        end
        else
            $display("Tests Passed Successfully");
            $finish;

    end
end
    // Clock generator
    always #10 clk = ~clk;

endmodule