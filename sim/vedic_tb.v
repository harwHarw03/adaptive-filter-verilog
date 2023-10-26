module testbench;

  // Define signals
  reg [1:0] a_2x2, b_2x2;
  reg [3:0] a_4x4, b_4x4;
  reg [7:0] a_8x8, b_8x8;
  wire [3:0] result_2x2;
  wire [7:0] result_4x4;
  wire [15:0] result_8x8;
  // Instantiate the Vedic multiplication modules
  vedic_2x2 vedic_2x2_inst(a_2x2, b_2x2, result_2x2);
  vedic_4x4 vedic_4x4_inst(a_4x4, b_4x4, result_4x4);
  vedic_8x8 vedic_8x8_inst(a_8x8, b_8x8, result_8x8);

  // Initialize the inputs
  initial begin
    
    // Test 2x2 multiplication
    a_2x2 = 2'b11; // First 2-bit number (e.g., 3)
    b_2x2 = 2'b10; // Second 2-bit number (e.g., 2)

    // Test 4x4 multiplication
    a_4x4 = 4'b1101; // First 4-bit number (e.g., 13)
    b_4x4 = 4'b0011; // Second 4-bit number (e.g., 3)

    a_8x8 = 8'b11011101; // First 4-bit number (e.g., 13)
    b_8x8 = 8'b00111101; // Second 4-bit number (e.g., 3)


    // Wait for a few time units to let the results propagate
    #10;

    // Display results
    $display("2x2 Multiplication: %b * %b = %b", a_2x2, b_2x2, result_2x2);
    $display("4x4 Multiplication: %b * %b = %b", a_4x4, b_4x4, result_4x4);
    $display("8x8 Multiplication: %b * %b = %b", a_8x8, b_8x8, result_8x8);

    // Finish simulation
    $finish;
  end

endmodule
// 0011010010101001
//  011010010101001