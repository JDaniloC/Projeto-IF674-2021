module CtrlUnit (
		input clock,
		input reset,
		output reg [1:0] i_or_d,
		output reg [1:0] pc_source,
		output reg ir_write,
		output reg pc_write,
		output reg pc_control,
		output reg memory_write,
		output reg reg_write,
		
		output reg alu_src_a,
		output reg [2:0] alu_op,
		output reg alu_out_write,
		output reg [1:0] alu_src_b,
		output reg [2:0] mem_to_reg,
		output reg [1:0] reg_dist_ctrl,

		// output reg reset_out,

		//inputs
		input wire [5:0] op_code,
		input wire [5:0] funct
	);

  // parameters of states
	parameter FETCH_STEP_ONE = 7'b0000001;
	parameter FETCH_STEP_TWO = 7'b0000010;
	parameter FETCH_STEP_THREE = 7'b0000011;
	parameter DECODE_STEP_ONE = 7'b0000100;
	parameter DECODE_STEP_TWO = 7'b0000101;
	parameter CLOSE_WRITE = 7'b1001100;
	parameter WAIT = 7'b1001101; 
	
    parameter ADD = 7'b0000110;
	parameter ADD_SUB_AND = 7'b0001001;

	// parameters do opcode
	parameter R_INSTRUCTION = 6'b000000;

	// parameters do funct
	parameter ADD_FUNCT = 6'b100000;
		
	reg [6:0] state;

	initial begin
		state = FETCH_STEP_ONE;
		// reset_out = 1'b1;
	end

	always @(posedge clock) begin
		if (reset) begin
			// reset_out = 1'b0;
	  
			reg_write = 1'b1;
			mem_to_reg = 3'b111;
			reg_dist_ctrl = 2'b10;

			i_or_d = 2'b00;
			alu_op = 3'b000;
			ir_write = 1'b0;
			pc_write = 1'b0;
			alu_src_a = 1'b0;
			pc_source = 2'b00;
			alu_src_b = 2'b00;
			pc_control = 1'b0; 
			memory_write = 1'b0;
			alu_out_write = 1'b0; 

			state = FETCH_STEP_ONE;
		end else begin 
			case (state) 
				FETCH_STEP_ONE: begin

					alu_op = 3'b001;
					alu_src_b = 2'b01;

					reg_write = 1'b1;
					mem_to_reg = 3'b000;
					reg_dist_ctrl = 2'b10;

					i_or_d = 2'b00;
					ir_write = 1'b0;
					pc_write = 1'b0;
					alu_src_a = 1'b0;
					pc_source = 2'b00;
					pc_control = 1'b0; 
					memory_write = 1'b0;
					alu_out_write = 1'b0;
				
					state = FETCH_STEP_TWO;
				end

				FETCH_STEP_TWO: begin
						
					pc_write = 1'b1;

					alu_op = 3'b001;
					alu_src_a = 1'b0;
					pc_source = 2'b00;
					alu_src_b = 2'b01;
					pc_control = 1'b0; 
					mem_to_reg = 3'b000;

					i_or_d = 2'b00;
					ir_write = 1'b0;
					reg_write = 1'b0;
					memory_write = 1'b0;
					alu_out_write = 1'b0;
					reg_dist_ctrl = 2'b00;

					state = FETCH_STEP_THREE;
				end

				FETCH_STEP_THREE: begin

					pc_write = 1'b0;
					ir_write = 1'b1;

					alu_op = 3'b001;
					alu_src_a = 1'b0;
					pc_source = 2'b00;
					alu_src_b = 2'b01;
					pc_control = 1'b0;
					mem_to_reg = 3'b000;
					
					i_or_d = 2'b00;
					reg_write = 1'b0;
					memory_write = 1'b0;
					alu_out_write = 1'b0;
					reg_dist_ctrl = 2'b00;

					state = DECODE_STEP_ONE;
				end

				DECODE_STEP_ONE: begin

					alu_op = 3'b001;
					ir_write = 1'b0;
					reg_write = 1'b1;
					alu_src_b = 2'b11;
					alu_out_write = 1'b1;

					alu_src_a = 1'b0;
					mem_to_reg = 3'b000;
					
					i_or_d = 2'b00;
					pc_write = 1'b0;
					pc_source = 2'b00;
					pc_control = 1'b0; 
					memory_write = 1'b0;
					reg_dist_ctrl = 2'b00;

					state = DECODE_STEP_TWO;
				end

				DECODE_STEP_TWO: begin

					reg_write = 1'b0;
					alu_src_b = 2'b00;
					alu_out_write = 1'b0;

					alu_op = 3'b001;
					ir_write = 1'b0;
					alu_src_a = 1'b0;
					mem_to_reg = 3'b000;
					
					i_or_d = 2'b00;
					pc_write = 1'b0;
					pc_source = 2'b00;
					pc_control = 1'b0; 
					memory_write = 1'b0;
					reg_dist_ctrl = 2'b00;
					
					case (op_code)
						R_INSTRUCTION: begin
							case(funct)
								ADD_FUNCT: begin
									state = ADD; 
								end
							endcase
						end
					endcase
				end

				ADD: begin
					
					alu_op = 3'b001;
					alu_src_a = 1'b1;
					alu_out_write = 1'b1;

					alu_src_b = 2'b00;
					reg_dist_ctrl = 2'b00;
					mem_to_reg = 3'b000;

					i_or_d = 2'b00;
					ir_write = 1'b0;
					pc_write = 1'b0;
					reg_write = 1'b0;
					pc_source = 2'b00;
					pc_control = 1'b0; 
					memory_write = 1'b0;

					state = ADD_SUB_AND;
				end

				ADD_SUB_AND: begin
					
					alu_op = 3'b000;
					reg_write = 1'b1;
					alu_src_a = 1'b0;
					alu_out_write = 1'b0;
					reg_dist_ctrl = 2'b11;
					
					alu_src_b = 2'b00;
					mem_to_reg = 3'b000;

					i_or_d = 2'b00;
					ir_write = 1'b0;
					pc_write = 1'b0;
					pc_source = 2'b00;
					pc_control = 1'b0;
					memory_write = 1'b0;

					state = CLOSE_WRITE;
				end

				CLOSE_WRITE: begin
					
					alu_out_write = 1'b0;
					reg_dist_ctrl = 2'b00;

					i_or_d = 2'b00;
					alu_op = 3'b000;
					ir_write = 1'b0;
					pc_write = 1'b0;
					reg_write = 1'b0;
					pc_source = 2'b00;
					alu_src_a = 1'b0;
					alu_src_b = 2'b00;
					pc_control = 1'b0; 
					memory_write = 1'b0;
					mem_to_reg = 3'b000;
					
					state = FETCH_STEP_ONE;
				end
		  endcase
		end
	end
endmodule