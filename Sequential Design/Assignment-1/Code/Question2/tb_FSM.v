

module tb_FSM;

    // Inputs
    reg clk;
    reg rst;
    reg X;
    reg Y;

    wire state;

    FSM dut (
        .clk(clk),
        .rst(rst),
        .X(X),
        .Y(Y),
        .state(state));

    // Generate the clock and reset
    always #5 clk = ~clk;
    initial begin
        $dumpvars;

        clk = 0;
        rst = 0;

        repeat (4) @(posedge clk)
        rst = 1;
        
        @(posedge clk)
        rst = 0;

        repeat(2) @(posedge clk)
        X = 0;
        Y = 0;
        if (state != 0)
            $display("Error: Initial state hasn't been reset");

        repeat(5) @(posedge clk)
        X = 0;
        Y = 1;
        
        if (state != 0) begin
            $display("Error");
            $finish;
        end

        repeat(5) @(posedge clk)
        X = 1;
        Y = 1;
        
        if (state != 0) begin
            $display("Error");
            $finish;
        end

        repeat (2) @(posedge clk)
        X = 0;
        Y = 0;

        repeat(5) @(posedge clk)
        X = 1;
        Y = 0;
        
        if (state != 1) begin
            $display("Error: The FSM failed to transition from A to B");
            $finish;
        end

        repeat(5) @(posedge clk)

        //No change in input, should stay in state B        
        if (state != 1) begin
            $display("Error: The FSM failed to stay in B");
            $finish;
        end

        repeat(5) @(posedge clk)
        X = 0;
        Y = 1;
        
        if (state != 0) begin
            $display("Error: The FSM failed to transition from B to A");
            $finish;
        end
        
        $display("All Test Cases Passed Successfully");
        $finish;
    end

endmodule
