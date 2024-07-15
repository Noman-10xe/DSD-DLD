

    module shift_register (input clk, rst, load, shift, input [3:0] data_in, output reg [3:0] A);
    
    always @(posedge clk or posedge rst)
    if (rst)
        A <= 4'd0;
    else 
    begin
        case ({shift, load})
        2'b00 : A <= A;
        2'b01 : A <= data_in;
        default : A <= A << 1;
        endcase
    end
    endmodule