# Single Cycle Processor with (S | U)DIV and MLA
Implementación de un Procesador Single Cycle con soporte para las siguientes operaciones:

- Data Processing (ADD , SUB , AND , OR, SDIV, UDIV , MLA)
- Memory Instruccions LDR,STR (con Immediate)
- Branch Instruccion (B Target)

ADD, SUB, AND, OR, SDIV y UDIV soportan shift en Src2

## (S | U) DIV format Instruction


```assembly
(S|U)DIV Rd, Rn, Rm
Rd ← Rn / Rm
```


| `cond` | `op` | `I` | `cmd` | `S` | `Rn` | `Rd` | `shamt5` | `sh` | `0` | `Rm` |
|--------|------|-----|-------|-----|------|------|----------|------|-----|------|


| Campo    | Descripción |
|----------|-------------|
| `cond`   | Conditional (4 bits) |
| `op`     | OpCode (2 bits) |
| `I`      | Immediate (1 bit) |
| `cmd`    | Comand Instruction (4 bits) |
| `S`      | Set Flags (1 bit) |
| `Rn`     | Rn (4 bits) |
| `Rd`     | Register Destiny (4 bits) |
| `shamt5` |  (5 bits) |
| `sh`     | Shift type (2 bits) |
| `0`      | reserved (1 bit) |
| `Rm`     | Rm  (4 bits) |


## MLA Format Instruction
```assembly
MLA Rd, Rn, Rm, Ra
Rd ← Rn*Rm + Ra
```


| `cond` | `op` | `I` | `cmd` | `S` | `Rn` | `Rd` | `Ra` | `1001` | `Rm` |
|--------|------|-----|-------|-----|------|------|------|--------|------|


| Campo    | Descripción                      |
|----------|----------------------------------|
| `cond`   | Conditional (4 bits)    |
| `op`     | OpCode (2 bits)              |
| `I`      | Immediate (1 bit), `0`   |
| `cmd`    | Comand Instruction (4 bits), `0011` |
| `S`      | Set Flags (1 bit), `0` |
| `Rn`     | Rn (4 bits)      |
| `Rd`     | Rd (4 bits)       |
| `Ra`     | Ra (4 bits)    |
| `1001`   | Fixed (4 bits)             |
| `Rm`     | Rm (4 bits)      |

