module memory_top (
    input [3:0] a4bit,
    input [15:0] a16bit,
    input reset, clock, enable,
    output [3:0] q4bit,
    output [15:0] q16bit,
    output done4bit,
    output done16bit
);

    memory_4bit mem4bit (
        .a(a4bit),
        .reset(reset),
        .clock(clock),
        .q(q4bit),
        .done(done4bit),
        .enable(enable)
    );

    memory_16bit mem16bit (
        .a(a16bit),
        .reset(reset),
        .clock(clock),
        .q(q16bit),
        .done(done16bit),
        .enable(enable)
    );

endmodule
