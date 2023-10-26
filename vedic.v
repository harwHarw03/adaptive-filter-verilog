// `timescale 1ns / 1ps

// this is a library of vedic multiplier

// please uncomment the MCC if you want to use Manchester Carry Adder for addition operation 
// the MCC library is writen on mcc.v 

// `define USE_MCC

module ha (a, b, sum, carry);
    input a, b;
    output sum, carry;
    
    assign sum = a ^ b;
    assign carry = a & b;
endmodule

module add_4bit (a, b, sum);
    input [3:0] a, b;
    output [3:0] sum;

    assign sum = a + b;
endmodule

module add_6bit (a, b, sum);
    input [5:0] a, b;
    output [5:0] sum;

    assign sum = a + b;
endmodule

module add_8bit (a, b, sum);
    input [7:0] a, b;
    output [7:0] sum;

    assign sum = a + b;
endmodule

module add_12bit (a, b, sum);
    input [11:0] a, b;
    output [11:0] sum;

    assign sum = a + b;
endmodule

module vedic_2x2 (a, b, c);
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

module vedic_4x4(a,b,c);
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

    vedic_2x2 z1(a[1:0],b[1:0],q0[3:0]);
    vedic_2x2 z2(a[3:2],b[1:0],q1[3:0]);
    vedic_2x2 z3(a[1:0],b[3:2],q2[3:0]);
    vedic_2x2 z4(a[3:2],b[3:2],q3[3:0]);

    assign temp1 ={2'b0,q0[3:2]};
// `ifdef 
//     mcc_adder #(4) z5(q1[3:0],temp1,q4);
// `else
    add_4bit z5(q1[3:0],temp1,q4);
// `endif 
    
    assign temp2 ={2'b0,q2[3:0]};
    assign temp3 ={q3[3:0],2'b0};
    add_6bit z6(temp2,temp3,q5);

    assign temp4={2'b0,q4[3:0]};
    add_6bit z7(temp4,q5,q6);
    assign c[1:0]=q0[1:0];
    assign c[7:2]=q6[5:0];
endmodule

// module vedic_8x8(a,b,c);
   
// input [7:0]a;
// input [7:0]b;
// output [15:0]c;

// wire [15:0]q0;	
// wire [15:0]q1;	
// wire [15:0]q2;
// wire [15:0]q3;	
// wire [15:0]c;
// wire [7:0]temp1;
// wire [11:0]temp2;
// wire [11:0]temp3;
// wire [11:0]temp4;
// wire [7:0]q4;
// wire [11:0]q5;
// wire [11:0]q6;

// vedic_4x4 z1(a[3:0],b[3:0],q0[15:0]);
// vedic_4x4 z2(a[7:4],b[3:0],q1[15:0]);
// vedic_4x4 z3(a[3:0],b[7:4],q2[15:0]);
// vedic_4x4 z4(a[7:4],b[7:4],q3[15:0]);

// assign temp1 ={4'b0,q0[7:4]};
// add_8bit z5(q1[7:0],temp1,q4);
// assign temp2 ={4'b0,q2[7:0]};
// assign temp3 ={q3[7:0],4'b0};
// add_12bit z6(temp2,temp3,q5);
// assign temp4={4'b0,q4[7:0]};

// add_12bit z7(temp4,q5,q6);

// assign c[3:0]=q0[3:0];
// assign c[15:4]=q6[11:0];
// endmodule