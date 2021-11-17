module CtrlUnit (
    input clock,
    input reset,
    output reg I_or_D;
    output reg ir_write;
    output reg reg_write;
    
    output reg mem_read;
    output reg read_or_write;
    
    output reg pc_write;
    output reg pc_control;
    output reg [2:0] pc_source;
    
    output reg [2:0] alu_op;
    output reg [2:0] alu_src_a;
    output reg [2:0] alu_src_b;
    
    output reg [2:0] exp_control;
    output reg [2:0] shift_control;
    
    output reg [2:0] reg_dist;
    output reg [3:0] mem_to_reg;
    
    output reg div_or_mult;
    output reg div_control;
    output reg [6:0] rst_out, 
)
  reg [1:0] STATE
  reg [2:0] COUNTER

  parameter RESET = 6'b11111111;
  parameter ST _RESET = 2'b11 ;

  initial begin
    //initial reset
    rst_out = 1'b1;
  end

  always @(posedge clock) begin
      if (reset == 1'b1) begin
          if (STATE !=  ST_RESET) begin
              
          end
      end
  end

endmodule