
    module tb_fifo;
    
    parameter DATA_SIZE = 8;
    parameter ADDRESS_SIZE = 3;
    
    reg clk, rst, push, pop;
    reg [DATA_SIZE-1 : 0] data_in;
    reg can_read;
    reg can_write;
    
    wire [DATA_SIZE-1 : 0] data_out;
    wire full, empty;

    fifo dut (.clk(clk),
                .rst(rst),
                .push(push),
                .pop(pop),
                .data_in(data_in),
                .can_read(can_read),
                .can_write(can_write),
                .data_out(data_out),
                .full(full),
                .empty(empty));
    
    always #5 clk = ~clk;
    initial begin

        $dumpvars;

        clk = 0;
        rst = 1;
        push = 0;
        pop = 0;
        can_read = 0;
        can_write = 0;
        #30;
        
        rst = 0;
        #20;

        rst = 1;
        #20;

        data_in = 8'd132;
        #20;
        
        push = 1;
        can_write = 1;
        #10;

        data_in = 8'd45;
        #10;

        data_in = 8'd222;
        #10;

        data_in = 8'd177;
        #10;
        
        data_in = 8'd13;
        #10;

        data_in = 8'd189;
        can_write = 0;
        #10;

        data_in = 8'd91;
        push = 0;
        #10;

        data_in = 8'd33;
        #10;

        data_in = 8'd109;
        push = 1;

        #20;
        can_write = 1;
        pop = 1;
        can_read = 1;

        #40;
        pop = 1;
        can_read = 1;
        can_write = 0;

        #40;
        
        push = 0;
        #150;

        can_read = 0;

        #10;
        push = 1;
        can_write = 1;

        
        #10 data_in = 8'd29;
        #10 data_in = 8'd230;
        #10 data_in = 8'd138;
        #10 data_in = 8'd213;
        #10 data_in = 8'd254;
        #10 data_in = 8'd243;
        #10 data_in = 8'd107;
        #10 data_in = 8'd85;
        #10 data_in = 8'd12;
        
        #20 push = 0;
        can_read = 1;

        #120; //Reading from Empty FIFO

        can_read = 0;
        pop = 0;
        push = 1;

        #10 data_in = 8'd129;
        #10 data_in = 8'd209;
        #10 data_in = 8'd157;
        #10 data_in = 8'd13;
        #10 data_in = 8'd54;
        #10 data_in = 8'd103;
        #10 data_in = 8'd247;
        #10 data_in = 8'd51;
        #10 data_in = 8'd186;

        #20 rst = 0;
        
        #30 rst = 1;
        
        #120;

        $finish;
    end
        
    endmodule