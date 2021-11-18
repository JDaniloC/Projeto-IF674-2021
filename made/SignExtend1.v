module SignExtend1(
    input  wire         data_in,
    output wire [31:0]  data_out_32 
);

    assign data_out_32 = {{32{1'b0}}, data_in};

endmodule