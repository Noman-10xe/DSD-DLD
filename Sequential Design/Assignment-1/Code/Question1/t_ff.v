    module t_ff (input t, clk, rst, output reg q);

    always @(posedge clk or posedge rst) 
    begin
        if (rst)
            q <= 1'b0;
        else if (t) 
           q <= ~q;
    end
    endmodule