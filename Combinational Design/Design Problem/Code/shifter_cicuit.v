//Author: Noman Rafiq
//Date: July 11, 2024

module shifter_circuit (input [7:0] data_in, input [2:0] shift_amount, input shift_direction, output reg [7:0] result);


//Function Definition
function [7:0] shifted_value (input [7:0] data_in, input [2:0] shift_amount, input shift_direction);
begin
if(shift_direction)
shifted_value = (data_in << shift_amount);
else
shifted_value = (data_in >> shift_amount);
end
endfunction

always @(*)
    begin
        result = shifted_value(data_in, shift_amount, shift_direction);
    end

endmodule