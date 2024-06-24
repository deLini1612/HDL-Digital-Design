`timescale 1ns/1ns

import uvm_pkg::*;
`include "uvm_macros.svh"

//=======================
//==== Include Files ====
//=======================
`include "alu_interface.sv"
`include "alu_transaction.sv"
`include "alu_sequence.sv"
`include "alu_monitor.sv"
`include "alu_sequencer.sv"
`include "alu_driver.sv"
`include "alu_agent.sv"
`include "alu_scoreboard.sv"
`include "alu_env.sv"
`include "alu_test.sv"



module top_tb;

    //=======================
    //==== Instantiation ====
    //=======================
    logic clk;

    alu_interface intf(.clk(clk));

    alu dut (
        .clk(intf.clk),
        .rst(intf.rst),
        .A(intf.A),
        .B(intf.B),
        .op(intf.op),
        .out(intf.out),
        .carry_out(intf.carry_out)
    );

    //=========================
    //==== Interface Setup ====
    //=========================
    initial begin
        uvm_config_db #(virtual alu_interface)::set(null, "*", "vif", intf );
        //-- Refer: https://www.synopsys.com/content/dam/synopsys/services/whitepapers/hierarchical-testbench-configuration-using-uvm.pdf
    end
    
    //=====================
    //==== Drive Clock ====
    //=====================
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        #5000;
        $display("Reach limit simulation time!");
        $finish();
    end

    //===================
    //==== Dump Wave ====
    //===================
    initial begin
        $dumpfile("dump_alu.vcd");
        $dumpvars();
    end

    //==================
    //==== Run Test ====
    //==================
    initial begin
        run_test("alu_test");
    end
    
endmodule: top_tb