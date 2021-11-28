module Mux4Bits (
    input  wire [1:0]  selector,
    input  wire [31:0] data_0,
    input  wire [31:0] data_1,
    input  wire [31:0] data_2,
    input  wire [31:0] data_3,
    output wire [31:0] data_output
);
    assign data_output = selector[0] ? (selector[1] ?  data_3 : data_1) : (selector[1] ? data_2 : data_0);
endmodule