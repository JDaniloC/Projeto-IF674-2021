module Cpu (
    input wire clock,
    input wire reset,
)
    // Sinais de controle

    wire [2:0] I_or_D;
    wire ir_write;
    wire reg_write;
    wire epc_write;
    wire read_or_write;
    wire mem_data_write;
    
    wire pc_write;
    wire pc_control;
    wire [2:0] pc_source;
    
    wire [2:0] alu_op;
    wire [2:0] alu_src_a;
    wire [2:0] alu_src_b;
    wire alu_out_control;
    wire [2:0] alu_control;
    
    wire [2:0] exp_control;
    wire [2:0] shift_control;
    wire [2:0] shift_src_control;
    wire [2:0] shift_amount_control;
    
    wire [2:0] reg_dist_ctrl;
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
    wire [31:0] epc_out;
    wire [31:0] exp_out;
    wire [31:0] i_or_d_out;

    wire [31:0] alu_src_a_out;
    wire [31:0] alu_src_b_out;
    wire [31:0] alu_reg_out;
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

    wire [31:0] sign_extend_16to32_out;
    wire [31:0] shift_left_16_out;
    wire [31:0] shift_right_2_out;
    wire [31:0] 28_to_32_out;

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
        .reg_dist_ctrl(reg_dist_ctrl),
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

    Registrador alu_out_reg (
        .Clk(clock),
        .Reset(reset),
        .Load(alu_out_control),
        .Entrada(alu_reg_out),
        
        .Saida(alu_out)
    );

    Registrador epc_reg (
        .Clk(clock),
        .Reset(reset),
        .Load(epc_write),
        .Entrada(alu_reg_out),
        
        .Saida(epc_out)
    );

    // Blocos de controle  

    Mux2Bits mux_alu_src_a (
        .seletor(alu_src_a),
        .data_0(pc_out),
        .data_1(a_out),
        .data_output(alu_src_a_out),
    );

    Mux4Bits mux_alu_src_b (
        .seletor(alu_scr_b),
        .data_0(b_out),
        .data_1(2'b11),
        .data_2(shift_left_16_out),
        .data_3(shift_right_2_out),
        .data_output(alu_scr_b_out)
    );

    Mux4Bits mux_i_or_d (
        .seletor(I_or_D),
        .data_0(pc_out),
        .data_1(alu_out),
        .data_2(from_div),
        .data_3(exp_out),
        .data_output(i_or_d_out),
    );

    Mux4Bits shift_src(
        .seletor(shift_src_control),
        .data_0(a_out),
        .data_1(b_out),
        .data_2(IMMEDIATE),
        .data_3(a_out),
        .data_output(shift_src_out),
    );

    Mux4Bits mux_shift_amount (
        .seletor(shift_amount_control),
        .data_0(2'b10000),
        .data_1(memory_data_out),
        .data_2(b_out),
        .data_3(IMMEDIATE), // This is less
        .data_output(shift_amount_out),
    );

    Mux4Bits mux_pc_source (
        .seletor(pc_source),
        .data_0(alu_out),
        .data_1(alu_reg_out),
        .data_2(28_to_32_out),
        .data_3(epc_out),
        .data_output(PCSource_out),
    );

    Mux4Bits reg_dist (
        .seletor(reg_dist_ctrl),
        .data_0(RS),
        .data_1(10'31),
        .data_2(10'30),
        .data_3(IMMEDIATE),
        .data_output(reg_dist_out),
    );

endmodule