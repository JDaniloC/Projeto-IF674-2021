# Projeto Processador

> Projeto em Verilog que visa construir um processador RISC usando instruções do MIPS.

## Instruções feitas:

Essas são as instruções que conseguimos fazer:

### Instruções do tipo R

- [x] add rd, rs, rt
- [x] and rd, rs, rt
- [x] sub rd, rs, rt
- [x] sll rd, rt, shamt
- [x] sra rd, rt, shamt
- [x] srl rd, rt, shamt 
- [x] sllv rd, rs, rt
- [x] srav rd, rs, rt
- [x] slt rd, rs, rt
- [x] jr rs
- [x] break 
- [x] Rte 
- [ ] div rs, rt
- [ ] mult rs, rt
- [ ] mfhi rd
- [ ] mflo rd
- [ ] divm rs,rt

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
- [ ] lw rt, offset(rs)
- [ ] lui rt, imediato
- [x] sb rt, offset(rs)
- [x] sh rt, offset(rs)
- [x] sw rt, offset(rs)
- [ ] slti rt, rs, imediato

### Instruções do tipo J

- [x] j offset
- [x] jal offset

### Exceção
- [ ] Overflow
- [ ] div by 0
- [ ] opcode inexistente
