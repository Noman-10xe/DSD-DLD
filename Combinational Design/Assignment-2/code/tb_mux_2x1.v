	//Author: Noman Rafiq
	//Dated: July 10, 2024
	
	`timescale 1ns/10ps
	
	module testbench;
	wire F;
	reg A, B, C;
	mux_2x1 dut(.A(A), .B(B), .C(C), .F(F));

	initial begin
		A=1'b0;
		B=1'b0;
		C=1'b0;
		#20;
		
		A=1'b0;
		B=1'b0;
		C=1'b1;
		#20;
		
		A=1'b0;
		B=1'b1;
		C=1'b0;
		#20;
		
		A=1'b0;
		B=1'b1;
		C=1'b1;
		#20;
		
		A=1'b1;
		B=1'b0;
		C=1'b0;
		#20;
		
		A=1'b1;
		B=1'b0;
		C=1'b1;
		#20;
		
		A=1'b1;
		B=1'b1;
		C=1'b0;
		#20;
		
		A=1'b1;
		B=1'b1;
		C=1'b1;
		#20;
	end
	endmodule
