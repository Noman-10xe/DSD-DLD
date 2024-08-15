module fifo #(parameter DATA_SIZE = 8, parameter ADDRESS_SIZE = 3)
             (input clk, rst, push, pop,
              input [DATA_SIZE-1:0] data_in,
              output reg [DATA_SIZE-1:0] data_out,
              output reg full, empty,
              output reg overflow, underflow);

    localparam ADDRESS_DEPTH = 2**ADDRESS_SIZE;
    reg [DATA_SIZE-1:0] memory [ADDRESS_DEPTH-1:0];
    reg [ADDRESS_SIZE-1:0] read_ptr, write_ptr;
    reg [ADDRESS_SIZE:0] status; // Extra bit for distinguishing full and empty

    integer i;

    //Empty & Full Logic
    assign empty = (status == 0);
    assign full = (status == ADDRESS_DEPTH);
  
    // Overflow & Underflow Logic
    assign overflow = (push && full);
    assign underflow = (pop && empty); 


    // Sequential logic for write and pointer updates
    always @(posedge clk or negedge rst) begin
    if (!rst) begin
        // Reset logic
        read_ptr <= 0;
        write_ptr <= 0;
        status <= 0;
        for (i = 0; i < ADDRESS_DEPTH; i = i + 1) begin
            memory[i] <= {DATA_SIZE{1'b0}};
        end
    end else begin
        if (push && pop) begin
            // If both push and pop occur at the same time
            if (!full && !empty) 
            begin
                memory[write_ptr] <= data_in; // Perform write
                write_ptr <= write_ptr + 1;
                read_ptr <= read_ptr + 1;
            end
            else if (full) begin
                read_ptr <= read_ptr + 1;
                status <= status - 1;
            end
            else if (empty) begin
                memory[write_ptr] <= data_in;
                write_ptr <= write_ptr + 1;
                status <= status + 1;
            end
        end else if (push && !full) begin
            memory[write_ptr] <= data_in; 
            write_ptr <= write_ptr + 1;
            status <= status + 1;
        end else if (pop && !empty) begin
            read_ptr <= read_ptr + 1;
            status <= status - 1;
        end
    end
end

    // Combinational logic for immediate read
    always @(*) begin
        if (push && pop) begin
            if (!full && !empty) 
            begin
                data_out = memory[read_ptr];  // Perform read
            end
            else if (full) begin
                data_out = memory[read_ptr];
            end
            end
        else if (pop && !empty ) begin
            data_out = memory[read_ptr]; // Perform read immediately
        end else begin
            data_out = 8'b0; // 0 value when pop is not active or FIFO is empty
        end
    end

endmodule