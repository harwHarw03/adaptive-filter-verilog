module memory_1bit_tb;
reg a, reset, clock, enable;
wire q, done;

memory_1bit memory1_uut(
    .d(a),
    .reset(reset),
    .clock(clock),
    .enable(enable),
    .q(q),
    .done(done)
);

// always begin
//     #10 clock = ~clock;
// end
initial begin
  forever begin
    #5 clock = 1'b0;
    #5 clock = 1'b1;
  end
end

initial begin
    a <= 1'b0;
    reset <= 1'b0;
    #5;
    $display("Clock Now : %b", clock);

    #5;
    $display("Clock Now : %b", clock);

    #5;
    $display("Clock Now : %b", clock);

    $dumpfile("memory_test.vcd");
    $dumpvars(0, memory_1bit_tb);
    $display("Starting simulation...");
    
    enable <= 1'b1;
    a <= 1'b1;
    #50;

    enable <= 1'b1;
    reset <= 1'b1;
    #50;
    a <= 1'b0;

    // #1000;
    $finish;
end

endmodule