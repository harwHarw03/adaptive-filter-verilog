module gabung_coba(
    input wire [3:0] a,
    input wire [3:0] b,
    output wire [7:0] c,
    output wire cout
);

//======================================================================================
wire [3:0] s1; wire [3:0] s2; wire [3:0] s3; wire [3:0] s4; wire [3:0] s5; wire [3:0] s6; wire [3:0] s7; wire [3:0] s9;
wire s8;
wire cout_s5; wire cout_s6;
wire cin = 1'b0;  //signal cout: STD_LOGIC;
//=====================================================================================

vedic_2x2 vedicmcc_1(a[1:0],b[1:0],s1);
vedic_2x2 vedicmcc_2(a[3:2],b[1:0],s2);
vedic_2x2 vedicmcc_3(a[1:0],b[3:2],s3);
vedic_2x2 vedicmcc_4(a[3:2],b[3:2],s4);


assign c[1:0] = s1[1:0];
mcc_adder #(4) MCC_4bit_1(s2, s3, s5, cout_s5);
assign s7 = {2'b00,s1[3:2]};
mcc_adder #(4) MCC_4bit_2(s7, s5, s6, cout_s6);

assign c[3:2] = s6[1:0];

assign s8 = cout_s5 | cout_s6;

assign s9 = {1'b0,s8,s6[3:2]};

mcc_adder #(4) MCC_4bit_3(s9, s4, c[7:4], cout);

endmodule
