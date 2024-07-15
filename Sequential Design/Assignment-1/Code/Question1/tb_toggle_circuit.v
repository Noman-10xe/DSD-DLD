`timescale 10ns/1ns

module tb_toggle_circuit;

reg clk, rst, button;
wire y;

toggle_circuit dut (.clk(clk), .rst(rst), .button(button), .y(y));

initial begin
    $dumpvars;

    clk = 0;
    rst = 0;
    
    #20;

    rst = 1;

    #20;
    rst = 0;
    button = 0;

    #10;
    button = 1;

    #20;
    button = 0;

    #20;
    button = 0;

    #20;
    button = 1;

    #10;
    button = 0;

    #30;
    button = 1;

    #10;
    button = 1;

    #10;
    button = 0;

    #30;
    button = 0;

    #25;
    button = 1;

    #10;
    button = 0;

    #20;
    button = 1;
    $finish;

end


initial begin 
    forever #5 clk = ~clk;
end
endmodule