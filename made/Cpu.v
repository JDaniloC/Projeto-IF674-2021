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

    // Fios de dados com 32 bits
    
    wire [31:0] sign_extend_16to32_out;
    wire [31:0] shift_left_mult_4_out;

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

    // Registradores  

    Registrador pc (
        .Clk(clock),
        .Reset(reset),
        .Load(pc_write),
        .Entrada(pc_source_out),
        
        .Saida(pc_out)
    );

    Registrador memory_data (
        .Clk(clock),
        .Reset(reset),
        .Entrada(memory_out),
        .Load(mem_data_write),
        
        .Saida(memory_data_out)
    );

    Registrador high(
        .Clk(clock),
        .Reset(reset),
        .Load(high_write),
        .Entrada(mult_div_hi_out),

        .Saida(hi_out)
    );

    Registrador low (
        .Clk(clock),
        .Reset(reset),
        .Load(low_write),
        .Entrada(mult_div_lo_out),
        
        .Saida(lo_out)
    );

    Registrador a_reg (
        .Clk(clock),
        .Reset(reset),
        .Load(reg_write), 
        .Entrada(reg_a_out),
        
        .Saida(a_out)
    );

    Registrador b_reg (
        .Clk(clock),
        .Reset(reset),
        .Load(reg_write),
        .Entrada(reg_b_out), 

        .Saida(b_out)
    );

    Registrador ALUOut_(
        .Clk(clock),
        .Reset(reset),
        ALUOutControl, // chart notation
        ALU_out,
        ALUOut_out
    );

    Registrador EPC_(
        .Clk(clock),
        .Reset(reset),
        EPCWrite, // chart notation
        ALU_out,
        EPC_out
    );

    // Blocos de controle  

    Mux2Bits AluScrA_(
        .alu_src_a,
        .pc_out,
        .a_out,
        .memory_data_out,
        .alu_src_a_out
    );

    Mux2Bits AluScrB_(
        .alu_scr_b,
        .b_out,
        .sign_extend_16to32_out,
        .shift_left_mult_4_out,
        .alu_scr_b_out
    );

endmodule