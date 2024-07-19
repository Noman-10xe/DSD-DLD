

    module pulse_detector (input clk, rst, x, output reg y);
    
    localparam A = 3'b001;
    localparam B = 3'b010;
    localparam C = 3'b100;

    reg [2:0] state, next_state;
    reg x_previous;

    //State-Transition
    always @(posedge clk or rst)
    begin
    if (rst) 
        state <= A;
    else
    state <= next_state;
    end

    //Next-State Logic
    always @(*)
    begin 
    case (state)

    A : 
    begin 
        if (!x)
        next_state <= A;
        else
        next_state <= B;
    end
    
    B : 
    begin 
        if (!x && x_previous)
        next_state <= C;
        else
        next_state <= B;
    end

    C : next_state <= A;
    default : next_state <= A;
    endcase
    end

    //Output
    always @(posedge clk or posedge rst)
    begin
        if (rst)
            y <= 0;
        else if (state == C)
            y <= 1;
        else
            y <= 0;
    end

    //Detect Failling-Edge
    always @(posedge clk or posedge rst)
    begin
        if (rst)
            x_previous <= 1;
        else
            x_previous <= x;
    end

    endmodule