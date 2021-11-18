module Div(
  input wire [31:0] A,
  input wire [31:0] B,
  input wire clock,
  input wire reset,

  output reg [31:0] HI,
  output reg [31:0] LO,
  output reg div_0,
  output reg div_stop);

    integer counter = 32;
	reg [64:0] quotient = 0;
	reg [31:0] rest ;
	reg [31:0] dividend; // dividendo
	reg [31:0] divider; // divider


	always @(posedge clock) begin
		if (counter == 32) begin
			divider = B;
			dividend = A;
		end
		
		rest = dividend % divider;
		
		if ( dividend == 0) begin
			div_0 = 1;
		end

		rest = rest - divider;

		if (rest >= 0) begin
			quotient = quotient << 1;
			quotient[0] = 1'b1;
		end

		if (rest < 0) begin
			rest = rest + divider;
			quotient = quotient << 1;
			quotient[0] = 1'b0;
		end

		divider = divider >> 1;

		if (counter > 0) begin
			counter = (counter - 1);
		end

		if (counter == 0) begin
			//seta as saidas
			HI = quotient[64:33];
			LO = quotient[32:1];
			div_stop = 0;
			counter = -1;
		end
		
		if(counter == -1) begin
			rest = 32'b0;
			quotient = 65'b0;
		end

	end
endmodule