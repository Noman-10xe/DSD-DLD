

    module freq_divider (input clk, rst, output reg y);

    reg [3:0] state;
    localparam S0 = 4'd0;
    localparam S1 = 4'd1;
    localparam S2 = 4'd2;
    localparam S3 = 4'd3;
    localparam S4 = 4'd4;
    localparam S5 = 4'd5;
    localparam S6 = 4'd6;
    localparam S7 = 4'd7;
    localparam S8 = 4'd8;
    localparam S9 = 4'd9;

    always @(posedge clk or posedge rst) 
    begin
    if (rst)
    state <= S0;
    else
    state <= state;    
    end

    always @(posedge clk or posedge rst) 
    begin
    case (state)
    S0 : state <= S1;
    S1 : state <= S2;
    S2 : state <= S3;
    S3 : state <= S4;
    S4 : state <= S5;
    S5 : state <= S6;
    S6 : state <= S7;
    S7 : state <= S8;
    S8 : state <= S9;
    S9 : state <= S0;
    endcase    
    end

    always @(state) 
    begin
    case (state)
    S0 : y <= 1;
    S1 : y <= 0;
    S2 : y <= 0;
    S3 : y <= 0;
    S4 : y <= 0;
    S5 : y <= 0;
    S6 : y <= 0;
    S7 : y <= 0;
    S8 : y <= 0;
    S9 : y <= 0;
    endcase    
    end
    endmodule