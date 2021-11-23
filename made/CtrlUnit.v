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
		output reg a_b_write,

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
	parameter CLOSE_WRITE 	   	= 7'b0000000;
	parameter FETCH_STEP_ONE   	= 7'b0000001;
	parameter FETCH_STEP_TWO   	= 7'b0000010;
	parameter FETCH_STEP_THREE 	= 7'b0000011;
	parameter DECODE_STEP_ONE  	= 7'b0000100;
	parameter DECODE_STEP_TWO  	= 7'b0000101;
  	parameter ADD 			    = 7'b0000110;
	parameter SUB 			    = 7'b0000111;
	parameter AND 			    = 7'b0001000;
	parameter ADD_SUB_AND 	   	= 7'b0001001;
	parameter SHIFT_SHAMT		= 7'b0001010;
	parameter ADDI_ADDIU    	= 7'b0001011;
	
	// parameters do opcode
	parameter R_INSTRUCTION = 6'b000000;
	parameter ADDI_OPCODE 	= 6'b001000;
	parameter ADDIU_OPCODE 	= 6'b001001;
	parameter BEQ_OPCODE 	= 6'b000100;
	parameter BNE_OPCODE 	= 6'b000101;
	parameter BLE_OPCODE 	= 6'b000110;
	parameter BGT_OPCODE 	= 6'b000111;
	parameter BLM_OPCODE 	= 6'b000001;
	parameter LB_OPCODE 	= 6'b100000;
	parameter LH_OPCODE 	= 6'b100001;
	parameter LUI_OPCODE 	= 6'b001111;
	parameter LW_OPCODE 	= 6'b100011;
	parameter SB_OPCODE 	= 6'b101000;
	parameter SH_OPCODE 	= 6'b101001;
	parameter SLTI_OPCODE 	= 6'b001010;
	parameter SW_OPCODE 	= 6'b101011;
	parameter J_OPCODE 		= 6'b000010;
	parameter JAL_OPCODE 	= 6'b000011;
	
	// parameters do funct
	parameter SLL_FUNCT 	= 6'b000000;
	parameter SRL_FUNCT 	= 6'b000010;
	parameter SRA_FUNCT 	= 6'b000011;
	parameter SLLV_FUNCT 	= 6'b000100;
	parameter XCHG_FUNCT 	= 6'b000101;
	parameter SRAV_FUNCT 	= 6'b000111;
	parameter JR_FUNCT 		= 6'b001000;
	parameter BREAK_FUNCT 	= 6'b001101;
	parameter MFHI_FUNCT 	= 6'b010000;
	parameter MFLO_FUNCT 	= 6'b010010;
	parameter RTE_FUNCT 	= 6'b010011;
	parameter DIV_FUNCT 	= 6'b011010;
	parameter MULT_FUNCT 	= 6'b011000;
	parameter ADD_FUNCT 	= 6'b100000;
	parameter AND_FUNCT 	= 6'b100100;
	parameter SUB_FUNCT 	= 6'b100010;
	parameter SLT_FUNCT 	= 6'b101010;

	// Ula operations

	parameter ULA_LOAD = 3'b000;
	parameter ULA_ADD = 3'b001;
	parameter ULA_SUB = 3'b010;
	parameter ULA_AND = 3'b011;
	parameter ULA_XOR = 3'b110;
	parameter ULA_NOT = 3'b101;
	parameter ULA_INC = 3'b100;

	reg [6:0] state;

	initial begin
		state = FETCH_STEP_ONE;
	end

	always @(posedge clock) begin
		if (reset) begin
	  
			reg_write = 1'b1;
			mem_to_reg = 3'b111;
			reg_dist_ctrl = 2'b10;

			i_or_d = 2'b00;
			ir_write = 1'b0;
			pc_write = 1'b0;
			alu_src_a = 1'b0;
			a_b_write = 1'b0;
			alu_op = ULA_LOAD;
			pc_source = 2'b00;
			alu_src_b = 2'b00;
			pc_control = 1'b0; 
			memory_write = 1'b0;
			alu_out_write = 1'b0; 

			state = FETCH_STEP_ONE;
		end else begin 
			case (state) 
				FETCH_STEP_ONE: begin

					alu_op = ULA_ADD;
					alu_src_b = 2'b01;

					reg_write = 1'b1;
					mem_to_reg = 3'b000;
					reg_dist_ctrl = 2'b10;

					i_or_d = 2'b00;
					ir_write = 1'b0;
					pc_write = 1'b0;
					a_b_write = 1'b0;
					alu_src_a = 1'b0;
					pc_source = 2'b00;
					pc_control = 1'b0; 
					memory_write = 1'b0;
					alu_out_write = 1'b0;
				
					state = FETCH_STEP_TWO;
				end

				FETCH_STEP_TWO: begin
						
					pc_write = 1'b1;

					alu_op = ULA_ADD;
					alu_src_a = 1'b0;
					pc_source = 2'b00;
					alu_src_b = 2'b01;
					pc_control = 1'b0; 
					mem_to_reg = 3'b000;

					i_or_d = 2'b00;
					ir_write = 1'b0;
					a_b_write = 1'b0;
					reg_write = 1'b0;
					memory_write = 1'b0;
					alu_out_write = 1'b0;
					reg_dist_ctrl = 2'b00;

					state = FETCH_STEP_THREE;
				end

				FETCH_STEP_THREE: begin

					pc_write = 1'b0;
					ir_write = 1'b1;

					alu_op = ULA_ADD;
					alu_src_a = 1'b0;
					pc_source = 2'b00;
					alu_src_b = 2'b01;
					pc_control = 1'b0;
					mem_to_reg = 3'b000;
					
					a_b_write = 1'b0;
					i_or_d = 2'b00;
					reg_write = 1'b0;
					memory_write = 1'b0;
					alu_out_write = 1'b0;
					reg_dist_ctrl = 2'b00;

					state = DECODE_STEP_ONE;
				end

				DECODE_STEP_ONE: begin

					alu_op = ULA_ADD;
					ir_write = 1'b0;
					a_b_write = 1'b1;
					alu_src_b = 2'b11;
					alu_out_write = 1'b1;

					reg_write = 1'b0;
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

					a_b_write = 1'b0;
					reg_write = 1'b0;
					alu_src_b = 2'b00;
					alu_out_write = 1'b0;

					alu_op = ULA_ADD;
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
								SUB_FUNCT: begin
									state = SUB; 
								end
								AND_FUNCT: begin
									state = AND; 
								end
								SLL_FUNCT: begin
									state = SHIFT_SHAMT;
								end
								SRA_FUNCT: begin
									state = SHIFT_SHAMT;
								end
								SRL_FUNCT: begin
									state = SHIFT_SHAMT;
								end
							endcase
						end

						ADDI_OPCODE: begin
							state = ADDI_ADDIU;
						end

						ADDIU_OPCODE: begin
							state = ADDI_ADDIU;
						end
					endcase
				end

				ADD: begin
					
					alu_op = ULA_ADD;
					alu_src_a = 1'b1;
					alu_out_write = 1'b1;

					alu_src_b = 2'b00;

					i_or_d = 2'b00;
					ir_write = 1'b0;
					pc_write = 1'b0;
					a_b_write = 1'b0;
					reg_write = 1'b0;
					pc_source = 2'b00;
					pc_control = 1'b0; 
					memory_write = 1'b0;
					mem_to_reg = 3'b000;
					reg_dist_ctrl = 2'b00;

					state = ADD_SUB_AND;
				end
					

				SUB: begin      
					alu_op = ULA_SUB;
					alu_src_a = 2'b01;
					alu_out_write = 1'b1;

					alu_src_b = 2'b00;

					i_or_d = 2'b00;
					ir_write = 1'b0;
					pc_write = 1'b0;
					a_b_write = 1'b0;
					reg_write = 1'b0;
					pc_source = 2'b00;
					pc_control = 1'b0; 
					memory_write = 1'b0;
					mem_to_reg = 3'b000;
					reg_dist_ctrl = 2'b00;

					state = ADD_SUB_AND;
				end

				AND: begin

					alu_op = ULA_AND;
					alu_src_a = 1'b1;
					alu_out_write = 1'b1;

					alu_src_b = 2'b00;
					reg_dist_ctrl = 2'b00;
					mem_to_reg = 3'b000;

					i_or_d = 2'b00;
					ir_write = 1'b0;
					pc_write = 1'b0;
					a_b_write = 1'b0;
					reg_write = 1'b0;
					pc_source = 2'b00;
					pc_control = 1'b0; 
					memory_write = 1'b0;

					state = ADD_SUB_AND;
				end

				ADD_SUB_AND: begin
					reg_write = 1'b1;
					alu_src_a = 1'b0;
					alu_op = ULA_LOAD;
					alu_out_write = 1'b0;
					reg_dist_ctrl = 2'b11;
					
					alu_src_b = 2'b00;
					mem_to_reg = 3'b000;

					i_or_d = 2'b00;
					ir_write = 1'b0;
					pc_write = 1'b0;
					a_b_write = 1'b0;
					pc_source = 2'b00;
					pc_control = 1'b0;
					memory_write = 1'b0;

					state = CLOSE_WRITE;
				end

				SHIFT_SHAMT: begin
					
					case(Funct)
						SLL_FUNCT: begin
							state = SLL;
						end
						SRA_FUNCT: begin
							state = SRA;
						end
						SRL_FUNCT: begin
							state = SRL;
						end
					endcase
				end

				SLL: begin
					state = SLL_SRA_SRL;
				end

				SRA: begin
					state = SLL_SRA_SRL;
				end

				SRL: begin
					state = SLL_SRA_SRL;
				end

				ADDI_ADDIU:

					
					

				CLOSE_WRITE: begin
					
					alu_out_write = 1'b0;
					reg_dist_ctrl = 2'b00;

					i_or_d = 2'b00;
					ir_write = 1'b0;
					pc_write = 1'b0;
					a_b_write = 1'b0;
					reg_write = 1'b0;
					alu_src_a = 1'b0;
					pc_source = 2'b00;
					alu_op = ULA_LOAD;
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