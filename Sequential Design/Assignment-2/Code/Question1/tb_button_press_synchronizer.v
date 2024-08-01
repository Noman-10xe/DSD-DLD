
    module tb_button_press_synchronizer;
    reg clk, rst, bi;
    wire bo;

    button_press_synchronizer m1 (.clk(clk), .rst(rst), .bi(bi), .bo(bo));

    initial begin
        clk = 0;
        rst = 0;
        bi = 0;
    end

    always #5 clk = ~clk;
    initial begin
        
        $dumpvars;

        repeat(2) @(posedge clk);
        
        rst = 1;
        repeat(3) @(posedge clk);

        rst = 0;
        @(posedge clk);
        bi = 1;

        @(posedge clk);
        @(negedge clk)
        $display("Checking for Output Pulse");
        if (bo != 1) begin
            $display("Output is Incorrect Error: Line: 31");
            $finish;
            end
        
        @(posedge clk);
        @(negedge clk)
        $display("Checking if Output had one cycle");
        if (bo != 0) begin
            $display("Output is Incorrect Error: Line: 38");
            $finish;
            end

        bi = 0;

        repeat(5) @(posedge clk);

        //Asserting Input again
        bi = 1;
        repeat(5) @(posedge clk);
        bi = 0;

        if (bo != 0) begin
            @(posedge clk)
            if (bo != 1) begin
            $display("Output is Incorrect Line: 49");
            $finish;
            end
        end
    
        repeat(15) @(posedge clk);


        $display("All Test cases Passed!");
        $finish;
    end

    endmodule