module Div(
  input wire [31:0] A,
  input wire [31:0] B,
  input wire clock,
  input wire reset,

  output reg [31:0] HI,
  output reg [31:0] LO,
  output reg div_0,
  output reg Done
);