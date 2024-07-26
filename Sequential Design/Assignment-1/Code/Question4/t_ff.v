
module t_ff (input T, clk, rst, output reg Q);

always @(posedge clk or posedge rst) begin
    if (rst)
    Q <= 0;
    else if (T)
    Q <= ~Q;
end
endmodule