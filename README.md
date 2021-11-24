# Projeto Processador

> Projeto em Verilog que visa construir um processador RISC usando instruções do MIPS.

## Instruções feitas:

Essas são as instruções que conseguimos fazer:

### Instruções do tipo R

- [x] add rd, rs, rt
- [x] and rd, rs, rt
- [x] sub rd, rs, rt
- [ ] div rs, rt
- [ ] mult rs, rt
- [ ] jr rs
- [ ] mfhi rd
- [ ] mflo rd
- [x] sll rd, rt, shamt
- [x] sra rd, rt, shamt
- [x] srl rd, rt, shamt 
- [x] sllv rd, rs, rt
- [x] srav rd, rs, rt
- [ ] slt rd, rs, rt
- [ ] break 
- [ ] Rte 
- [ ] divm rs,rt

slt 3, 1, 2
slt 3, 2, 1

### Instruções do tipo I

- [x] addi rt, rs, imediato
- [ ] addiu rt, rs, imediato
- [x] beq rs,rt, offset
- [x] bne rs, rt, offset 
- [x] ble rs, rt, offset 
- [x] bgt rs, rtx, offset 
- [ ] sram rt, offset(rs) 
- [ ] lb rt, offset(rs) 
- [ ] lh rt, offset(rs)
- [ ] lui rt, imediato
- [ ] lw rt, offset(rs)
- [ ] sb rt, offset(rs)
- [ ] sh rt, offset(rs)
- [ ] slti rt, rs, imediato
- [ ] sw rt, offset(rs)

### Instruções do tipo J

- [ ] j offset
- [ ] jal offset

### Exceção
- [ ] Overflow
- [ ] div 0
- [ ] opcode inexistente
