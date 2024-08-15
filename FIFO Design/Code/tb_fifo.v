
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

        // Test case: Pushing until Full
        $display("Test case: Pushing Until full");
        for (i = 0; i < ADDRESS_DEPTH; i = i + 1) begin
            @(posedge clk);
            push = 1;
            data_in = i;
        end
        @(posedge clk);
        push = 0;

        @(negedge clk);
        if (!full) $display("Error: FIFO should be full");
        else $display("Passed");

        // Test case: Popping until empty
        $display("Test case: Popping Until empty");
        for (i = 0; i < ADDRESS_DEPTH; i = i + 1) begin
            @(posedge clk);
            pop = 1;
            @(negedge clk);
            if (data_out != i) $display("Error: FIFO data mismatch. Expected %d, Got %d", i, data_out);
        end
        @(posedge clk);
        pop = 0;

        @(negedge clk);
        if (!empty) $display("Error: FIFO should be empty");
        else $display("Passed");

        // Test case: Simultaneous push and pop
        $display("Test case: Simultaneous push and pop");
        for (i = 0; i < ADDRESS_DEPTH; i = i + 1) begin
            @(posedge clk);
            push = 1;
            pop = 1;
            data_in = i;
            repeat(2) @(posedge clk);
            if (data_out != i) $display("Error: FIFO data mismatch. Expected %0d, Got %0d", i, data_out);
        end
        @(posedge clk); 
        push = 0;
        pop = 0;

        // Test Overflow
        $display("Test Case: Overflow Detection");
        for (i = 0; i < ADDRESS_DEPTH; i = i + 1) begin
            @(posedge clk);
            push = 1;
            data_in = i;
        end

        @(negedge clk);
        if (!overflow) $display("Error: FIFO should have Overflowed");
        else $display("Passed");
        @(posedge clk) push = 0;
        @(posedge clk);
        pop = 0;

        // Test Case: Underflow Detection
        $display("Test Case: Underflow Detection");

        // First, empty the FIFO completely
        for (i = 0; i < ADDRESS_DEPTH; i = i + 1) begin
            @(posedge clk);
            pop = 1;
        end

        @(posedge clk);
        pop = 0; // Ensure pop is deasserted before testing underflow

        // Now, perform extra pops to cause underflow
        for (i = 0; i < 5; i = i + 1) begin
            @(posedge clk);
            pop = 1;
        end
        
        @(negedge clk);
        if (!underflow) $display("Error: FIFO should have underflowed");
        else $display("Passed");

        pop = 0;

        repeat(10) @(posedge clk)

        $finish;
    end
endmodule