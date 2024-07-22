
    module counter9 (input clk, rst, output [3:0] out);


        wire D_3, D_2, D_1, D_0;
        // D_d = D_3 = Q0' Q3 + Q2 Q1 Q0
        assign D_3 = (~out[0] & out[3]) | (out[2] & out[1] & out[0]);

        // D_c = D_2 = Q2 ^ (Q1 Q0)
        assign D_2 = out[2] ^ (out[1] & out[0]);

        // D_b = D_1 = (Q3' Q1' Q0) + (Q1 Q0')
        assign D_1 = (~out[3] & ~out[1] & out[0]) | (out[1] & ~out[0]);

        // D_a = D_0 = Q0'
        assign D_0 = ~out[0];

        d_ff D (.d(D_3), .clk(clk), .rst(rst), .q(out[3]));
        d_ff C (.d(D_2), .clk(clk), .rst(rst), .q(out[2]));
        d_ff B (.d(D_1), .clk(clk), .rst(rst), .q(out[1]));
        d_ff A (.d(D_0), .clk(clk), .rst(rst), .q(out[0]));

    endmodule