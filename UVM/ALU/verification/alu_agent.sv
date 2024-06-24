class alu_agent extends uvm_agent;

    `uvm_component_utils(alu_agent)

    alu_driver driver;
    alu_monitor monitor;
    alu_sequencer sequencer;

    //=====================
    //==== Constructor ====
    //=====================
    function new(string name = "alu_agent", uvm_component parent);
        super.new(name, parent);
        `uvm_info("AGENT_CLASS", "Inside Constructor!", UVM_HIGH)
    endfunction: new

    //=====================
    //==== Build Phase ====
    //=====================
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info("AGENT_CLASS", "Build Phase!", UVM_HIGH)

        driver = alu_driver::type_id::create("driver", this);
        monitor = alu_monitor::type_id::create("monitor", this);
        sequencer = alu_sequencer::type_id::create("sequencer", this);
    endfunction: build_phase

    //=======================
    //==== Connect Phase ====
    //=======================
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        `uvm_info("AGENT_CLASS", "Connect Phase!", UVM_HIGH)

        driver.seq_item_port.connect(sequencer.seq_item_export);
    endfunction: connect_phase

    //===================
    //==== Run Phase ====
    //===================
    task run_phase (uvm_phase phase);
        super.run_phase(phase);
        `uvm_info("AGENT_CLASS", "Run Phase!", UVM_HIGH)
    endtask: run_phase

endclass: alu_agent