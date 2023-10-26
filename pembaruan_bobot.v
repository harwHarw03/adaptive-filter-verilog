// File pembaruan_bobot.vhd translated with vhd2vl 3.0 VHDL to Verilog RTL translator
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

module pembaruan_bobot(
    input wire [7:0] e,
    input wire [7:0] x,
    input wire [7:0] w,
    input wire enable,
    input wire reset,
    input wire clock,
    output wire done_pembaruanbobot,
    output wire [7:0] keluaran
);

//======================================================================================
//======================================================================================
wire [7:0] a;
wire [7:0] b;
wire [15:0] c;
wire [15:0] xe;
wire [15:0] xemiu;
wire [15:0] conv;
wire [7:0] untukmemory;
wire done_8bit;
wire [7:0] xe_conv;
wire [7:0] xemiu_conv;
wire [7:0] untukmemory_w;  //======================================================================================

delapan_bit_gabung_coba delapan_bit_gabung_coba_1(
    .a(e[7:0]),
    .b(x[7:0]),
    .q(xe[15:0]),
    .clock(clock),
    .reset(reset),
    .enable(enable),
    .done_delapanbitgabungcoba(done_8bit));

assign xemiu = (xe[15] == 1'b0) ? {7'b0000000, xe[15:7]} : {7'b1111111, xe[15:7]};
assign xemiu_conv = xemiu[7:0];
//xe_conv <= STD_LOGIC_VECTOR(resize(signed(xemiu),8));
c_addsub_0 your_instance_name(
    .A(xemiu_conv[7:0]),
    .B(w),
    .S(untukmemory));
assign keluaran = untukmemory;
memory_8bit memory_1(
    .a(untukmemory),
    .w(untukmemory_w),
    .reset(reset),
    .clock(clock),
    .q(keluaran),
    .done(done_pembaruanbobot),
    .enable(done_8bit)
    );


endmodule
