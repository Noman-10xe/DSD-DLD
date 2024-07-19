

        module button_press_synchronizer (input clk, rst, bi, output reg bo);
        

        localparam S0 = 3'b001;
        localparam S1 = 3'b010;
        localparam S2 = 3'b100;

        reg [2:0] state;
        


        always @(posedge clk or posedge rst)
        begin
            if (rst)
                state <= S0;
            else
             begin 
                case (state)
                S0 : state <= bi? S1 : S0;

                S1 : state <= S2;

                S2 : state <= bi ? S2 : S0;
            endcase
            end
        end

        always @(state)
            case (state)
            S0 : bo <= 0;

            S1 : bo <= 1;

            S2 : bo <= 0;

            default : bo <= bo;
            endcase
        endmodule