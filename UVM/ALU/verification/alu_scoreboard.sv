class alu_scoreboard extends uvm_test;

  `uvm_component_utils(alu_scoreboard)
   uvm_analysis_imp #(alu_transaction, alu_scoreboard) scoreboard_port;

   alu_transaction transactions[$];

    //=====================
    //==== Constructor ====
    //=====================
    function new(string name = "alu_scoreboard", uvm_component parent);
        super.new(name, parent);
        `uvm_info("SCB_CLASS", "Inside Constructor!", UVM_HIGH)
    endfunction: new

    //=====================
    //==== Build Phase ====
    //=====================
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info("SCB_CLASS", "Build Phase!", UVM_HIGH)

        scoreboard_port = new("scoreboard_port", this);
    endfunction: build_phase

    //=======================
    //==== Connect Phase ====
    //=======================
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        `uvm_info("SCB_CLASS", "Connect Phase!", UVM_HIGH)
    endfunction: connect_phase

    //========================
    //==== [Method] Write ====
    //========================
    function void write (alu_transaction item);
        transactions.push_back(item);
    endfunction: write

    //===================
    //==== Run Phase ====
    //===================
    task run_phase (uvm_phase phase);
        super.run_phase(phase);
        `uvm_info("SCB_CLASS", "Run Phase!", UVM_HIGH)

        forever begin
            alu_transaction curr_trans;
            wait(transactions.size() != 0);
            curr_trans = transactions.pop_front();
            compare(curr_trans);
        end
    endtask: run_phase

    //=====================================================================
    //==== Compare: Gen golden outputs and Compare with actual outputs ====
    //=====================================================================
    task compare (alu_transaction curr_trans);
        logic [7:0] golden_out, actual_out;
        logic golden_carry, actual_carry;

        //gen golden outputs
        case(curr_trans.op)
            0: begin
                {golden_carry, golden_out} = curr_trans.A + curr_trans.B;
            end
            1: begin
                {golden_carry, golden_out} = curr_trans.A - curr_trans.B;
            end
            2: begin
                {golden_carry, golden_out} = {1'b0, curr_trans.A & curr_trans.B};
            end
            3: begin
                {golden_carry, golden_out} = {1'b0, curr_trans.A | curr_trans.B};
            end
        endcase

        actual_out = curr_trans.out;
        actual_carry = curr_trans.carry_out;

        //compare
        if ({actual_out, actual_carry} != {golden_out, golden_carry}) begin
            `uvm_error("COMPARE", $sformatf("FAILED! op = %d, A = %d, B = %d, out = %d (expected %d), carry = %d (expected %d)", curr_trans.op, curr_trans.A, curr_trans.B, curr_trans.op, actual_out, golden_out, actual_carry, golden_carry))
        end
        else begin
            `uvm_info("COMPARE", $sformatf("PASSED! op = %d, A = %d, B = %d, out = %d, carry = %d", curr_trans.op, curr_trans.A, curr_trans.B, curr_trans.op, actual_out, actual_carry), UVM_LOW)
        end
        
    endtask: compare

endclass: alu_scoreboard