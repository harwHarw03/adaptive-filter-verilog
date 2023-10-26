`ifdef USE_MCC
module manchester_carry_chain_adder #(parameter DATA_WIDTH = 8)(
    input wire [DATA_WIDTH-1:0] a,
    input wire [DATA_WIDTH-1:0] b,
    output wire [DATA_WIDTH:0] sum
);

    wire [DATA_WIDTH:0] c;

    // Generate the carries
    generate
        genvar i;
        for (i = 0; i < DATA_WIDTH; i = i + 1) begin : manchester_carries
            assign c[i+1] = (a[i] & b[i]) | (a[i] & c[i]) | (b[i] & c[i]);
        end
    endgenerate

    // Calculate the sum bits
    assign sum[0] = a[0] ^ b[0] ^ c[0];
    generate
        genvar i;
        for (i = 1; i < DATA_WIDTH; i = i + 1) begin : manchester_sum
            assign sum[i] = a[i] ^ b[i] ^ c[i] ^ (c[i-1] & (a[i-1] ^ b[i-1]));
        end
    endgenerate

endmodule
`endif

module ha(a,b,sum,carry);
input a,b;
output sum,carry;
xor(sum,a,b);
and(carry,a,b);
endmodule

module add_4_bit (a,b,sum);
input [3:0] a,b;
output [3:0]sum;
`ifdef USE_MCC
    manchester_carry_chain_adder #(4) u1(a, b, sum);
`else
    assign sum = a + b;
`endif
endmodule

module add_6_bit (a,b,sum);
input [5:0] a,b;
output [5:0] sum;
`ifdef USE_MCC
    manchester_carry_chain_adder #(6) u1(a, b, sum);
`else
    assign sum = a + b;
`endif
endmodule

module add_8_bit (a,b,sum);
input[7:0] a,b;
output[7:0] sum;
`ifdef USE_MCC
    manchester_carry_chain_adder #(8) u1(a, b, sum);
`else
    assign sum = a + b;
`endif
endmodule

module add_12_bit (a,b,sum);
input[11:0] a,b;
output[11:0] sum;
`ifdef USE_MCC
    manchester_carry_chain_adder #(12) u1(a, b, sum);
`else
    assign sum = a + b;
`endif
endmodule

module vedic_2_x_2(a,b,c);
input [1:0]a;
input [1:0]b;
output [3:0]c;
wire [3:0]c;
wire [3:0]temp;
assign c[0]=a[0]&b[0]; 
assign temp[0]=a[1]&b[0];
assign temp[1]=a[0]&b[1];
assign temp[2]=a[1]&b[1];
ha z1(temp[0],temp[1],c[1],temp[3]);
ha z2(temp[2],temp[3],c[2],c[3]);
endmodule

module vedic_4_x_4(a,b,c);
input [3:0]a;
input [3:0]b;
output [7:0]c;
wire [3:0]q0;	
wire [3:0]q1;	
wire [3:0]q2;
wire [3:0]q3;	
wire [7:0]c;
wire [3:0]temp1;
wire [5:0]temp2;
wire [5:0]temp3;
wire [5:0]temp4;
wire [3:0]q4;
wire [5:0]q5;
wire [5:0]q6;

vedic_2_x_2 z1(a[1:0],b[1:0],q0[3:0]);
vedic_2_x_2 z2(a[3:2],b[1:0],q1[3:0]);
vedic_2_x_2 z3(a[1:0],b[3:2],q2[3:0]);
vedic_2_x_2 z4(a[3:2],b[3:2],q3[3:0]);

assign temp1 ={2'b0,q0[3:2]};
add_4_bit z5(q1[3:0],temp1,q4);
assign temp2 ={2'b0,q2[3:0]};
assign temp3 ={q3[3:0],2'b0};
add_6_bit z6(temp2,temp3,q5);

assign temp4={2'b0,q4[3:0]};
add_6_bit z7(temp4,q5,q6);
assign c[1:0]=q0[1:0];
assign c[7:2]=q6[5:0];
endmodule

module vedic_8X8(a,b,c);
   
input [7:0]a;
input [7:0]b;
output [15:0]c;

wire [15:0]q0;	
wire [15:0]q1;	
wire [15:0]q2;
wire [15:0]q3;	
wire [15:0]c;
wire [7:0]temp1;
wire [11:0]temp2;
wire [11:0]temp3;
wire [11:0]temp4;
wire [7:0]q4;
wire [11:0]q5;
wire [11:0]q6;

vedic_4_x_4 z1(a[3:0],b[3:0],q0[15:0]);
vedic_4_x_4 z2(a[7:4],b[3:0],q1[15:0]);
vedic_4_x_4 z3(a[3:0],b[7:4],q2[15:0]);
vedic_4_x_4 z4(a[7:4],b[7:4],q3[15:0]);

assign temp1 ={4'b0,q0[7:4]};
add_8_bit z5(q1[7:0],temp1,q4);
assign temp2 ={4'b0,q2[7:0]};
assign temp3 ={q3[7:0],4'b0};
add_12_bit z6(temp2,temp3,q5);
assign temp4={4'b0,q4[7:0]};

add_12_bit z7(temp4,q5,q6);

assign c[3:0]=q0[3:0];
assign c[15:4]=q6[11:0];
endmodule

module vedic_multiplier #(parameter USE_MCC = 0);
input [7:0] a, b;
output [15:0] c;

wire [15:0] temp[0:15];
wire [16:0] c[0:15];

vedic_4_x_4 u1(a[3:0], b[3:0], temp[0]);
vedic_4_x_4 u2(a[7:4], b[3:0], temp[1]);
vedic_4_x_4 u3(a[3:0], b[7:4], temp[2]);
vedic_4_x_4 u4(a[7:4], b[7:4], temp[3]);

// Calculate the carries
assign c[0] = 0;
generate
    genvar i;
    for (i = 1; i <= 15; i = i + 1) begin : manchester_carry_gen
        assign c[i] = temp[i-1][1] | (temp[i-1][0] & c[i-1]);
    end
endgenerate

// Calculate the sum bits
assign c[15] = temp[14][1] | (temp[14][0] & c[14]);
assign c[14] = temp[14][0] ^ c[14];
assign c[13] = temp[13][1] | (temp[13][0] & c[13]);
assign c[12] = temp[13][0] ^ c[13];
assign c[11] = temp[12][1] | (temp[12][0] & c[12]);
assign c[10] = temp[12][0] ^ c[12];
assign c[9] = temp[11][1] | (temp[11][0] & c[11]);
assign c[8] = temp[11][0] ^ c[11];
assign c[7] = temp[10][1] | (temp[10][0] & c[10]);
assign c[6] = temp[10][0] ^ c[10];
assign c[5] = temp[9][1] | (temp[9][0] & c[9]);
assign c[4] = temp[9][0] ^ c[9];
assign c[3] = temp[8][1] | (temp[8][0] & c[8]);
assign c[2] = temp[8][0] ^ c[8];
assign c[1] = temp[7][1] | (temp[7][0] & c[7]);
assign c[0] = temp[7][0] ^ c[7];

assign c[0:15] = {c[15], c[14], c[13], c[12], c[11], c[10], c[9], c[8], c[7], c[6], c[5], c[4], c[3], c[2], c[1], c[0];
endmodule

endmodule
