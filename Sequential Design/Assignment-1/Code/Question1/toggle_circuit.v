
module toggle_circuit (input button, clk, rst, output y);

wire Q;

t_ff m0(.t(button), .clk(clk), .rst(rst), .q(Q));

assign y = Q;

endmodule