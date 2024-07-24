
    module fifo #(parameter DATA_SIZE = 8, parameter ADDRESS_SIZE = 3)
             (input clk, rst, push, pop,
              input [DATA_SIZE-1:0] data_in,
              input can_read, can_write,
              output reg [DATA_SIZE-1:0] data_out,
              output reg full, empty);

    localparam ADDRESS_DEPTH = 2**ADDRESS_SIZE;
    reg [DATA_SIZE-1:0] memory [ADDRESS_DEPTH-1:0];
    reg [ADDRESS_SIZE-1:0] read_ptr, write_ptr;
    reg [ADDRESS_SIZE:0] status; // Extra bit for distinguishing full and empty
    reg underflow, overflow;

    // States
    localparam S0 = 3'b000;
    localparam S1 = 3'b001;
    localparam S2 = 3'b010;
    localparam S3 = 3'b011;
    localparam S4 = 3'b100;
    localparam S5 = 3'b101;
    localparam S6 = 3'b110;
    localparam S7 = 3'b111;

    reg [2:0] state, next_state;

    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            state <= S0;
            data_out <= 0;
            status <= 0;
            read_ptr <= 0;
            write_ptr <= 0;
            overflow <= 0;
            underflow <= 0;
            full <= 0;
            empty <= 1;
        end else begin
            state <= next_state;
        end
    end

    always @(posedge clk) begin
        if (!rst) begin
            data_out <= 0;
            status <= 0;
            read_ptr <= 0;
            write_ptr <= 0;
            overflow <= 0;
            underflow <= 0;
            full <= 0;
            empty <= 1;
        end else begin
            case (state)
                S0: begin
                    if (push && can_write && !full) begin
                        memory[write_ptr] <= data_in;
                        write_ptr <= write_ptr + 1;
                        status <= status + 1;
                        next_state <= S1;
                    end else begin
                        next_state <= S0;
                    end
                end

                S1: begin
                    if (push && can_write && !full) begin
                        memory[write_ptr] <= data_in;
                        write_ptr <= write_ptr + 1;
                        status <= status + 1;
                        next_state <= S2;
                    end else if (pop && can_read && !empty) begin
                        data_out <= memory[read_ptr];
                        read_ptr <= read_ptr + 1;
                        status <= status - 1;
                        next_state <= S0;
                    end else begin
                        next_state <= S1;
                    end
                end

                S2: begin
                    if (push && can_write && !full) begin
                        memory[write_ptr] <= data_in;
                        write_ptr <= write_ptr + 1;
                        status <= status + 1;
                        next_state <= S3;
                    end else if (pop && can_read && !empty) begin
                        data_out <= memory[read_ptr];
                        read_ptr <= read_ptr + 1;
                        status <= status - 1;
                        next_state <= S1;
                    end else begin
                        next_state <= S2;
                    end
                end

                S3: begin
                    if (push && can_write && !full) begin
                        memory[write_ptr] <= data_in;
                        write_ptr <= write_ptr + 1;
                        status <= status + 1;
                        next_state <= S4;
                    end else if (pop && can_read && !empty) begin
                        data_out <= memory[read_ptr];
                        read_ptr <= read_ptr + 1;
                        status <= status - 1;
                        next_state <= S2;
                    end else begin
                        next_state <= S3;
                    end
                end

                S4: begin
                    if (push && can_write && !full) begin
                        memory[write_ptr] <= data_in;
                        write_ptr <= write_ptr + 1;
                        status <= status + 1;
                        next_state <= S5;
                    end else if (pop && can_read && !empty) begin
                        data_out <= memory[read_ptr];
                        read_ptr <= read_ptr + 1;
                        status <= status - 1;
                        next_state <= S3;
                    end else begin
                        next_state <= S4;
                    end
                end

                S5: begin
                    if (push && can_write && !full) begin
                        memory[write_ptr] <= data_in;
                        write_ptr <= write_ptr + 1;
                        status <= status + 1;
                        next_state <= S6;
                    end else if (pop && can_read && !empty) begin
                        data_out <= memory[read_ptr];
                        read_ptr <= read_ptr + 1;
                        status <= status - 1;
                        next_state <= S4;
                    end else begin
                        next_state <= S5;
                    end
                end

                S6: begin
                    if (push && can_write && !full) begin
                        memory[write_ptr] <= data_in;
                        write_ptr <= write_ptr + 1;
                        status <= status + 1;
                        next_state <= S7;
                    end else if (pop && can_read && !empty) begin
                        data_out <= memory[read_ptr];
                        read_ptr <= read_ptr + 1;
                        status <= status - 1;
                        next_state <= S5;
                    end else begin
                        next_state <= S6;
                    end
                end

                S7: begin
                    if (push && can_write) begin
                        next_state <= S7;
                    end else if (pop && can_read && !empty) begin
                        data_out <= memory[read_ptr];
                        read_ptr <= read_ptr + 1;
                        status <= status - 1;
                        next_state <= S6;
                    end else begin
                        next_state <= S7;
                    end
                end
            endcase
        end
    end

    always @* begin
        full = (status == ADDRESS_DEPTH);
        empty = (status == 0);
    end

    always @(posedge clk) begin
        if (state == S0 && empty && pop && can_read)
            underflow <= 1;
        else if( push && can_write && full )
            overflow <= 1;
        else begin
            underflow <= 0;
            overflow <= 0;
        end
    end

endmodule