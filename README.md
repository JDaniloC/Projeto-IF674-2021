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
- [ ] sll rd, rt, shamt
- [ ] sllv rd, rt, rt
- [ ] slt rd, rs, rt
- [ ] sra rd, rt, shamt
- [ ] srav rd, rs, rt
- [ ] srl rd, rt, shamt 
- [ ] break 
- [ ] Rte 
- [ ] divm rs,rt

### Instruções do tipo I

- [ ] addi rt, rs, imediato
- [ ] addiu rt, rs, imediato
- [ ] beq rs,rt, offset
- [ ] bne rs, rt, offset 
- [ ] ble rs, rt, offset 
- [ ] bgt rs, rtx, offset 
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