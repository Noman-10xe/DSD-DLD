

module code (output reg [31:0] data_out, input [31:0] operand1, input [31:0] operand2, input clk, rst, input op_sel);

reg [31:0] next_state;

always @(posedge clk or rst) 
begin
    if (rst)
    	begin
    	data_out <= 32'd0;
    	next_state <= 32'b0;
	end
    else
    data_out <= next_state;
end

always @(posedge clk) 
begin
    case (op_sel)
        1'b0 : next_state <= operand1 + operand2 + data_out;
        1'b1 : next_state <= operand1 - operand2; 
    endcase
end
endmodule
