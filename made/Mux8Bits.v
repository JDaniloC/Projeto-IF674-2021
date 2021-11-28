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
    assign data_output = selector[0] ? (selector[1] ?  ( selector[2] ? data_7 :data_3 ) : (selector[2] ? data_5 :data_1 )) : (selector[1] ? (selector[2] ? data_6 : data_2 ) : (selector[2] ? data_4 : data_0 ));
endmodule