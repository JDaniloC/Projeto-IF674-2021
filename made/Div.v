module Div(
  input wire [31:0] A,
  input wire [31:0] B,
  input wire clock,
  input wire reset,
  input wire div_start,

  output reg div_end,
  output reg [31:0] HI,
  output reg [31:0] LO,
  output reg div_0_exception
);

    integer counter = 32;
	reg [64:0] quotient = 0;
	reg [31:0] rest ;
	reg [31:0] dividend; // dividendo
	reg [31:0] divider; // divider


	always @(posedge clock) begin
		if(reset == 1'd1) begin
			
			rest = 32'b0;
			counter = 32;
			div_end = 1'd0;
			HI[31:0] = 32'd0;
			LO[31:0] = 32'd0;
			quotient = 65'b0;
			div_0_exception = 1'd0;

		end else begin

			if (div_start == 1'b1) begin
				rest = 32'b0;
				counter = 32;
				div_end = 1'd0;
				HI[31:0] = 32'd0;
				LO[31:0] = 32'd0;
				quotient = 65'b0;
				div_0_exception = 1'd0;
			end 

			if (counter == 32) begin
				divider = B;
				dividend = A;
			end
			
			rest = dividend % divider;
			
			if ( dividend == 0) begin
				div_0_exception = 1;
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
				div_end = 1'b1;
				counter = -1;
			end
			
		end
	end
endmodule