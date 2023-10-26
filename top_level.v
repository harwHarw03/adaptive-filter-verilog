// File TOP_LEVEL.vhd translated with vhd2vl 3.0 VHDL to Verilog RTL translator
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

module TOP_LEVEL(
input wire clk,
input wire reset,
input wire rx_line,
output wire tx_line,
input wire [7:0] masukan,
output wire [7:0] luaran,
output wire done
);




//    Port ( masukan              : in STD_LOGIC_VECTOR(7 downto 0);   --rx
//           clk                  : in STD_LOGIC;
//           reset                : in STD_LOGIC;
//           least_mean_square    : out STD_LOGIC_VECTOR(7 downto 0);   --tx
//           keluaran_check       : out STD_LOGIC; --led
//           keluaran_vedic_16bit : out STD_LOGIC_VECTOR(15 downto 0);
//           rx_line              : in STD_LOGIC;  
//           tx_line              : out STD_LOGIC
//    );
//======================================================================================
//======================================================================================
wire keluaran_done_read_Dn;
wire keluaran_done_read_Xn;
wire keluaran_done_yn;
wire keluaran_done_en;
wire keluaran_done_wn;
wire keluaran_done_write_wn;
wire keluaran_next_input;
wire keluaran_memory_Dn_active;
wire keluaran_memory_Xn_active;
wire keluaran_memory_bobot_active;
wire keluaran_y_active;
wire keluaran_e_active;
wire keluaran_w_active;
wire keluaran_sys_reset_active;
wire [7:0] rx_data; wire [7:0] tx_data;
wire done_rx; wire done_tx;
wire valid_tx;
wire start_process; wire done_process; wire done_all;
wire full_buff_s2p;
wire wr_buff8; wire rd_buff8; wire full_buff_p2s;
wire reset2; wire reset_sys;  //signal signal
wire RX_DATA_VALID = 1'b0;
wire TX_DATA_VALID = 1'b0;
wire TX_ACTIVE = 1'b0;  //======================================================================================

  data_path data_path_1(
      .clock(clk),
    .reset(keluaran_sys_reset_active),
    .Dn(masukan),
    .Xn(masukan),
    .keluaran_check(keluaran_check),
    .keluaran_error(least_mean_square),
    .keluaran_vedic_16bit(keluaran_vedic_16bit),
    .done_read_Dn(keluaran_done_read_Dn),
    .done_read_Xn(keluaran_done_read_Xn),
    .done_yn(keluaran_done_yn),
    .done_en(keluaran_done_en),
    .done_wn(keluaran_done_wn),
    .done_write_wn(keluaran_done_write_wn),
    .next_input(keluaran_next_input),
    .memory_Dn_active(keluaran_memory_Dn_active),
    .memory_Xn_active(keluaran_memory_Xn_active),
    .memory_bobot_active(keluaran_memory_bobot_active),
    .y_active(keluaran_y_active),
    .e_active(keluaran_e_active),
    .w_active(keluaran_w_active));

  control_unit control_unit_1(
      .reset(reset),
    .clk(clk),
    .done_read_Dn(keluaran_done_read_Dn),
    .done_read_Xn(keluaran_done_read_Xn),
    .done_yn(keluaran_done_yn),
    .done_en(keluaran_done_en),
    .done_wn(keluaran_done_wn),
    .next_input(keluaran_next_input),
    .memory_Dn_active(keluaran_memory_Dn_active),
    .memory_bobot_active(keluaran_memory_bobot_active),
    .y_active(keluaran_y_active),
    .e_active(keluaran_e_active),
    .w_active(keluaran_w_active),
    .sys_reset_active(keluaran_sys_reset_active));

  //reset2 <= reset_sys or reset;
  //full_buffer_in <= full_buff_s2p;
  //full_buffer_out <= full_buff_p2s;
  //done <= done_all;
  uart_rx #(
      .g_CLKS_PER_BIT(10416),
    .g_CLKS_PER_HALF_BIT(5208))
  unit_uart_rx(
      .CLK(CLK),
    .CLR(reset),
    .RX_LINE(RX_LINE),
    .RX_DATA_VALID(done_rx),
    .RX_DATA(RX_DATA));

  uart_tx #(
      .g_CLKS_PER_BIT(10417))
  unit_uart_tx(
      .CLK(clk),
    .CLR(reset),
    .TX_DATA_VALID(valid_tx),
    .TX_DATA(tx_data),
    .TX_LINE(tx_line),
    .TX_ACTIVE(/* open */),
    .TX_DONE(done_tx));

    //UART_Recieve : UART_RX
  //    Port map(
  //        CLK           => Clk,
  //        CLR           => Reset,
  //        RX_LINE       => rx_line,
  //        RX_DATA_VALID => RX_DATA_VALID,
  //        RX_DATA       => RX_DATA);
  //UART_Transmite : UART_TX
  //    Port map(
  //        CLK           => Clk,
  //        CLR           => Reset,
  //        TX_LINE       => tx_line,
  //        TX_ACTIVE     => TX_ACTIVE,
  //        TX_DATA_VALID => TX_DATA_VALID,
  //        TX_DATA       => TX_DATA,
  //        TX_DONE       => done);

endmodule
