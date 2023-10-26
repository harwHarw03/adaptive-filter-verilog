module delapan_bit_gabung_coba_tb;

  // Inputs
  reg [7:0] a;
  reg [7:0] b;
  reg reset;
  reg enable;
  reg clock;

  // Outputs
  wire done_delapanbitgabungcoba;
  wire [15:0] q;
  wire cout;

  // Instantiate the module under test
  delapan_bit_gabung_coba uut (
    .a(a),
    .b(b),
    .reset(reset),
    .enable(enable),
    .clock(clock),
    .done_delapanbitgabungcoba(done_delapanbitgabungcoba),
    .q(q),
    .cout(cout)
  );

  // Clock generation
    always begin
        clock <= 1'b0;
        forever begin
           #5 clock = ~clock; 
        end
    end

  // Test stimulus
  initial begin
    // Initialize inputs
    a = 8'b11011011; // You can set different values for a and b
    b = 8'b10101010;
    reset = 0;
    enable = 1;
    clock = 0;
    $dumpfile("delapan_bit_gabung_coba_tb.vcd");
        $dumpvars(0, delapan_bit_gabung_coba_tb);
    // Apply inputs and wait for some time
    #100;

    // Print the results
    $display("a = %b", a);
    $display("b = %b", b);
    $display("reset = %b", reset);
    $display("enable = %b", enable);
    $display("clock = %b", clock);
    $display("q = %b", q);
    $display("cout = %b", cout);
    $display("done_delapanbitgabungcoba = %b", done_delapanbitgabungcoba);

    // Finish the simulation
    $finish;
  end

endmodule
