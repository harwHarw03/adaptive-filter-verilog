// File 8bit_gabung_coba.vhd translated with vhd2vl 3.0 VHDL to Verilog RTL translator
// vhd2vl settings:
//  * Verilog Module Declaration Style: 2001

// vhd2vl is Free (libre) Software:
//   Copyright (C) 2001-2023 Vincenzo Liguori - Ocean Logic Pty Ltd
//     http://www.ocean-logic.com
//   Modifications Copyright (C) 2006 Mark Gonzales - PMC Sierra Inc
//   Modifications (C) 2010 Shankar Giri
//   Modifications Copyright (C) 2002-2023 Larry Doolittle
//     http://doolittle.icarus.com/~larry/vhd2vl/
//   Modifications (C) 2017 Rodrigo A. Melo
//
//   vhd2vl comes with ABSOLUTELY NO WARRANTY.  Always check the resulting
//   Verilog for correctness, ideally with a formal verification tool.
//
//   You are welcome to redistribute vhd2vl under certain conditions.
//   See the license (GPLv2) file included with the source for details.

// The result of translation follows.  Its copyright status should be
// considered unchanged from the original VHDL.

// no timescale needed

module delapan_bit_gabung_coba(
input wire [7:0] a,
input wire [7:0] b,
input wire reset,
input wire enable,
input wire clock,
output wire done_delapanbitgabungcoba,
output wire [15:0] q,
output wire cout
);

//input masukan yang didapat dari keluaran q pada memory
//input masukan yang didapat dari keluaran miu 1
//output keluaran yang nantinya masuk kedalam miu 3


//output berupa carry out

//======================================================================================
//=====================================================================================
wire [7:0] s1; wire [7:0] s2; wire [7:0] s3; wire [7:0] s4; wire [7:0] s5; wire [7:0] s6; wire [7:0] s7; wire [7:0] s9;
wire s8;
wire cout_s5; wire cout_s6;
wire cin = 1'b0;
wire [15:0] c;
wire [7:0] aa;
wire [7:0] bb;  //=====================================================================================
//Signal untuk Sign Operation
wire [8:0] add_SO = 1'b0;

wire [7:0] SO[0:6];
parameter base_SO = 1'b1;
wire [1:0] Sign_OP_Check = 2'b00;
wire [8:0] a_extd = 9'b000000000;
wire [8:0] twosc = 9'b000000000;
wire [15:0] Output_SO = 16'b0000000000000000;
wire [15:0] Output_buff = 16'b0000000000000000;
parameter twosc_1 = 1'b1;
parameter SO_0 = 1'b0;
wire [15:0] untukmemory;
wire untukmemory_cout;
wire done_q;
wire done_cout;  //=====================================================================================

assign aa = a;
assign bb = {1'b0,b[6:0]};
gabung_coba gabung_coba_1(
    .a(aa[3:0]),
    .b(bb[3:0]),
    .c(s1));
gabung_coba gabung_coba_2(
    .a(aa[7:4]),
    .b(bb[3:0]),
    .c(s2));
gabung_coba gabung_coba_3(
    .a(aa[3:0]),
    .b(bb[7:4]),
    .c(s3));
gabung_coba gabung_coba_4(
    .a(aa[7:4]),
    .b(bb[7:4]),
    .c(s4));

assign c[3:0] = s1[3:0];
mcc_adder #(8) MCC_8bit_1(s2,s3,s5,cout_s5);

assign s7 = {4'b0000,s1[7:4]};
mcc_adder #(8) MCC_8bit_2(s7,s5,s6,cout_s6);


assign c[7:4] = s6[3:0];
assign s8 = cout_s5 | cout_s6;
assign s9 = {3'b000,s8,s6[7:4]};
mcc_adder #(8) MCC_8bit_3(s9,s4,c[15:8],untukmemory_cout);

//---------------------------------------------------
//Penentuan Sign Op--
//perkalian operasi signed--
genvar i;
generate for (i=0; i <= 6; i = i + 1) begin: g_sign_op
    assign SO[i] = b[i] == 1'b1 ? base_SO << i : {1{1'b0}};
end
endgenerate
assign a_extd[7:0] = a;

assign add_SO[8:1] = SO[0] + SO[1] + SO[2] + SO[3] + SO[4] + SO[5] + SO[6];

assign twosc = ( ~(a_extd & twosc_1)) + (1);
assign Sign_OP_Check[1] = a[7];
assign Sign_OP_Check[0] = b[7];
assign Output_SO[15:7] = Sign_OP_Check == 2'b11 ? add_SO + twosc[7:0] : Sign_OP_Check == 2'b10 ? add_SO : Sign_OP_Check == 2'b01 ? twosc : Sign_OP_Check == 2'b00 ? SO_0 : reset == 1'b1 ? SO_0 : SO_0;
//------------------------------------------------------------------------------------------
assign untukmemory = Output_SO + c;

memory_16bit memory16bit_1(
    .d(untukmemory),
    .reset(reset),
    .clock(clock),
    .q(q),
    .enable(enable),
    .done(done_q)
); 

memory_1bit memory1bit_1(
    .d(untukmemory_cout),
    .reset(reset),
    .clock(clock),
    .q(cout),
    .enable(enable),
    .done(done_cout)    
);

//done_delapanbitgabungcoba <= done_q;
assign done_delapanbitgabungcoba = done_q & done_cout;

endmodule
