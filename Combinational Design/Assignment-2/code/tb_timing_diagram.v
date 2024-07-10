// Code your testbench here
// or browse Examples
`timescale 1ns/1ns

module tb_CombinationalLogic;

    // Inputs
    reg A, B, C;
    // Output
    wire Out;

    // Instantiate the module under test
    CombinationalLogic uut (
        .A(A),
        .B(B),
        .C(C),
        .Out(Out)
    );

    // Initialize inputs
    initial begin
        A = 0;
        B = 0;
        C = 0;

        // Wait for some time to allow combinational logic to settle
        #5;
	A = 0;
        B = 0;
        C = 1;
        
        #5;
	A = 0;
        B = 1;
        C = 0;
        
        #5;
	A = 0;
        B = 1;
        C = 1;
        
        #5;
	A = 1;
        B = 0;
        C = 0;
        
        #5;
	A = 1;
        B = 0;
        C = 1;
        
        #5;
	A = 1;
        B = 1;
        C = 0;
        
        #5;
	A = 1;
        B = 1;
        C = 1;
        
        #5;
	A = 1;
        B = 0;
        C = 0;
        
        // Display results
        $display("A=%b, B=%b, C=%b, Out=%b", A, B, C, Out);
    end

    // Add more test cases here if needed

endmodule

