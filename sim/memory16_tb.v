module memory16bit_tb;

reg [15:0] data_in_tb;
reg reset_tb;
reg clock_tb;
reg enable_tb;
wire [15:0] data_out_tb;
wire done_tb;

// Instantiate the memory16bit module
memory16bit memory_inst (
    .d(data_in_tb),
    .reset(reset_tb),
    .clock(clock_tb),
    .enable(enable_tb),
    .q(data_out_tb),
    .done(done_tb)
);

// Clock generation (50% duty cycle)
always begin
    #5 clock_tb = ~clock_tb;
end

initial begin
    // Initialize testbench signals
    reset_tb = 1'b0;
    data_in_tb = 16'h0000;
    clock_tb = 1'b0;
    enable_tb = 1'b0;

    // Reset the memory
    reset_tb = 1'b1;
    #10 reset_tb = 1'b0;

    // Write data to the memory
    data_in_tb = 16'hABCD;
    enable_tb = 1'b1;
    #10 enable_tb = 1'b0;

    // Monitor the 'done' signal to check for completion
    if (done_tb == 1'b1) begin
        $display("Write operation completed successfully.");
    end else begin
        $display("Write operation did not complete as expected.");
    end

    // Read data from the memory
    data_in_tb = 16'h0000; // Reset data_in_tb
    enable_tb = 1'b1;
    #10 enable_tb = 1'b0;

    // Monitor the 'done' signal to check for completion
    if (done_tb == 1'b1) begin
        $display("Read operation completed successfully.");
    end else begin
        $display("Read operation did not complete as expected.");
    end

    // Finish simulation
    $finish;
end

endmodule

initial begin
    // Initialize testbench signals
    reset_tb = 0;
    d_tb = 0;
    clock_tb = 0;

    // Reset the memory and observe q
    reset_tb = 1;
    #10 reset_tb = 0;

    // Set data to 16'hABCD and observe q
    d_tb = 16'hABCD;
    #10 $display("Data Input: %h, Data Output: %h", d_tb, q_tb);

    // Set data to 16'h1234 and observe q
    d_tb = 16'h1234;
    #10 $display("Data Input: %h, Data Output: %h", d_tb, q_tb);

    // Finish simulation
    $finish;
end