module Mux8Bits (
    input wire [2:0] selector,
    input  wire [31:0] data_0,
    input  wire [31:0] data_1,
    input  wire [31:0] data_2,
    input  wire [31:0] data_3,
    input  wire [31:0] data_4,
    input  wire [31:0] data_5,
    input  wire [31:0] data_6,
    input  wire [31:0] data_5,
    input  wire [31:0] data_6,
    input  wire [31:0] data_7,
    output wire [31:0] data_output
);


    reg data;

    if(selector == 3'b000) assign data = data_0;
    if(selector == 3'b001) assign data = data_1;
    if(selector == 3'b010) assign data = data_2;
    if(selector == 3'b011) assign data = data_3;
    if(selector == 3'b100) assign data = data_4;
    if(selector == 3'b101) assign data = data_5;
    if(selector == 3'b110) assign data = data_6;
    if(selector == 3'b111) assign data = data_7;
 
    assign data_output = data;
    
endmodule