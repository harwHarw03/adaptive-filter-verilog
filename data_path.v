// File data_path.vhd translated with vhd2vl 3.0 VHDL to Verilog RTL translator
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

//use IEEE.STD_LOGIC_UNSIGNED.ALL;
// no timescale needed

module data_path(
    input wire [7:0] Dn,
    input wire [7:0] Xn,
    input wire [7:0] Wn,
    input wire clock,
    output wire [7:0] z,
    output wire done_read_Dn,
    output wire done_read_Xn,
    output wire done_yn,
    output wire done_en,
    output wire done_write_wn,
    output wire done_wn1,
    input wire memory_Dn_active,
    input wire memory_Xn_active,
    input wire memory_bobot_active,
    input wire y_active,
    input wire e_active,
    input wire w_active,
    input wire sys_reset_active
);

//        reset : in STD_LOGIC
reg reset;
reg [7:0] keluaran;
reg [7:0] keluaran_error;
//======================================================================================
//======================================================================================
wire [7:0] keluaran_Dn;
wire [7:0] keluaran_memory;
wire [7:0] keluaran_Xn;
wire [15:0] keluaran_vedic;
wire [7:0] keluaran_en;
wire [7:0] keluaran_pembaruan_bobot;
wire done_wn;
wire check;
wire [7:0] untukmemory_z;
wire [7:0] untukmemory_w;
wire [7:0] keluaran_Wn;  //signal keluaran             : STD_LOGIC_VECTOR(7 downto 0);
//signal z              : STD_LOGIC_VECTOR(7 downto 0);
//======================================================================================

assign keluaran_Dn = Dn;
assign keluaran_Xn = Xn;
assign keluaran_Wn = Wn;

memory_8bit memory_bobot(
    .a(keluaran_pembaruan_bobot),
    .w(keluaran_Wn),
    .reset(sys_reset_active), 
    .clock(clock),
    .q(keluaran_memory),
    .done(done_write_wn),
    .enable(memory_bobot_active)
);

memory_8bit memory_Xn(
    .a(Xn),
    .w(keluaran_Wn),
    .reset(sys_reset_active), 
    .clock(clock),
    .q(keluaran_Xn),
    .done(done_read_Xn),
    .enable(memory_Xn_active)
);

memory_8bit memory_Dn(
    .a(Dn),
    .w(keluaran_Wn),
    .reset(sys_reset_active), 
    .clock(clock),
    .q(keluaran_Dn),
    .done(done_read_Dn),
    .enable(memory_Dn_active)
);

delapan_bit_gabung_coba delapan_bit_gabung_coba_1(
    .a(keluaran_memory),
    .b(keluaran_Xn),
    .reset(sys_reset_active),
    .enable(y_active),
    .clock(clock),
    .done_delapanbitgabungcoba(done_yn),
    .q(keluaran_vedic),
    .cout()
);


// //cek bener ga ini donenya
error_check error_check_1(
    .d(keluaran_Dn),
    .y(keluaran_vedic),
    .z(z),
    .clock(clock),
    .reset(sys_reset_active),
    .enable(e_active),
    .e(keluaran_en),
    .done_errorcheck(done_en));

// //cek bener ga ini donenya
pembaruan_bobot pembaruan_bobot_1(
      .e(keluaran_en),
    .w(keluaran_memory),
    .x(keluaran_Xn),
    .clock(clock),
    .reset(sys_reset_active),
    .enable(w_active),
    .keluaran(keluaran_pembaruan_bobot),
    .done_pembaruanbobot(done_wn1));

    //======================================================================================
//   reset => sys_reset_active;
//   keluaran<= z;
//   keluaran_error <= z;

endmodule
