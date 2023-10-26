// File error_check.vhd translated with vhd2vl 3.0 VHDL to Verilog RTL translator
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

module error_check(
    input wire [7:0] d,
    input wire [15:0] y,
    input wire enable,
    input wire clock,
    input wire reset,
    output wire done_errorcheck,
    output wire [7:0] z,
    output wire [7:0] e
);

//input masukan yang didapat dari Dn
//input masukan yang didapat dari 8bitgabungcoba
//output yang mengeluarkan nilai error yang didapat  
//output keluaran yang akan dijadikan masukan e pada pembaruan bobot



wire [7:0] q;
wire check;
wire [7:0] y_8bitconv;
wire [15:0] y_8bit;
wire [7:0] untukmemory_z;
wire untukmemory_c;
wire [7:0] untukmemory_e;
wire [7:0] untukmemory_w;
wire done_c;
wire done_z;
wire done_e;

//---------------------------------------------------------------------------------------------------------------------------------------
//y_8bitconv <= STD_LOGIC_VECTOR(resize(signed(y),8)); -- kalau error lagi, berarti disini yang salah, bit ke 8/16 yang dijadiin sign
// assign y_8bit = y[15] == 1'b0 ? {7'b0000000,y[15:7]} : ;
assign y_8bit = (y[15] == 1'b0) ? {7'b0000000, y[15:7]} : {7'b1111111, y[15:7]};
assign y_8bitconv = y_8bit[7:0];
c_addsub_1 your_instance_name(
	.A(d),
    .B(y_8bit[7:0]),
    .S(q));

//check <= '1' when to_integer(signed(q)) <= 100 and to_integer(signed(q)) >= -50 else           --rentang check error yaitu besar dari -1, kecil dari 1
//        '0';
//untukmemory_e <= q when check = '0' else        --masih error, kembali ke sistem
//    (others => '0');
//untukmemory_z <= y_8bitconv when check = '1' else        --tidak error, nilai diteruskan ke luaran
//   (others => '0'); 
assign untukmemory_e = q;
assign untukmemory_z = d;

memory_8bit memory_e(
	.a(untukmemory_e),
	.w(untukmemory_w),
	.reset(reset),
	.clock(clock),
	.q(e),
	.done(done_e),
	.enable(enable));

memory_8bit memory_z(
	.a(untukmemory_z),
	.w(untukmemory_w),
	.reset(reset),
	.clock(clock),
	.q(z),
	.done(done_z),
	.enable(enable));

//memory_c : memory1bit
//port map ( a=>check, reset=>reset, clock=>clock, q=>c, enable=>enable, done=>done_c);
assign done_errorcheck = done_e & done_z;

endmodule
