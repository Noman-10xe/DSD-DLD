
    module tb_synchronizer;
    reg clk_A, clk_B, rst, rst_A;
    wire rst_B;

    synchronizer dut (.clk_A(clk_A), .clk_B(clk_B), .rst(rst), .rst_A(rst_A), .rst_B(rst_B));

    always #5 clk_A = ~clk_A;
    always #20 clk_B = ~clk_B;

    initial begin
        $dumpvars;

        clk_A = 0;
        clk_B = 0;
        rst = 0;
        rst_A = 0;

        #20;

        rst = 1;
        #10;
        rst_A = 1;
        #40;

        rst = 0;
        #40;

        rst_A = 0;
        #80;

        rst_A = 1;
        #20;

        rst_A = 0;
        #30;

        rst_A = 1;
        #30;

        rst_A = 0;
        #100;

        $finish;
    
    end     
    endmodule