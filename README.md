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
- [x] div rs, rt
- [x] mult rs, rt
- [x] mfhi rd
- [x] mflo rd
- [ ] divm rs, rt

### Instruções do tipo I

- [x] addi rt, rs, imediato
- [x] addiu rt, rs, imediato
- [x] beq rs,rt, offset
- [x] bne rs, rt, offset 
- [x] ble rs, rt, offset 
- [x] bgt rs, rtx, offset 
- [x] lb rt, offset(rs) 
- [x] lh rt, offset(rs)
- [x] lw rt, offset(rs)
- [x] lui rt, imediato
- [x] sb rt, offset(rs)
- [x] sh rt, offset(rs)
- [x] sw rt, offset(rs)
- [ ] sram rt, offset(rs) 
- [x] slti rt, rs, imediato

### Instruções do tipo J

- [x] j offset
- [x] jal offset

### Exceção
- [ ] Overflow
- [ ] div by 0
- [ ] opcode inexistente
