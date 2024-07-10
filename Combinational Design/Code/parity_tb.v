
	`timescale 1ns/1ps
	module test_tb;

	reg [3:0] data;
	wire parity;
	
	parity_generator dut(.data(data), .parity(parity));
	
	// Stimulus
	initial begin
	// Test with different inputs
	data = 4'b0000; // Even number of high bits
	#20;
	data = 4'b0001; // Odd number of high bits
	#20;
	data = 4'b1100; // Even number of high bits
	#20;
	data = 4'b1011; // Odd number of high bits
	#20;
	data = 4'b0000; // Even number of high bits
	#20;
	data = 4'b1101; // Odd number of high bits
	#20;
	end
	endmodule
