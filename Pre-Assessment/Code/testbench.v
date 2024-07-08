module tb_code;
    reg [31:0] operand1;
    reg [31:0] operand2;
    reg op_sel;
    reg clk;
    reg rst;
    wire [31:0] data_out;

    // Instantiate the DUT
    code dut (
        .data_out(data_out),
        .operand1(operand1),
        .operand2(operand2),
        .clk(clk),
        .rst(rst),
        .op_sel(op_sel)
    );


    // Generate reset
    initial begin
        rst = 1;
        #10; // Hold reset for 10 time units
        rst = 0;
    end

    // Apply stimulus (set operand1, operand2, and op_sel here)
    initial begin
        // Test Case 1: Addition
        operand1 = 32'h12345678;
        operand2 = 32'h87654321;
        op_sel = 1; // Addition
        #100; // Wait for some time

        // Test Case 2: Subtraction
        operand1 = 32'h87654321;
        operand2 = 32'h12345678;
        op_sel = 0; // Subtraction
        #100; // Wait for some time

        // Test Case 3: Zero Operand
        operand1 = 0;
        operand2 = 0;
        op_sel = 1; // Addition or 0 for subtraction
        #100; // Wait for some time

        // Add more test cases if needed
    end
    
    // Generate clock
    initial begin
    clk = 1'b0;
    forever #5 clk = ~clk; // Example: 10 ns period (adjust as needed)
    end

    // Monitor data_out and other signals

endmodule
