// simplified version of MCC (Msnchester Carry Chain ADder)
// it will be used to do addition for supportinng vedic multiplier

module full_adder #(parameter N = 4)(
    input wire A,
    input wire B,
    input wire Cin,
    output wire Sum,
    output wire Cout
);

assign Sum = A ^ B ^ Cin;
assign Cout = (A & B) | (B & Cin) | (Cin & A);

endmodule

module gen_propagate #(parameter N = 4)(
    input wire A,
    input wire B,
    output wire G,
    output wire P
);

assign G = A & B;
assign P = A | B;

endmodule

module mcc_adder #(parameter N = 4)(
    input wire [N-1:0] A,
    input wire [N-1:0] B,
    output wire [N-1:0] Sum,
    output wire Cout
);

wire [N-1:0] G, P;
wire [N:0] C;

assign C[0] = 1'b0;

gen_propagate #(N) GP[0:N-1] (.A(A), .B(B), .G(G), .P(P));
genvar i;

generate
    for (i = 0; i < N; i = i + 1) begin
        assign Sum[i] = A[i] ^ B[i] ^ C[i];
        assign C[i+1] = (A[i] & B[i]) | (B[i] & C[i]) | (C[i] & A[i]);
    end
endgenerate

assign Cout = C[N];

endmodule



