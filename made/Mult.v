module Mult (
    input wire [31:0] A,
    input wire [31:0] B,
    input wire clock,
    input wire reset,
    input wire mult_in


    output reg [31:0] hi,
    output reg [31:0] lo,
    output reg mult_out
);

reg [64:0] add, sub, product;
reg [31:0]
integer counter = 32;


    
endmodule