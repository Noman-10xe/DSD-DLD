`timescale 1ns/1ns

// Code your design here
module CombinationalLogic(

     input wire A,

    input wire B,

     input wire C,

     output wire Out

);


wire xor_out1, xor_out2, and_out;

wire mux_out;


assign #3 mux_out = (C) ? B : A; 

assign #2 xor_out1 = A ^ mux_out;

assign #2 xor_out2 = xor_out1 ^ C;

assign #1 and_out = A & B & C;

assign #1 Out = xor_out2 & and_out;

endmodule