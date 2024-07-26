    module FSM (input clk, rst, X, Y, output reg state);

    localparam A = 1'b0;
    localparam B = 1'b1;
    
    reg next_state;
    
    //state-transition logic
    always @(posedge clk or posedge rst)
    begin
        if (rst)
        state <= A;
        else
        state <= next_state;
    end

    //Next State Logic
    always @(*) begin
        case (state)
        
        A : begin if (X && ~Y) begin 
            next_state = B;
        end
        else next_state = A; 
        end

        B : begin if (X && ~Y) begin 
            next_state = B;
        end
        else next_state = A; 
        end

        default : next_state = A;
        endcase
    end
    endmodule