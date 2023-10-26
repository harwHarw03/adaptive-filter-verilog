// module testbench;

//   // Parameters
//   localparam N_4BIT = 4;
//   localparam N_6BIT = 6;
//   localparam N_8BIT = 8;

//   // Inputs
//   reg [N_4BIT-1:0] a_4bit, b_4bit;
//   reg [N_6BIT-1:0] a_6bit, b_6bit;
//   reg [N_8BIT-1:0] a_8bit, b_8bit;

//   // Outputs
//   wire [N_4BIT-1:0] sum_4bit;
//   wire [N_6BIT-1:0] sum_6bit;
//   wire [N_8BIT-1:0] sum_8bit;
//   wire cout_4bit, cout_6bit, cout_8bit;

//   // Instantiate MCC Adders
//   mcc_adder #(N_4BIT) u_4bit(a_4bit, b_4bit, sum_4bit, cout_4bit);
//   mcc_adder #(N_6BIT) u_6bit(a_6bit, b_6bit, sum_6bit, cout_6bit);
//   mcc_adder #(N_8BIT) u_8bit(a_8bit, b_8bit, sum_8bit, cout_8bit);

//   // Test vectors
//   initial begin
//     // Test case 1
//     a_4bit = 4'b1010;
//     b_4bit = 4'b1101;
//     #10 $display("4-bit: a=%b b=%b sum=%b cout=%b", a_4bit, b_4bit, sum_4bit, cout_4bit);

//     // Test case 2
//     a_6bit = 6'b110110;
//     b_6bit = 6'b010101;
//     #10 $display("6-bit: a=%b b=%b sum=%b cout=%b", a_6bit, b_6bit, sum_6bit, cout_6bit);

//     // Test case 3
//     a_8bit = 8'b11110000;
//     b_8bit = 8'b01010101;
//     #10 $display("8-bit: a=%b b=%b sum=%b cout=%b", a_8bit, b_8bit, sum_8bit, cout_8bit);

//     // Additional test cases can be added here

//     $finish;
//   end

// endmodule


module testbench;

  // Parameters
  localparam N_4BIT = 4;
  localparam N_6BIT = 6;
  localparam N_8BIT = 8;

  // Inputs
  reg [N_4BIT-1:0] a_4bit, b_4bit;
  reg [N_6BIT-1:0] a_6bit, b_6bit;
  reg [N_8BIT-1:0] a_8bit, b_8bit;

  // Outputs
  wire [2*N_4BIT-1:0] sum_4bit;
  wire [2*N_6BIT-1:0] sum_6bit;
  wire [2*N_8BIT-1:0] sum_8bit;
  wire cout_4bit, cout_6bit, cout_8bit;

  // Instantiate MCC Adders
  mcc_adder #(N_4BIT) u_4bit(a_4bit, b_4bit, sum_4bit, cout_4bit);
  mcc_adder #(N_6BIT) u_6bit(a_6bit, b_6bit, sum_6bit, cout_6bit);
  mcc_adder #(N_8BIT) u_8bit(a_8bit, b_8bit, sum_8bit, cout_8bit);

  // Test vectors
  initial begin
    // Test case 1
    a_4bit = 4'b1010;
    b_4bit = 4'b1101;
    #10 $display("4-bit: a=%b b=%b sum=%b cout=%b complete=%08b", a_4bit, b_4bit, sum_4bit, cout_4bit, {cout_4bit, sum_4bit});

    // Test case 2
    a_6bit = 6'b110110;
    b_6bit = 6'b010101;
    #10 $display("6-bit: a=%b b=%b sum=%b cout=%b complete=%012b", a_6bit, b_6bit, sum_6bit, cout_6bit, {cout_6bit, sum_6bit});

    // Test case 3
    a_8bit = 8'b11110000;
    b_8bit = 8'b01010101;
    #10 $display("8-bit: a=%b b=%b sum=%b cout=%b complete=%016b", a_8bit, b_8bit, sum_8bit, cout_8bit, {cout_8bit, sum_8bit});

    // Additional test cases can be added here

    $finish;
  end

endmodule
