module Cpu (
    input wire clock,
    input wire reset,
)
    // Sinais de controle

    wire I_or_D;
    wire ir_write;
    wire reg_write;
    wire read_or_write;
    wire mem_data_write;
    
    wire pc_write;
    wire pc_control;
    wire [2:0] pc_source;
    
    wire [2:0] alu_op;
    wire [2:0] alu_src_a;
    wire [2:0] alu_src_b;
    wire [2:0] alu_control;
    
    wire [2:0] exp_control;
    wire [2:0] shift_control;
    
    wire [2:0] reg_dist;
    wire [3:0] mem_to_reg;
    
    wire div_or_mult;
    wire div_control;

    wire high_write;
    wire low_write;

    // Fios de dados

    wire [31:0] memory_out;
    wire [31:0] memory_data_out;
    
    wire [31:0] pc_source_out;
    wire [31:0] pc_out;

    wire [31:0] alu_src_a_out;
    wire [31:0] alu_src_b_out;
    wire [31:0] alu_out;
    
    wire [4:0] reg_dist_out;
    wire [31:0] data_src_out;
    
    wire [31:0] reg_a_out;
    wire [31:0] reg_b_out;
    wire [31:0] a_out;
    wire [31:0] b_out;

    wire [31:0] ss_out;
    wire [4:0] shift_src_out;
    wire [31:0] shift_amount_out;
    
    wire [31:0] hi_out;
    wire [31:0] lo_out;
    wire [31:0] mult_div_hi_out;
    wire [31:0] mult_div_lo_out;

    // Resultados da ULA

    wire NG;
    wire ZR;
    wire EQ; 
    wire GT; 
    wire LT; 
    wire overflow;

    // Instruções

    wire [5:0]  OPCODE;
    wire [4:0]  RS;
    wire [4:0]  RT;
    wire [15:0] IMMEDIATE;

    // Bloco central

    CtrlUnit cpu_ctrl (
        .clock(clock),
        .reset(reset),
        .I_or_D(I_or_D),
        .alu_op(alu_op),
        .reg_dist(reg_dist),
        .ir_write(ir_write),
        .pc_write(pc_write),
        .reg_write(reg_write),
        .pc_source(pc_source),
        .alu_src_a(alu_src_a),
        .alu_src_b(alu_src_b),
        .mem_to_reg(mem_to_reg),
        .pc_control(pc_control),
        .div_or_mult(div_or_mult),
        .div_control(div_control)
        .exp_control(exp_control),
        .alu_control(alu_control),
        .shift_control(shift_control),
        .read_or_write(read_or_write),
    );

    // Blocos dados

    Memoria memory (
        .clock(clock),
        .address(I_or_D),
        .wr(read_or_write),
        
        .data_in(ss_out),
        .data_out(memory_out)
    );

    ula32 ula_32 (
        .A(alu_src_a_out),
        .B(alu_src_b_out),
        .Seletor(alu_control),

        .S(alu_out),
        .z(ZR), 
        .Igual(EQ), 
        .Maior(GT), 
        .Menor(LT)  
        .Negativo(NG), 
        .Overflow(overflow), 
    );

    RegDesloc desloc (
        .Clk(clock),
        .Reset(reset),
        .N(shift_amount_out),
        .Shift(shift_control),
        .Entrada(shift_src_out),

        .Saida(Shift_reg_out)
    );

    Banco_reg banco_reg (
        .Clk(clock),
        .Reset(reset),
        .ReadReg1(RS),
        .ReadReg2(RT),
        .RegWrite(reg_write),
        .WriteReg(reg_dist_out),
        .WriteData(data_src_out),
        
        .ReadData1(reg_a_out),
        .ReadData2(reg_b_out)
    );

    Instr_Reg instruction_reg (
        .Clk(clock),
        .Reset(reset),
        .Load_ir(ir_write), 
        .Entrada(memory_out),

        .Instr31_26(OPCODE),
        .Instr25_21(RS),
        .Instr20_16(RT),
        .Instr15_0(IMMEDIATE)
    );

endmodule