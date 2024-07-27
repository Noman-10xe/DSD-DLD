

        module button_press_synchronizer (input clk, rst, bi, output reg bo);
        
        wire Da, Db, Dc, Qa, Qb, Qc;

        d_ff2 A(.d(Da), .clk(clk), .rst(rst), .q(Qa));
        d_ff B(.d(Db), .clk(clk), .rst(rst), .q(Qb));
        d_ff C(.d(Dc), .clk(clk), .rst(rst), .q(Qc));


        assign Da = ~bi;
        assign Db = bi & Qa;
        assign Dc = ~Qa & bi;
        assign bo = Qb;

        /*localparam S0 = 3'b001;
        localparam S1 = 3'b010;
        localparam S2 = 3'b100;

        reg [2:0] state, next_state;

        //Transition Logic
        always @(posedge clk or posedge rst) begin
            if (rst)
                state <= S0;
            else
                state <= next_state;
        end

        //Next State Logic
        always @(*) begin
            case (state)
            
            S0: next_state = (bi) ? S1 : S0;

            S1: next_state = (bi) ? S2 : S0;

            S2: next_state = (bi) ? S2 : S0;
            endcase
        end
        
        //Output Logic
        always @(*) begin
            case (state)
            
            S0: bo = 0;

            S1: bo = 1;

            S2: bo = 0;
            endcase
        end*/
    
        endmodule