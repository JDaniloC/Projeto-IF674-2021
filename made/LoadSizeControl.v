
module LoadSizeControl (
	input wire [31:0] memory_data_out,
	input wire [1:0] load_size_control,
	output reg [31:0] load_size_control_out
);
	parameter S1 = 1, S2 = 2, S3 = 3;
	always @(*) begin
		case(load_size_control)
			S1:
				load_size_control_out <= memory_data_out;
			S2:
				load_size_control_out <= {16'd0,memory_data_out[15:0]};
			S3:
				load_size_control_out <= {24'd0,memory_data_out[7:0]};
		endcase
	end

endmodule