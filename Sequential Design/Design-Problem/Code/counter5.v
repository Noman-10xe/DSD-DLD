

    module counter5 (input clk, rst, output [2:0] out);

        wire D_2, D_1, D_0;
        // D_c = D_2 = Q1 Q0 + Q2 Q0'
        assign D_2 = (out[1] & out[0]) | (out[2] & ~out[0]);

        // D_b = D_1 = Q1 Q0' + Q2' Q1' Q0
        assign D_1 = (out[1] & ~out[0]) | (~out[2] & ~out[1] & out[0]);

        // D_a = D_0 = Q0'
        assign D_0 = ~out[0];


        d_ff C (.d(D_2), .clk(clk), .rst(rst), .q(out[2]));
        d_ff B (.d(D_1), .clk(clk), .rst(rst), .q(out[1]));
        d_ff A (.d(D_0), .clk(clk), .rst(rst), .q(out[0]));

    endmodule