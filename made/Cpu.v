module Cpu (
    input wire clock,
    input wire reset,

    output wire [6:0] state
);
    // Sinais de controle

    wire [2:0] i_or_d;
    wire ir_write;
    wire reg_write;
    wire epc_write;
    wire read_or_write;
    wire mem_data_write;
    
    wire store_size_write;
    
    wire pc_write;
    wire pc_control;
    wire [2:0] pc_source;
    
    wire alu_src_a;
    wire [3:0] alu_op;
    wire alu_out_write;
    wire [2:0] alu_src_b;
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
    wire store_control;
    wire load_control;
    
    wire start_div;
    wire stop_div;
    wire start_multi;
    wire stop_multi;

    // Fios de dados

    wire [31:0] memory_out;
    wire [31:0] memory_data_out;
    wire [31:0] load_size_out;
    
    wire [31:0] pc_source_out;
    wire [31:0] pc_control_out;
    wire [31:0] pc_out;
    wire [31:0] epc_out;
    wire [31:0] exp_out;
    wire [31:0] i_or_d_out;

    wire [31:0] alu_out_reg_out;
    wire [31:0] alu_src_a_out;
    wire [31:0] alu_src_b_out;
    wire [31:0] shift_reg_out;
    wire [31:0] alu_reg_out;
    wire [31:0] alu_out;
    
    wire [4:0] reg_dist_out;
    wire [31:0] mem_to_reg_out;
    
    wire [31:0] reg_a_out;
    wire [31:0] reg_b_out;
    wire [31:0] a_out;
    wire [31:0] b_out;

    wire [31:0] mux_store_size_out;
    wire [4:0] shift_amount_out;
    wire [31:0] store_size_out;
    wire [31:0] shift_src_out;
    
    wire [31:0] hi_out;
    wire [31:0] lo_out;
    wire [31:0] mult_div_hi_out;
    wire [31:0] mult_div_lo_out;
    wire [31:0] div_src_a;
    wire [31:0] div_src_a_out;
    wire [31:0] div_src_b;
    wire [31:0] div_src_b_out;

    wire [31:0] sign_extend_16to32_out;
    wire [31:0] shift_left_16_out;
    wire [31:0] shift_right_2_out;
    wire [31:0] extend_ula_1_out;
    wire [31:0] sign_28_to_32_out;

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

    // Parametros de controle

    parameter NUMBER_4 = 32'd4;
    parameter NUMBER_16 = 5'd16;
    parameter NUMBER_227 = 32'd227;
    parameter REG_30 = 32'd30;
    parameter REG_31 = 32'd31;

    // Bloco central

    CtrlUnit cpu_ctrl (
        .clock(clock),
        .reset(reset),
        .state(state),
        .i_or_d(i_or_d),
        .ir_write(ir_write),
        .pc_write(pc_write),
        .reg_write(reg_write),
        .alu_scr_b(alu_src_b),
        .pc_control(pc_control),
        .memory_write(read_or_write),
        .alu_out_write(alu_out_write),
        .reg_dist_ctrl(reg_dist_ctrl)
    );

    // Blocos dados

    Memoria memory (
        .Clock(clock),
        .Wr(read_or_write),
        .Address(i_or_d_out),
        
        .Datain(store_size_out),
        .Dataout(memory_out)
    );

    ula32 ula_32 (
        .A(alu_src_a_out),
        .B(alu_src_b_out),
        .Seletor(alu_control),

        .S(alu_out),
        .z(ZR), 
        .Igual(EQ), 
        .Maior(GT), 
        .Menor(LT),
        .Negativo(NG), 
        .Overflow(overflow)
    );

    RegDesloc desloc (
        .Clk(clock),
        .Reset(reset),
        .N(shift_amount_out),
        .Shift(shift_control),
        .Entrada(shift_src_out),

        .Saida(shift_reg_out)
    );

    Banco_reg banco_reg (
        .Clk(clock),
        .Reset(reset),
        .ReadReg1(RS),
        .ReadReg2(RT),
        .RegWrite(reg_write),
        .WriteReg(reg_dist_out),
        .WriteData(mem_to_reg_out),
        
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

    // Multi e Div

    Div divisor (
        .clock(clock),
        .reset(reset),
        .A(div_src_a_out),
        .B(div_src_b_out),
        .HI(mult_div_hi_out),
        .LO(mult_div_lo_out),
        .div_0(start_div),
        .div_stop(stop_div)
    );
    
    Mult multiplicador (
        .clock(clock),
        .reset(reset),
        .A(a_out),
        .B(b_out),
        .HI(mult_div_hi_out),
        .LO(mult_div_lo_out),
        .mult_in(start_multi),
        .mult_out(stop_multi)
    );

    // Registradores  

    Registrador pc (
        .Clk(clock),
        .Reset(reset),
        .Load(pc_write),
        .Entrada(pc_control_out),
        
        .Saida(pc_out)
    );

    Registrador memory_data (
        .Clk(clock),
        .Reset(reset),
        .Entrada(memory_out),
        .Load(mem_data_write),
        
        .Saida(memory_data_out)
    );

    Registrador high (
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
        .Load(alu_out_write),
        .Entrada(alu_reg_out),
        
        .Saida(alu_out_reg_out)
    );

    Registrador epc_reg (
        .Clk(clock),
        .Reset(reset),
        .Load(epc_write),
        .Entrada(alu_out_reg_out),
        
        .Saida(epc_out)
    );

    Registrador store_size_reg (
        .Clk(clock),
        .Reset(reset),
        .Load(store_control),
        .Entrada(mux_store_size_out),
        
        .Saida(store_size_out)
    );
   
    Registrador load_size_reg (
        .Clk(clock),
        .Reset(reset),
        .Load(load_control),
        .Entrada(memory_data_out),
        
        .Saida(load_size_out)
    );

    // Blocos de controle

    Mux2Bits mux_alu_src_a (
        .selector(alu_src_a),
        .data_0(pc_out),
        .data_1(a_out),

        .data_output(alu_src_a_out)
    );
    
    Mux2Bits mux_store_size (
        .selector(store_size_write),
        .data_0(b_out),
        .data_1(memory_data_out),

        .data_output(mux_store_size_out)
    );

    Mux4Bits mux_alu_src_b (
        .selector(alu_scr_b),
        .data_0(b_out),
        .data_1(NUMBER_4),
        .data_2(shift_left_16_out),
        .data_3(shift_right_2_out),

        .data_output(alu_src_b_out)
    );
    
    Mux2Bits mux_div_src_a (
        .selector(div_src_a),
        .data_0(pc_out),
        .data_1(a_out),

        .data_output(div_src_a_out)
    );

    Mux2Bits mux_div_src_b (
        .selector(div_src_b),
        .data_0(memory_out),
        .data_1(b_out),

        .data_output(div_src_b_out)
    );
    
    Mux2Bits mux_pc_control (
        .selector(pc_control),
        .data_0(pc_source_out),
        .data_1(a_out),

        .data_output(pc_control_out)
    );

    Mux4Bits mux_i_or_d (
        .selector(i_or_d),
        .data_0(pc_out),
        .data_1(alu_out),
        .data_2(from_div),
        .data_3(exp_out),

        .data_output(i_or_d_out)
    );

    Mux4Bits shift_src (
        .selector(shift_src_control),
        .data_0(a_out),
        .data_1(b_out),
        .data_2(IMMEDIATE),
        .data_3(a_out),

        .data_output(shift_src_out)
    );

    Mux4Bits mux_shift_amount (
        .selector(shift_amount_control),
        .data_0(NUMBER_16),
        .data_1(memory_data_out),
        .data_2(b_out),
        .data_3(IMMEDIATE),

        .data_output(shift_amount_out)
    );

    Mux4Bits mux_pc_source (
        .selector(pc_source),
        .data_0(alu_out),
        .data_1(alu_reg_out),
        .data_2(sign_28_to_32_out),
        .data_3(epc_out),
        
        .data_output(pc_source_out)
    );

    Mux4Bits reg_dist (
        .selector(reg_dist_ctrl),
        .data_0(RT),
        .data_1(REG_31),
        .data_2(REG_30),
        .data_3(IMMEDIATE),

        .data_output(reg_dist_out)
    );

    Mux8Bits mux_mem_to_reg (
        .selector(mem_to_reg),
        .data_0(alu_out),
        .data_1(load_size_out),
        .data_2(hi_out),
        .data_3(lo_out),
        .data_4(extend_ula_1_out),
        .data_5(shift_reg_out),
        .data_6(extend_immediate_out),
        .data_7(NUMBER_227),

        .data_output(mem_to_reg_out)
    );

    // Extends

    SignExtend1 extend_ula (
        .data_in(alu_out),
        .data_out(extend_ula_out)
    );

    SignExtend16 extend_immediate (
        .data_in(IMMEDIATE),
        .data_out(extend_immediate_out)
    );

endmodule