module gabung_coba_tb;

  reg [3:0] a;
  reg [3:0] b;

  wire [7:0] c;
  wire cout;

  gabung_coba uut (
    .a(a),
    .b(b),
    .c(c),
    .cout(cout)
  );

  reg clock = 0;
  always begin
    #5 clock = ~clock;
  end

  initial begin
    a = 4'b1101; // You can set different values for a and b
    b = 4'b0010;

    #10;
    
    $display("a = %b", a);
    $display("b = %b", b);
    $display("c = %b", c);
    $display("cout = %b", cout);

    $finish;
  end

endmodule
