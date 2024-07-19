

    module synchronizer (input clk_A, clk_B, rst_A, rst, output reg rst_B);

    wire w0, w1, w2;

    d_ff m0 (.clk(clk_A), .rst(rst), .d(rst_A), .q(w0));

    //Two Flops Synchronizer
    d_ff m1 (.clk(clk_B), .rst(1'b0), .d(w0), .q(w1));
    d_ff m2 (.clk(clk_B), .rst(1'b0), .d(w1), .q(w2));

    assign rst_B = w2;
        
    endmodule