
    //Author: Noman Rafiq
//Dated: July 15, 2024

module tb_shift_register;

    // Inputs
    reg [3:0] data_in;
    reg shift;
    reg load;
    reg clk;
    reg rst;

    // Output
    wire [3:0] A;

    // Instantiate the shift register
    shift_register uut (
        .data_in(data_in),
        .shift(shift),
        .load(load),
        .clk(clk),
        .rst(rst),
        .A(A)
    );

    // Clock generation
    always #5 clk = ~clk;

    // Initial values
    initial begin

        $dumpvars;

        clk = 0;
        rst = 1;
        data_in = 4'b0000;
        shift = 0;
        load = 0;

        // Reset
        #10 rst = 0;

        // Test case 1: Load parallel data
        #20 data_in = 4'b1010;
        #10 load = 1;
        #10 load = 0;

        // Test case 2: Shift register
        #20 shift = 1;
        #20 shift = 0;

        // Test case 3: No change
        #20;

        // Test case 4: Load new data and then shift
        #20 data_in = 4'b1100;
        #10 load = 1;
        #10 load = 0;
        #20 shift = 1;
        #20 shift = 0;

        // Test case 5: Shift without loading new data
        #40 shift = 1;
        #20 shift = 0;

        // Test case 6: Shifting while shift and load are set to 1
        #20 data_in = 4'b1111;
        #10 load = 1;
        #10 load = 0;
        
        #40 shift = 1;
            load = 1;
        #20 shift = 1;
            load = 0;
        #20 shift = 0;
            load = 0;
        // End simulation
        #10 $finish;
    end

endmodule
