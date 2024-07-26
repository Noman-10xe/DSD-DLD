

    module freq_divider (input clk, rst, output reg y);

    wire Qa, Qb, Qc, Qd;
    wire Tb, Tc, Td;

    t_ff A(.T(1'b1), .clk(clk), .rst(rst), .Q(Qa));
    t_ff B(.T(Tb), .clk(clk), .rst(rst), .Q(Qb));
    t_ff C(.T(Tc), .clk(clk), .rst(rst), .Q(Qc));
    t_ff D(.T(Td), .clk(clk), .rst(rst), .Q(Qd));

    assign Tb = Qa & ~Qd;
    assign Tc = Qb & Qa;
    assign Td = Qa & (Qd | (Qc & Qb));

    assign y = (Qd & ~Qc) | (Qa & Qc) | (Qb & Qc);


    endmodule