module ShiftLeft4(
    input  wire [31:0] data_in,
    output wire [31:0] shift_left_4_out
);

    assign shift_left_4_out = data_in << 2;

endmodule