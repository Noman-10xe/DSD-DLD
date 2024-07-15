

module tb_FSM;

    // Inputs
    reg clk;
    reg rst;
    reg X;
    reg Y;

    // Outputs
    wire state;

    // Instantiate the design under test (DUT)
    /*FSM_wbs dut (
        .clk(clk),
        .rst(rst),
        .X(X),
        .Y(Y),
        .state(state)
    );*/

    FSM_wobs dut (
        .clk(clk),
        .rst(rst),
        .X(X),
        .Y(Y),
        .state(state)
    );

    // Generate the clock and reset
    always #5 clk = ~clk;
    initial begin
        $dumpvars;

        clk = 0;
        rst = 0;
        #20;
        rst = 1;
        #10;
        rst = 0;
        #10;
        
        X = 0;
        Y = 0;
        #20;

        X = 0;
        Y = 1;
        #20;

        X = 1;
        Y = 1;
        #20;

        X = 0;
        Y = 1;
        #20;

        X = 1;
        Y = 0;
        #20;

        rst = 1;

        #10;
        rst = 0;
        
        X = 1;
        Y = 0;
        #20;

        $finish;
    end

endmodule
