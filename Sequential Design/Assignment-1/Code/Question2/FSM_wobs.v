    module FSM_wobs (input clk, rst, X, Y, output reg state);

    localparam A = 1'b0;
    localparam B = 1'b1;
    

    always @(posedge clk or posedge rst)
    begin
        if (rst)
        state <= A;
        else 
        begin
            case ({X,Y})
            2'b10 : state <= B;
            default : state <= A;
            endcase
        end
    end
    endmodule