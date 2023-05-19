# Table of Contents
- [Objective](#objective)
- [FPGA](#fpga)
- [Questasim (quick hands-on)](#questasim-quick-hands-on)
  - [Basic Simulation Flow](#basic-simulation-flow)
  - [Project Flow](#project-flow)
  - [Quick Simulate Using Given Example](#quick-simulate-using-given-example)
    - [Step 1: Creating the Working Library](#step-1-creating-the-working-library)
    - [Step 2: Compiling Your Design](#step-2-compiling-your-design)
    - [Step 3: Load The Design](#step-3-load-the-design)
    - [Step 4: Run the Simulation](#step-4-run-the-simulation)
  - [Design and testbench module](#design-and-testbench-module)


# Objective
- Code, simulate and implement to FPGA kit a BIN to 7seg decoder to control 4 7-seg LEDs by 16 bit input signal from switches
    - Using HDL (Verilog) to describe BIN to 7seg decoder module
    - USing Questasim to stimulate
    - Using Vovaldo to implement to FPGA
---

# FPGA

- **FPGA** = **F**ield **P**rogrammable **G**ate **A**rrays: A semiconductor devices based around matrix of **C**onfigurable **L**ogic **B**locks (CLB) connected via programmable interconnects
    - CLB contains FF, LUT (**L**ook-**U**p **T**able) and MUX
    - LUT mainly define the behaviour of the combinational logic designed with a VHDL or Verilog code -> It simply **generates output based on the input combination**
- FPGA can be **reprogrammed** to meet desired requirement (Diff from Application Specific Integrated Circuits [ASIC], which is made for specific task and can't be change)
- Every FPGA has fixed number of programmable logic, I/O banks and memory elements. 

---
# Questasim (quick hands-on)
- Is a tool in Mentor Graphics tool suite for Functional Verification, provides simulation support for latest standards of SystemC, SystemVerilog, Verilog 2001 standard and VHDL

---
## Basic Simulation Flow
<p align="center">
  <img alt="By build a sample project" src="../Pics/SimulationFlowofQuestasim.png " width="82%">
</p>


1. **Creating the Working Library**
    You typically start a new simulation in QuestaSim by creating a working library called "work" (library name used by the compiler as the default destination for compiled design units)
2. **Compiling Your Design**
3. **Loading the Simulator with Your Design and Running the Simulation**
    - With the design compiled, you load the simulator with your design by invoking the simulator on a top-level module (Verilog)
    - Assuming the design loads successfully, the simulation time is set to zero, and you enter a run command to begin simulation
4. **Debugging Your Results**
   
   ---
## Project Flow
<p align="center">
  <img alt="By build a sample project" src="../Pics/ProjectFlowQuestasim.png " width="40%">
</p>

**Important things need to notice:**
    - ***DO NOT*** create a working library in the project flow (it done automatically)
    -  Projects will open every time you invoke QuestaSim unless you specifically close them

---

## Quick Simulate Using Given Example
Require files: A verilog design script (or VHDL,...) and associated testbench. In this case, use example verilog design script (counter.v) and testbench (tcounter.v) in the path ```questasim/examples/tutorials/verilog/basicSimulation```

---

### Step 1: Creating the Working Library
1. Create a new directory and copy the design files into it (in my case, I'll create directory test then copy counter.v and tcounter.v to it)
2. Start Questasim by command ```vsim``` at UNIX shell then select **File > Change Directory** and change to directory created earlier (test dir)
3. Create the working library
    - **File > New > Library**: specify physical and logical names for the library (Type **work** in the Library Name field (if it isn’t already entered automatically) then click **OK**
    - uestaSim creates a directory called *work* and writes a specially-formatted file named *_info* into that directory ( to distinguish it as a QuestaSim library). ***DO NOT*** edit the folder contents from your OS; ***ALL changes should be made from WITHIN QuestaSim***
    - When you pressed **OK** above, the following was printed to the Transcript are the command-line equivalents of the menu selections you made:
        ```
        vlib work
        vmap work work
        ```
    ---

### Step 2: Compiling Your Design 
With the working library created, you are ready to compile your source files either by using the graphic interface or by entering command at the ***QuetaSim> promt*** or mix those 2 method like me as below:
    - Compile design and testbench: Select **Compile > Compile** then select both design and testbench mudules (counter.v and tcounter.v) then click **Compile** then **Done**
    - You can view the compiled design units on the ***Library*** tab and click the '+' icon next to ***work*** library
  
  ---
### Step 3: Load The Design
   -  Load the ***test_counter*** module into the simulator by enter ```vsim -voptargs="+acc" test_counter``` at the **Questasim>** prompt in the *Transcript window*. When the design is loaded, you will see a new tab in the Workspace named *sim* that displays the hierarchical structure of the design
   -  View design objects in the objects pane by select **View > Objects** or enter ```view objects``` at the command line
  
  ---
### Step 4: Run the Simulation
   - Select **View > Wave** or enter ```view wave``` at the command line
   - Add signals to Wave window by slect the *sim* tab, right-click *test_counter* to open a popup then select **Add > To Wave > All items in region**
   - Run the simulation by click the **Run** icon (the default simulation length = 100ns)
       - Enter ```run 500`` at *VSIM prompt* in main window to simulate advances another 500ns
       - Click **Run -All** icon to stimulate until you execute a break (command or click **Break** icon)
       - Press "H" keybind to shorten parameter/input/output name
  
---
## Design and testbench module
- You can findverilog design and testbench tutorials in [tutorials dir](../basicTuto/Verilog/)
- We make verilog design code for BCD27seg module (for all data flow model, behavioral model structural model) with their associate testbench (you can find it as well as out top module in [this dir](./))

