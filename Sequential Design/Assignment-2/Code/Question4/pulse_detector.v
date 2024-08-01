

    module pulse_detector (input clk, rst, x, output reg y);

    wire Qa, Qb, Qc, Da, Db, Dc;

    d_ff2 A (.d(Da), .clk(clk), .rst(rst), .q(Qa));
    d_ff  B (.d(Db), .clk(clk), .rst(rst), .q(Qb));
    d_ff  C (.d(Dc), .clk(clk), .rst(rst), .q(Qc));

    assign Da = ((~Qb & ~x) | Qc);
    assign Db = ~Qc & x;
    assign Dc = Qb & ~x;

    assign y = Qb & ~x;

    endmodule