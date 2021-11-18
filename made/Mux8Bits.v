module Mux8Bits (
    input wire [2:0] selector,
    input  wire [31:0] data_0,
    input  wire [31:0] data_1,
    input  wire [31:0] data_2,
    input  wire [31:0] data_3,
    input  wire [31:0] data_4,
    input  wire [31:0] data_5,
    input  wire [31:0] data_6,
    input  wire [31:0] data_7,
    output wire [31:0] data_output
);

    parameter IS_DATA_0 = 3'b000;
    parameter IS_DATA_1 = 3'b001;
    parameter IS_DATA_2 = 3'b010;
    parameter IS_DATA_3 = 3'b011;
    parameter IS_DATA_4 = 3'b100;
    parameter IS_DATA_5 = 3'b101;
    parameter IS_DATA_6 = 3'b110;
    parameter IS_DATA_7 = 3'b111;

    reg data;

    if (selector == IS_DATA_0) assign data = data_0;
    if (selector == IS_DATA_1) assign data = data_1;
    if (selector == IS_DATA_2) assign data = data_2;
    if (selector == IS_DATA_3) assign data = data_3;
    if (selector == IS_DATA_4) assign data = data_4;
    if (selector == IS_DATA_5) assign data = data_5;
    if (selector == IS_DATA_6) assign data = data_6;
    if (selector == IS_DATA_7) assign data = data_7;
 
    assign data_output = data;

endmodule