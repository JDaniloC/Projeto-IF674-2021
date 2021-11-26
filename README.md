# Projeto Processador

> Projeto em Verilog que visa construir um processador RISC usando instruções do MIPS.

## Datapath

![DataPath](./docs/datapath.svg)

## Tabela de instruções

### Instruções do tipo R

|        Assembly        | Opcode | rs | rt | rd | shamt |  funct |     Comportamento    |
|:----------------------:|:------:|:--:|:--:|:--:|:-----:|:------:|:--------------------:|
|     add rd, rs, rt     | 000000 | rs | rt | rd |       | 100000 |     rd ← rs + rt     |
|     and rd, rs, rt     | 000000 | rs | rt | rd |       | 100100 |     rd ← rs & rt     |
|     sub rd, rs, rt     | 000000 | rs | rt | rd |       | 100010 |     rd ← rs – rt     |
|    sll rd, rt, shamt   | 000000 |    | rt | rd | shamt | 000000 |   rd ← rt << shamt   |
|    srl rd, rt, shamt   | 000000 |    | rt | rd | shamt | 000010 |   rd ← rt >> shamt   |
|    sra rd, rt, shamt   | 000000 |    | rt | rd | shamt | 000011 |   rd ← rt >> shamt*  |
|     sllv rd, rs, rt    | 000000 | rs | rt | rd |       | 000100 |     rd ← rs << rt    |
|     srav rd, rs, rt    | 000000 | rs | rt | rd |       | 000111 |    rd ← rs >> rt*    |
|     slt rd, rs, rt     | 000000 | rs | rt | rd |       | 101010 | rd ← (rs < rt) ?1 :0 |
|          jr rs         | 000000 | rs |    |    |       | 001000 |        PC ← rs       |
|          break         | 000000 |    |    |    |       | 001101 |      PC ← PC - 4     |
|           Rte          | 000000 |    |    |    |       | 010011 |       PC ← EPC       |
|       div rs, rt       | 000000 | rs | rt |    |       | 011010 |        rs / rt       |
|       mult rs, rt      | 000000 | rs | rt |    |       | 011000 |        rs x rt       |
|         mfhi rd        | 000000 |    |    | rd |       | 010000 |        rd ← hi       |
|         mflo rd        | 000000 |    |    | rd |       | 010010 |        rd ← lo       |
|       divm rs, rt      | 000000 | rs | rt |    |       | 000101 |   mem[rs] / mem[rt]  |

### Instruções do tipo I

|        Assembly        | Opcode | rs | rt | Imediato |          Comportamento         |
|:----------------------:|:------:|:--:|:--:|:--------:|:------------------------------:|
|  addi rt, rs, imediato | 001000 | rs | rt | imediato |      rt ← rs + imediato**      |
| addiu rt, rs, imediato | 001001 | rs | rt | imediato |      rt ← rs + imediato**      |
|    beq rs,rt, offset   | 000100 | rs | rt |  offset  |       Desvia se rs == rt       |
|    bne rs,rt, offset   | 000101 | rs | rt |  offset  |       Desvia se rs != rt       |
|    ble rs,rt,offset    | 000110 | rs | rt |  offset  |       Desvia se rs <= rt       |
|    bgt rs,rt,offset    | 000111 | rs | rt |  offset  |        Desvia se rs > rt       |
|   sram rt, offset(rs)  | 000001 | rs | rt |  offset  |  rt ← rt >> Mem[offset + rs]*  |
|    lb rt, offset(rs)   | 100000 | rs | rt |  offset  |   rt ← byte Mem[offset + rs]   |
|    lh rt, offset(rs)   | 100001 | rs | rt |  offset  | rt ← halfword Mem[offset + rs] |
|    lui rt, imediato    | 001111 |    | rt | imediato |       rt ← imediato << 16      |
|    lw rt, offset(rs)   | 100011 | rs | rt |  offset  |      rt ← Mem[offset + rs]     |
|    sb rt, offset(rs)   | 101000 | rs | rt |  offset  |   Mem[offset +rs] ← byte[rt]   |
|    sh rt, offset(rs)   | 101001 | rs | rt |  offset  | Mem[offset +rs] ← halfword[rt] |
|  slti rt, rs, imediato | 001010 | rs | rt | imediato |   rt ← (rs < imediato) ?1 :0   |
|    sw rt, offset(rs)   | 101011 | rs | rt |  offset  |      Mem[offset +rs] ← rt      |

### Instruções do tipo J

|  Assembly  | Opcode | Offset |     Comportamento     |
|:----------:|:------:|:------:|:---------------------:|
|  j offset  | 000010 | offset |         Desvia        |
| jal offset | 000011 | offset | reg[31] ← PC e desvia |

> \* instruções devem estender o sinal (deslocamento aritmético)

> ** o valor de ‘imediato’ deve ser estendido para 32 bits, estendendo seu sinal (bit mais significativo da constante).

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
- [x] divm rs, rt

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
- [x] slti rt, rs, imediato
- [ ] sram rt, offset(rs) 

### Instruções do tipo J

- [x] j offset
- [x] jal offset

### Exceção
- [ ] Overflow
- [ ] div by 0
- [ ] opcode inexistente
