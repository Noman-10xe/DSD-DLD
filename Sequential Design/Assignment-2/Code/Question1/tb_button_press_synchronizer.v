
    module tb_button_press_synchronizer;
    reg clk, rst, bi;
    wire bo;

    button_press_synchronizer m1 (.clk(clk), .rst(rst), .bi(bi), .bo(bo));

    always #5 clk = ~clk;
    initial begin
        
        $dumpvars;

        clk = 0;
        rst = 0;
        bi = 0;

        #10;
        rst = 1;
        bi = 1;

        #20
        rst = 0;

        #30;
        bi = 0;

        #20;
        bi = 1;

        #50;
        bi = 0;

        #10;
        bi = 1;

        #20;
        bi = 0;

        $finish;
    end


    endmodule