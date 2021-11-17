module ShiftLeft16(
    input  wire [15:0] data_in,
    output wire [31:0] shift_left_16_out
);

    wire [31:0] data;

    assign data = {{16{1'b0}}, data_in};
    assign shift_left_16_out = data << 16;

endmodule