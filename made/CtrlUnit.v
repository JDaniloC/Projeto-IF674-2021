module CtrlUnit (
	input clock,
	input reset,
	output reg i_or_d,
	output reg ir_write,
	output reg pc_write,
	output reg pc_control,
	output reg memory_write,
	output reg [2:0] pc_source,
	
	output reg alu_src_a,
	output reg [3:0] alu_op,
	output reg [2:0] alu_scr_b,

	output reg [6:0] state
  );

  parameter FETCH_STEP_ONE = 7'b0000001;
  parameter FETCH_STEP_TWO = 7'b0000010;
  parameter FETCH_STEP_THREE = 7'b0000011;


  initial begin
	state <= FETCH_STEP_ONE;
  end

  always @(posedge clock) begin
	  if (reset) begin
	  
		
		i_or_d = 2'b00;
		pc_write = 1'b0;
		ir_write = 1'b0;
		alu_op = 3'b000;
		ir_write = 1'b0; 
		alu_src_a = 1'b0;
		pc_source = 1'b0;
		alu_scr_b = 2'b00;
		pc_control = 1'b0; 
		memory_write = 1'b0;

		state = FETCH_STEP_ONE;
	  end else begin
		case (state) 
	  
		FETCH_STEP_ONE: begin

			alu_scr_b = 2'b01;
			alu_op = 3'b001;

			alu_src_a = 1'b0;
			pc_source = 1'b0;
			pc_control = 1'b0; 
			
			i_or_d = 2'b00;
			ir_write = 1'b0; 
			pc_write = 1'b0;
			memory_write = 1'b0;
  
			state = FETCH_STEP_TWO;
		end

		FETCH_STEP_TWO: begin
						
			pc_write = 1'b1;

			alu_op = 3'b001;
			alu_src_a = 1'b0;
			pc_source = 1'b0;
			alu_scr_b = 2'b01;
			pc_control = 1'b0; 
			
			i_or_d = 2'b00;
			ir_write = 1'b0; 
			memory_write = 1'b0;

			state = FETCH_STEP_THREE;
		end

		FETCH_STEP_THREE: begin

			pc_write = 1'b0;
			ir_write = 1'b1;

			alu_op = 3'b001;
			alu_src_a = 1'b0;
			pc_source = 1'b0;
			alu_scr_b = 2'b01;
			pc_control = 1'b0; 
			
			i_or_d = 2'b00;
			ir_write = 1'b0; 
			memory_write = 1'b0;

			state = FETCH_STEP_ONE;
		end

		endcase
	  end
  end

endmodule