
module stopwatch (input clk, clr, output [3:0] min, sec0, deci, output [2:0] sec1);

//Deci
counter9 decimal (.clk(clk), .rst(clr), .out(deci));

//Second_0 (LSB)
wire clk_sec0;
assign clk_sec0 = (~deci[3] & ~deci[2] & ~deci[1] & ~deci[0]);
counter9 second_0 (.clk(clk_sec0), .rst(clr), .out(sec0));

//Second_1 (MSB)
wire clk_sec1;
assign clk_sec1 = (~sec0[3] & ~sec0[2] & ~sec0[1] & ~sec0[0]);
counter5 second_1 (.clk(clk_sec1), .rst(clr), .out(sec1));

//Minutes
wire clk_minute;
assign clk_minute = (~sec1[2] & ~sec1[1] & ~sec1[0]);
counter9 minute (.clk(clk_minute), .rst(clr), .out(min));

endmodule