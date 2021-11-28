module SignExtend16(
    input  wire [15:0] data_in,
    output wire [31:0] data_out_32 
);

    assign data_out_32 = (data_in[15]) ? {{16{1'b1}}, data_in} : {{16{1'b0}}, data_in};

endmodule