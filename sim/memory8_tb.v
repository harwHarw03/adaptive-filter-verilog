module memory_8bit_tb;
reg [7:0] a;
reg [7:0] w;
reg reset;
reg clock;
wire [7:0] q;
wire done;
reg enable;

memory_8bit memory8_uut(
    .a(a),
    .w(w),
    .reset(reset), 
    .clock(clock),
    .q(q),
    .done(done),
    .enable(enable)
);

initial begin
    clock <= 1'b0;
    forever begin
        #1 clock = ~clock;
    end
end

initial begin
    a <= 8'b00000000;
    reset <= 1'b0;
    $dumpfile("memory_test.vcd");
    $dumpvars(0, memory_8bit_tb);
    #50;
    enable <= 1'b1;
    a <= 8'b1010101;
    #50;

    enable <= 1'b1;
    reset <= 1'b1;
    #50;
    a <= 8'b001010;
        #50;
    enable <= 1'b1;
    a <= 8'b1;
    #50;

    enable <= 1'b1;
    reset <= 1'b1;
    #50;
    a <= 8'b011001;
    $finish;
end

endmodule