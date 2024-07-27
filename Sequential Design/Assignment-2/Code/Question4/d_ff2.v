
module d_ff2 (input clk, rst, d, output reg q);

always @(posedge clk or posedge rst) begin
    if (rst)
    //LSB = 1 for 1-Hot Encoding
    q <= 1'b1;
    else
    q <= d;
end
    
endmodule