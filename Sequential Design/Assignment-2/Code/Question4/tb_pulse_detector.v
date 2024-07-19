module tb_pulse_detector;

reg clk, rst, x;
wire y;

pulse_detector m0 (.clk(clk), .rst(rst), .x(x), .y(y));

always #5 clk = ~clk;

initial begin
    $dumpvars;
    
    clk = 0;
    rst = 0;
    x = 1;
    #20;
    
    rst = 1;
    #20;

    rst = 0;
    #10;

    x = 0;
    #20;

    x = 1;
    #20;

    x = 0;
    #30;

    x = 1;
    #40;
    
    rst = 1;
    #10;
    
    x = 0;    
    #30;
    
    x = 1;
    rst = 0;
    #40;

    $finish;
end
endmodule