module tb_fifo;

    // Parameters
    parameter DATA_SIZE = 8;
    parameter ADDRESS_SIZE = 3;
    localparam ADDRESS_DEPTH = 2**ADDRESS_SIZE;

    // Signals
    reg clk, rst, push, pop;
    reg [DATA_SIZE-1:0] data_in;
    wire [DATA_SIZE-1:0] data_out;
    wire full, empty, overflow, underflow;
    integer i;

    // Instantiation
    fifo #(DATA_SIZE, ADDRESS_SIZE) uut (
        .clk(clk),
        .rst(rst),
        .push(push),
        .pop(pop),
        .data_in(data_in),
        .data_out(data_out),
        .full(full),
        .empty(empty),
        .overflow(overflow),
        .underflow(underflow)
    );

    // Clock generation
    always #5 clk = ~clk;

    // Testbench logic
    initial begin
        $dumpvars;

        // Initialize signals
        clk = 0;
        rst = 1;
        push = 0;
        pop = 0;
        data_in = 0;

        // Reset the FIFO
        @(posedge clk);
        rst = 0;
        @(posedge clk);
        rst = 1;
        @(posedge clk);

        // Test case: Push to full
        $display("Test case: Push to full");
        for (i = 0; i < ADDRESS_DEPTH; i = i + 1) begin
            @(posedge clk);
            push = 1;
            data_in = i;
        end
        @(posedge clk);
        push = 0;
        @(negedge clk)
        if (!full) $display("Error: FIFO should be full");
        else $display("Passed");

        // Test case: Pop to empty
        $display("Test case: Pop to empty");
        for (i = 0; i < ADDRESS_DEPTH; i = i + 1) begin
            @(posedge clk);
            pop = 1;
        end
        @(posedge clk);
        pop = 0;
        @(negedge clk)
        if (!empty) $display("Error: FIFO should be empty");
        else $display("Passed");

        // Test case: Simultaneous push and pop
        for (i = 0; i < ADDRESS_DEPTH; i = i + 1) begin
            @(posedge clk);
            push = 1;
            pop = 1;
            data_in = i;
        end
        @(posedge clk);
        push = 0;
        pop = 0;
        

        // Test case: Overflow
        $display("Test case: Overflow");
        for (i = 0; i < ADDRESS_DEPTH; i = i + 1) begin
            @(posedge clk);
            push = 1;
            data_in = i;
        end
        @(posedge clk);
        push = 1;
        @(posedge clk);
        push = 0;
        if (!overflow) $display("Error: FIFO should have overflowed");
        else $display("Passed");

        // Test case: Underflow
        $display("Test case: Underflow");
        for (i = 0; i < ADDRESS_DEPTH; i = i + 1) begin
            @(posedge clk);
            pop = 1;
        end
        @(posedge clk);
        pop = 1;
        @(posedge clk);
        pop = 0;
        if (!underflow) $display("Error: FIFO should have underflowed");
        else $display("Passed\n");

        // End of test
        $display("Congratulations, All test cases are now passing\n");
        $finish;
    end

endmodule