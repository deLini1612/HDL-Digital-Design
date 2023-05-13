- [Objective](#objective)
- [Data Types](#data-types)
  - [Verilog Syntax](#verilog-syntax)
    - [Verilog Number Format](#verilog-number-format)
    - [Verilog Strings Format](#verilog-strings-format)
  - [Verilog Data Types](#verilog-data-types)
    - [Nets](#nets)
    - [Variables](#variables)
    - [Other data types](#other-data-types)
  - [Verilog scalar and vector](#verilog-scalar-and-vector)
    - [Declaration](#declaration)
    - [Bit-selects and Part-selects](#bit-selects-and-part-selects)
  - [Verilog Arrays](#verilog-arrays)
- [Building Blocks](#building-blocks)
  - [Verilog Module](#verilog-module)
    - [Syntax](#syntax)
    - [Import modules within a module: Port connection](#import-modules-within-a-module-port-connection)
  - [Verilog Port](#verilog-port)
  - [Verilog procedural blocks](#verilog-procedural-blocks)
    - [Verilog always block](#verilog-always-block)
    - [Verilog initial block](#verilog-initial-block)
- [Behavioral modeling](#behavioral-modeling)
  - [Verilog block statements](#verilog-block-statements)
  - [Verilog Assignments](#verilog-assignments)
    - [Legal LHS values](#legal-lhs-values)
    - [Procedural Assignment](#procedural-assignment)
    - [Continuous Assignment](#continuous-assignment)
  - [Verilog Blocking \& Non-Blocking](#verilog-blocking--non-blocking)
    - [Blocking](#blocking)
    - [Non-blocking](#non-blocking)

# Objective
- Code verilog design and testbench file for the following module
  1. ALU 32 bits support the following operations
      - Add
      - Sub
      - NOT
      - AND
      - OR
      - XOR
      - Arithmetic shift left, shift right
  2. Majority module for 32 bits
  3. CRA 8 bits

---
# Data Types

## Verilog Syntax
---
### Verilog Number Format
- In order to represent them in different radix, you can use the format ***[size]'[base_format][number]***, with the base_format can be decimal (*d* or *D*), hexadecimal (*h* or *H*) and octal (*o* or *O*) For example:
  ```verilog
  3'b101;  // size is 3, base format is binary and the number is 010
  3'd2;   // size is 3, base format is decimal and the number is 2
  8'h70;  // size is 8, base format is hexadecimal to represent decimal 112
  32'hFACE_47B2;  //can use underscore to separate number for readability
  ```
- By default, Verilog treat numbers as decimals. Numbers without a *[base_format]* specification are decimal numbers by default. Numbers without a size specification have a default number of bits depending on the type of simulator and machine.
- Negative numbers are specified by placing a minus `-` sign before the size of a number. It is illegal to have a minus sign between *[base_format]* and *[number]

  ---
### Verilog Strings Format
A sequence of characters enclosed in a double quote `" "` is called a string. It cannot be split into multiple lines and every character in the string take 1-byte to be store

---
## Verilog Data Types
---
***Nets*** and ***variables*** are the two main groups of data types which represent different hardware structures and differ in the way they are assigned and retain values

---
### Nets
- ***Nets*** are used to connect between hardware entities like logic gates -> *DO NOT store any value* on its own. The pics below is a simple example of nets `net_11`, `net_45`, `net_67`,...

  <p align="center">
  <img alt="Nets Example" src="../Pics/nets_variables.png " width="75%">
  </p>
  <p align = "center">Net example</p>
- There are different types of nets, but the most popular and widely used is `wire`
    > `wire` is a verilog data-type used to connect elements and to connect nets that are driven by a single gate or continuous assignment
- *Nets* can be driven or assigned using `assign` statement

  ---
### Variables
- A variable on the other hand is an abstraction of a data storage element and *can hold values*.
- `reg` is one of variables data type
    > `reg` can be used to model hardware registers since it can hold values between assignments
  - Strings are stored in `reg`. Each character in a string requires 1 ***byte***.
    - If the size of `reg` < the string, remove the leftmost bits of the string
    - If the size of t`reg` > the string, then Verilog adds zeros (empty space) to the left of the string
  - It is illegal to drive or assign `reg` with an `assign` statement. `reg` can only be driven in procedural blocks like `initial` and `always`
  
  ---
### Other data types

- `integer`: general purpose variable of 32-bits wide that can be used, assigned for other purposes while modeling hardware and stores integer values
- `time`: unsigned, 64-bits wide and can be used to store simulation time quantities for debugging purposes
- `real`: a variable can store floating point values and can be assigned
  
  ---
## Verilog scalar and vector
---
- A declaration *WITHOUT* a range specification is considered 1-bit wide and is a ***scalar***
- If a range is specified, then it becomes a multi-bit entity known as a ***vector***

  ---
### Declaration
- You can use the format ***[data_type] [msb:lsb][name]*** to declare a vector
- The most significant bit (MSB) should be specified as the *left hand value* in the range while the least significant bit (LSB) should be specified on the right. For example, `wire [6:0] seg` is a wire vector with MSB is seg[6] and LSB is seg[0]
- MSB and LSB *SHOULD BE A CONSTANT* and CANNOT be substituted by a variable

  ---
### Bit-selects and Part-selects
- Any bit in a vectored variable can be individually selected and assigned a new value by using the index (it is known as bit-select)
- A range of contiguous bits can be selected and is known as a part-select
  
  ---
## Verilog Arrays
- Arrays are allowed in Verilog for `reg`, `wire`, `integer` and `real` data types
- You can assign values to a element of a array using index (same as C/C++)

---
# Building Blocks
## Verilog Module
---
A `module` is a block of Verilog code that implements a certain functionality. Modules can be embedded within other modules and a higher level module can communicate with its lower level modules using their input and output ports

---
### Syntax
- A module should be enclosed within `module` and `endmodule` keywords
- Name of the module should be given *right after* the `module` keyword and an ***optional*** list of `ports` (more detail of port [later](#verilog-port)) may be declared as well
    > Ports declared in the list of port declarations CANNOT be redeclared within the body of the module.

### Import modules within a module: Port connection
- You have more nested modules, sub-modules
- To call another module inside a module, not only you have to call the callee module but you also have to connect port of caller and callee module. It is called ***port connection*** 
- There are some methods of making the port connection: 
  1. Port connection by *ordered list*:
    ```verilog
    module mydesign(
      input  x, y, z,   // x, y, z is at position 1, 2, 3
      output o);        // o is at position 4
    endmodule

    module tb_top;
	    wire [1:0]  a;
	    wire        b, c;

	    mydesign d0  (a[0], b, a[1], c);  
      // a[0] is at position 1 -> automatically connected to x
	    // b is at position 2 -> automatically connected to y
	    // a[1] is at position 3 -> connected to z
	    // c is at position 4 -> connected with o
    endmodule
    ```
      >This is very inconvenient because the order might change if a new port is added or when the number of ports in the design is very large.
  2. Port connection by *name*:
    - The better way to connect port is by explicitly linking ports on both the sides using their *port name*.
    - The dot `.` indicates that the port name following the dot belongs to the callee module (design port). The signal name to which the design port has to be connected is given next within parentheses `( )`.
    ```verilog
    module design_top;
	    wire [1:0]  a;
	    wire        b, c;

	    mydesign d0 (
          .x (a[0]),
          .y (b),
          .z (a[1]),
          .o (c));
    endmodule
    ```

---
## Verilog Port
---
- ***Port*** are set of signals that act as inputs and outputs to a particular module and are the primary way of communicating with it.
- There are 3 types of port:
  1. input
  2. output
  3. inout (act as both input and output ports)
- Ports are by default considered as **nets** of type `wire`. If you want declare another type port (not `wire`), add *[data_type]* right AFTER the `input/output/inout` keyword
  
>Ports of type `input` or `inout` ***CANNOT*** be declared as `reg` because they are being driven from outside continuously and should not store values, rather reflect the changes in the external signals.

---
## Verilog procedural blocks
---
- Verilog statements which are executed SEQUENTIALLY are placed inside a ***procedural*** block.
- There are mainly 2 types of *procedural* blocks in Verilog: ***always*** and ***initial***

  ---
### Verilog always block
- The syntax of `always` block is shown below
  ```verilog
  always @ (event) begin
    [multiple statements]
  end
  ```
- The `always` block is executed at some particular event, which is defined by a *sensitivity* list specified after the `@` operator within parentheses `( )`. This list may contain either one or a group of signals whose value change will execute the always block

  ---
### Verilog initial block
- The syntax of `initial` blocks
  ```verilog
  initial begin
	  [multiple statements]
  end
  ```
- An `initial` block CANNOT be converted into a hardware schematic with digital elements. These blocks are primarily used to ***initialize variables*** and ***drive design ports*** with specific values.
- An `initial` block is started at the beginning of a simulation at ***time 0*** unit. This block will be ***executed only once*** during the entire simulation
- There are *NO LIMITS* to the number of `initial` blocks that can be defined inside a module. If a module has many `initial` block, they will start at the same time and run in parallel

  ---

# Behavioral modeling
## Verilog block statements
---
- There are 2 kinds of block statements: sequential and parallel
  1. Statements are wrapped using `begin` and `end` keywords will be executed ***sequentially*** in the given order and delay control are treated relative to the time of execution of the previous statement
  2. Statements are wrapped within the `fork` anf `join` keywords are launched ***parallel***. *parallel* block can execute statements concurrently and delay control can be used to provide time-ordering of the assignments
- Both sequential and parallel blocks can be named by adding `:[name_of_block]` after the keyword `begin` or `fork` as following
  ```verilog
  begin : name_seq
    [statements]
  end

  fork : name_fork
    [statements]
  join
  ```

---
## Verilog Assignments
---
Placing values onto nets and variables are called assignments. There are three basic forms: procedural, continuous and procedural continuous

---
### Legal LHS values
- An assignment has two parts: ***right-hand side*** (RHS) and ***left-hand side*** (LHS) with an `=` (blocking assignment) or `<=` (non-blocking assignment) in between.
  
<table>
    <thead>
        <tr>
            <th>Assignment type</th>
            <th>Legal left-hand side</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td rowspan =4 style="width:10%;">Procedural</td>
            <td>- Variables (vector/scalar)</td>
        </tr>
        <tr>
            <td>- Bit-select or part-select of a vector reg, integer or time variable</td>
        </tr>
        <tr>
            <td>- Memory word</td>
        </tr>
        <tr>
            <td>- Concatenation of any of the above</td>
        </tr>
        <tr>
            <td rowspan =3 style="width:10%;">Continuous</td>
            <td>- Net (vector/scalar)</td>
        </tr>
        <tr>
            <td>- Bit-select or part-select of a vector net</td>
        </tr>
        <tr>
            <td>- Concatenation of bit-selects and part-selects</td>
        </tr>
        <tr>
            <td rowspan =2 style="width:0%;">Procedural Continous</td>
            <td>- Net or variable (vector/scalar)</td>
        </tr>
        <tr>
            <td>- Bit-select or part-select of a vector net</td>
        </tr>
    </tbody>
</table>

  ---
### Procedural Assignment
- Procedural assignments occur within procedures such as `always`, `initial`, `task` and `functions`.
- They are used to place values onto variables ***at the time of its declaration***. The variable will *hold the value until the next assignment to the same variable*.

---
### Continuous Assignment
- This is used to assign values onto scalar and vector nets and **happens whenever there is a change in the RHS**

---
## Verilog Blocking & Non-Blocking
---
### Blocking
- ***Blocking*** assignment statements are assigned using `=` and are executed one after the other in a procedural block.
- This will not prevent execution of statements that run in a parallel block. Consider the following example:
  ```verilog
  module tb;
    reg [7:0] a, b, c, d, e;

    initial begin
      a = 8'hDA;
      $display ("[%0t] a=0x%0h b=0x%0h c=0x%0h", $time, a, b, c);
      #10 b = 8'hF1;
      $display ("[%0t] a=0x%0h b=0x%0h c=0x%0h", $time, a, b, c);
      c = 8'h30;
      $display ("[%0t] a=0x%0h b=0x%0h c=0x%0h", $time, a, b, c);
    end

    initial begin
      #5 d = 8'hAA;
      $display ("[%0t] d=0x%0h e=0x%0h", $time, d, e);
      #5 e = 8'h55;
      $display ("[%0t] d=0x%0h e=0x%0h", $time, d, e);
    end
  endmodule
  ```
- You can see that there are 2 `initial` blocks which are executed in parallel when simulation starts. Statements are executed ***sequentially in each block*** and both blocks finish at time 0ns
- The simulation log will have the following result:
  ```txt
  ncsim> run
  [0] a=0xda b=0xx c=0xx
  [5] d=0xaa e=0xx
  [10] a=0xda b=0xf1 c=0xx
  [10] a=0xda b=0xf1 c=0x30
  [10] d=0xaa e=0x55
  ncsim: *W,RNQUIE: Simulation is complete.
  ```
    ---

### Non-blocking
- ***Non-blocking*** assignment is specified by a `<=` symbol
- It allows assignments to be scheduled without blocking the execution of following statements. It mean that the RHS of every non-blocking statement if a particular time-step is ***captured***, and moves onto the next statement. The captured RHS value is assigned to the LHS variable ***ONLY AT THE END OF TIME-STEP***
- Consider the following example (same as above example but replace blocking assignment `=` by non-blocking assignment `<=`):
  ```verilog
  module tb;
    reg [7:0] a, b, c, d, e;

    initial begin
      a <= 8'hDA;
      $display ("[%0t] a=0x%0h b=0x%0h c=0x%0h", $time, a, b, c);
      #10 b <= 8'hF1;
      $display ("[%0t] a=0x%0h b=0x%0h c=0x%0h", $time, a, b, c);
      c <= 8'h30;
      $display ("[%0t] a=0x%0h b=0x%0h c=0x%0h", $time, a, b, c);
    end

    initial begin
      #5 d <= 8'hAA;
      $display ("[%0t] d=0x%0h e=0x%0h", $time, d, e);
      #5 e <= 8'h55;
      $display ("[%0t] d=0x%0h e=0x%0h", $time, d, e);
    end
  endmodule
  ``` 
- You can see the output is different than what we got before
  ```txt
    ncsim> run
    [0] a=0xx b=0xx c=0xx
    [5] d=0xx e=0xx
    [10] a=0xda b=0xx c=0xx
    [10] a=0xda b=0xx c=0xxx
    [10] d=0xaa e=0xx
    ncsim: *W,RNQUIE: Simulation is complete.
  ```
- ***Explanation***:
  - Spawn Block1 at #0ns: initial
    - [0]: a <= 8'hDA is a non-blocking, so note value of RHS (8'hDA) and execute next step
    - [0]: execute $display statement (a still haven't received new value so a=8'hx)
    - End of time-step: Assign captured value (8'hDA) to variable a, so a is now 8'hDA
    - [10]: b <= 8'hF1, is non-blocking so note value of RHS (8'hF1) and execute next step
    - [10]: execute $display statement (a is 8'hda but b still haven't received new value so b=8'hx)
    - [10]: c <= 8'h30, is non-blocking so note value of RHS (8'h30) and execute next step
    - [10]: execute $display statement (a is 8'hda, but b and c still haven't received new value so b=8'hx, c = 8'hx)
    - End of time-step: Assign captured value to b and c, so b is now 8'hF1 and c is now 8'h30
  - Spawn Block2 at #0ns: initial
    - [5]: d <= 8'hAA is a non-blocking, so note value of RHS (8'hAA) and execute next step
    - [5]: execute $display statement (d still haven't received new value so d=8'hx)
    - End of time-step: Assign captured value (8'hAA) to variable d, so d is now 8'hAA
    - [10]: 2 <= 8'h55, is non-blocking so note value of RHS (8'h55) and execute next step
    - [10]: execute $display statement (d is 8'haa but e still haven't received new value so e=8'hx)
    - End of time-step: Assign captured value to e, so e is now 8'h55
  - End of simulation at #10ns
  