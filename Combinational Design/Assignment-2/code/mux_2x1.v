


	module mux_2x1 (input A, B, C, output reg F);
	
	
	always @*
	assign F = A & (B ^ C);
	endmodule
