module Mux2Bits (
    input  wire selector,
    input  wire [31:0] data_0,
    input  wire [31:0] data_1,
    output wire [31:0] data_output
);

    assign data_output = (selector) ? data_1 : data_0;
    
endmodule