module Mux4Bits (
    input  wire [1:0]  selector,
    input  wire [31:0] data_0,
    input  wire [31:0] data_1,
    input  wire [31:0] data_2,
    input  wire [31:0] data_3,
    output wire [31:0] data_output
);

    reg data; 

    if(selector == 2'b00) data = data_0;
    if(selector == 2'b01) data = data_1;
    if(selector == 2'b10) data = data_2;
    if(selector == 2'b11) data = data_3;


    assign data_output = data;

endmodule