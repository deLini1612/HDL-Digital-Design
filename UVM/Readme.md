# UVM Basic Practice

## 1. UVM for basic ALU

### 1.1 The ALU SPEC
Design a 8-bit ALU which support 4 operations. Detail information:
- Design is clocked
- Using Active High Reset
- The input will be sent in current cycle and then DUT gives output on next cycle
- Support 4 operations: ADD, SUB, BITWISE AND, BITWISE OR. 
- We have 2 input ***A*** and ***B***

**Ports Configuration of DUT**


| Port  | Width | IO        |
| ----- | ----- | -------   |
| clk   | 1     | Input     |
| rst | 1     | Input     |
| A   | 8     | Input     |
| B   | 8     | Input     |
| opcode  | 2     | Input     |
| out   | 8     | Output    |
| carry_out  | 1     | Output    |


**ALU operations**

|opcode|Operation|
|----|----|
|00|A + B|
|01|A - B|
|10|A & B|
|11|A \| B|