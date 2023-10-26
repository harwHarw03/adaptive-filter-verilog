module memory_1bit (
    input d,
    input reset,
    input clock,
    input enable,
    output q, done
);

reg d_reg;

always @(posedge clock or posedge reset) begin
    if (reset) begin
        d_reg <= 1'b0;
    end else begin
        d_reg <= d;
    end
end

assign q = d_reg;

endmodule

module memory_8bit (
    input [7:0] a,
    input [7:0] w,
    input reset, 
    input clock,
    output reg [7:0] q,
    output reg done,
    input enable
);

reg [7:0] d;

always @(posedge clock or posedge reset) begin
    if (reset) begin
        done <= 1'b0;
        d <= 8'b0;
    end else begin
        if (enable) begin
        d <= a;
        done <= 1'b1;
        end
    end

    if (d != 8'h01)begin 
        q <= d;
        done <= 1'b1;
    end else begin 
        q <= w;
        done <= 1'b1;
    end
end

endmodule

module memory_16bit (
    input [15:0] d,         //input masukan
    input reset,
    input clock,
    input enable,
    output [15:0] q,       //output
    output done
);

reg [15:0] q_reg;
reg done_reg;

always @(posedge clock or posedge reset) begin
    if (reset) begin
        q_reg <= 16'b0;
        done_reg <= 1'b0;
    end else begin
        if (enable) begin
            q_reg <= d;
            done_reg <= 1'b1;
        end
    end
end

assign q = q_reg;
assign done = done_reg;

endmodule

