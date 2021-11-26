module SignExtend8(
    input   wire   [31:0]   memory_data,
    output  wire   [31:0]   sign_out_32 
);

    assign sign_out_32 = {{24{1'b0}}, memory_data[7:0]}; 

endmodule