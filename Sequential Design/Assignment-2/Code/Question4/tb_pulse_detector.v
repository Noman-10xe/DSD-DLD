module tb_pulse_detector;

reg clk, rst, x;
wire y;

pulse_detector m0 (.clk(clk), .rst(rst), .x(x), .y(y));

always #5 clk = ~clk;

initial begin
    clk = 0;
    rst = 0;
end

initial begin
    $dumpvars;
    
    @(posedge clk);
    rst = 1;

    repeat(4) @(posedge clk);

    rst = 0;

    $display("Check the Output after reset");
    if (y !=0 ) begin
        $display("Incorrect Output after reset");
    end
    
    @(posedge clk);
    x = 1;

    repeat(3) @(posedge clk);
    x = 0;

    repeat(2) @(negedge clk);
    if (y != 1) begin
        @(negedge clk);
        if (y != 0) begin
            $display("Incorrect Output");
            $finish;
        end
    end

    @(posedge clk);
    x = 1;

    repeat(5) @(posedge clk);
    x = 0;

    repeat(2) @(negedge clk);
    if (y != 1) begin
        @(negedge clk);
        if (y != 0) begin
            $display("Incorrect Output");
            $finish;
        end
    end


    repeat(10) @(posedge clk);
    $display("All Test Cases Passed!");
    $finish;
end
endmodule