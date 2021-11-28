module Div (
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
	reg [31:0] quotient;
	reg [31:0] rest;
	reg [31:0] divider; 
	assign div_0_exception = !B;
	wire [32:0] subtrated = {rest[30:0], quotient[31]} - divider; 

	always @(posedge clock) begin
		if (reset == 1'd1) begin
			
			rest = 32'b0;
			counter = 32;
			div_end = 1'd0;
			divider = 32'b0;
			HI[31:0] = 32'd0;
			LO[31:0] = 32'd0;
			quotient = 65'b0;

		end else begin

			if (div_start == 1'b1) begin
				divider = B;
				quotient = A;

				rest = 32'b0;
				counter = 32;
				div_end = 1'd0;
				HI[31:0] = 32'd0;
				LO[31:0] = 32'd0;
			end else begin

				if (subtrated[32] == 0) begin
					rest = subtrated[31:0];
					quotient = {quotient[30:0], 1'b1};
				end else begin
					rest = {rest[30:0], quotient[31]};
					quotient = {quotient[30:0], 1'b0};
				end

				if (counter > 0) begin
					counter = counter - 1;
				end

				if (counter == 0) begin
					HI = rest;
					counter = -1;
					LO = quotient;
					div_end = 1'b1;
				end

			end
		end
	end
endmodule