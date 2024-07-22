

    `timescale 1ms/100us
    module tb_stopwatch;
    
    //input clk, clr, output reg [3:0] min, sec0, deci, output reg [2:0] sec1
    reg clk, clr;
    wire [3:0] min, sec0, deci;
    wire [2:0] sec1;

    stopwatch dut (.clk(clk), .clr(clr), . min(min), .sec0(sec0), .deci(deci), .sec1(sec1));

    always #50 clk = ~clk;
    initial begin

        $dumpvars;
        clk = 0;
        clr = 0;

        #20;
        clr = 1;

        #300;
        clr = 0;

        #650000;
        $finish;
    end

    initial begin
        $monitor("%d : %d%d : %d",min,sec1,sec0,deci);
    end

    endmodule
