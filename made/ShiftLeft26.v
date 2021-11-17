module ShiftLeft26(
    input  wire [25:0] data_in,
    output wire [27:0] shif_left_26_out
);

    wire [27:0] data;

    assign data = {{2{1'b0}}, data_in};
    assign shif_left_26_out = data << 2;

endmodule