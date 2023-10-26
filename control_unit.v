module CONTROL_UNIT (
  input Clk,
  input Reset,
  input done_read_Dn,
  input done_read_Xn,
  input done_yn,
  input done_en,
  input done_wn,
  input next_input,
  output memory_Dn_active,
  output memory_Xn_active,
  output memory_bobot_active,
  output memory_16bit_active,
  output memory_1bit_active,
  output y_active,
  output e_active,
  output w_active,
  output tx_data_valid_active,
  output sys_reset_active
);

  reg [2:0] state;

  always @(posedge Clk or posedge Reset) begin
    if (Reset) begin
      state <= 3'b111;
    end else if (Clk) begin
      case (state)
        3'b001:
          begin
            memory_Dn_active <= 1'b1;
            memory_Xn_active <= 1'b0;
            memory_bobot_active <= 1'b0;
            memory_16bit_active <= 1'b0;
            memory_1bit_active <= 1'b0;
            y_active <= 1'b0;
            e_active <= 1'b0;
            w_active <= 1'b0;
            tx_data_valid_active <= 1'b0;
            sys_reset_active <= 1'b0;
            if (done_read_Dn)
              state <= 3'b010;
            else
              state <= 3'b001;
          end
        3'b010:
          begin
            memory_Dn_active <= 1'b0;
            memory_Xn_active <= 1'b1;
            memory_bobot_active <= 1'b0;
            memory_16bit_active <= 1'b0;
            memory_1bit_active <= 1'b0;
            y_active <= 1'b0;
            e_active <= 1'b0;
            w_active <= 1'b0;
            tx_data_valid_active <= 1'b0;
            sys_reset_active <= 1'b0;
            if (done_read_Xn)
              state <= 3'b011;
            else
              state <= 3'b010;
          end
        3'b011:
          begin
            memory_Dn_active <= 1'b0;
            memory_Xn_active <= 1'b0;
            memory_bobot_active <= 1'b0;
            memory_16bit_active <= 1'b1;
            memory_1bit_active <= 1'b1;
            y_active <= 1'b1;
            e_active <= 1'b0;
            w_active <= 1'b0;
            tx_data_valid_active <= 1'b0;
            sys_reset_active <= 1'b0;
            if (done_yn)
              state <= 3'b100;
            else
              state <= 3'b011;
          end
        3'b100:
          begin
            memory_Dn_active <= 1'b0;
            memory_Xn_active <= 1'b0;
            memory_bobot_active <= 1'b0;
            memory_16bit_active <= 1'b0;
            memory_1bit_active <= 1'b1;
            y_active <= 1'b0;
            e_active <= 1'b1;
            w_active <= 1'b0;
            tx_data_valid_active <= 1'b0;
            sys_reset_active <= 1'b0;
            if (done_en)
              state <= 3'b110;
            else
              state <= 3'b101;
          end
        3'b101:
          begin
            memory_Dn_active <= 1'b0;
            memory_Xn_active <= 1'b0;
            memory_bobot_active <= 1'b1;
            memory_16bit_active <= 1'b1;
            memory_1bit_active <= 1'b1;
            y_active <= 1'b0;
            e_active <= 1'b0;
            w_active <= 1'b1;
            tx_data_valid_active <= 1'b0;
            sys_reset_active <= 1'b0;
            if (done_wn)
              state <= 3'b011;
            else
              state <= 3'b101;
          end
        3'b110:
          begin
            memory_Dn_active <= 1'b0;
            memory_Xn_active <= 1'b0;
            memory_bobot_active <= 1'b0;
            memory_16bit_active <= 1'b0;
            memory_1bit_active <= 1'b0;
            y_active <= 1'b0;
            e_active <= 1'b0;
            w_active <= 1'b0;
            tx_data_valid_active <= 1'b1;
            sys_reset_active <= 1'b0;
            state <= 3'b110;
          end
        3'b111:
          begin
            memory_Dn_active <= 1'b0;
            memory_Xn_active <= 1'b0;
            memory_bobot_active <= 1'b0;
            memory_16bit_active <= 1'b0;
            memory_1bit_active <= 1'b0;
            y_active <= 1'b0;
            e_active <= 1'b0;
            w_active <= 1'b0;
            tx_data_valid_active <= 1'b0;
            sys_reset_active <= 1'b1;
            state <= 3'b001;
          end
      endcase
    end
  end

endmodule
