

    module tb_freq_divider;
    reg clk, rst;
    wire y;

    freq_divider m1 (.clk(clk), .rst(rst), .y(y));

    always #5 clk = ~clk;
    
    initial begin
    $dumpvars;

    clk = 0;
    rst = 0;
    #5;

    rst = 1;
    #10;

    rst = 0;
    #10;

    #250;
    $finish;
    end
    endmodule