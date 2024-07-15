
module toggle_circuit (input button, clk, rst, output reg y);

reg Ta, Tb; 
wire A, B;

t_ff m0(.t(Ta), .clk(clk), .rst(rst), .q(A));
t_ff m1(.t(Tb), .clk(clk), .rst(rst), .q(B));

always @(*)
begin
    assign Ta = (A & button ) | (B & (~button));
    assign Tb = (~A & ~B & button) | (B & ~button);
end

always @(posedge clk or posedge rst) begin
    if (rst)
        begin
        y <= 1'b0;
        Ta <= 0;
        Tb <= 0;
        end
    else if (button)
        y <= B | (A ^ button);
end
endmodule