class alu_monitor extends uvm_monitor;

    `uvm_component_utils(alu_monitor)

    virtual alu_interface vif;
    alu_transaction item;

    uvm_analysis_port #(alu_transaction) monitor_port;

    //=====================
    //==== Constructor ====
    //=====================
    function new(string name = "alu_monitor", uvm_component parent);
        super.new(name, parent);
        `uvm_info("MONITOR_CLASS", "Inside Constructor!", UVM_HIGH)
    endfunction: new

    //=====================
    //==== Build Phase ====
    //=====================
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info("MONITOR_CLASS", "Build Phase!", UVM_HIGH)

        monitor_port = new("monitor_port", this);

        if(!(uvm_config_db #(virtual alu_interface)::get(this, "*", "vif", vif))) begin
            `uvm_error("MONITOR_CLASS", "Failed to get VIF from config DB!")
        end
    endfunction: build_phase

    //=======================
    //==== Connect Phase ====
    //=======================
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        `uvm_info("MONITOR_CLASS", "Connect Phase!", UVM_HIGH)
    endfunction: connect_phase

    //===================
    //==== Run Phase ====
    //===================
    task run_phase (uvm_phase phase);
        super.run_phase(phase);
        `uvm_info("MONITOR_CLASS", "Run Phase!", UVM_HIGH)

        forever begin
            item = alu_transaction::type_id::create("item");
            wait(!vif.rst);

            //sample inputs
            @(posedge vif.clk);
            item.A = vif.A;
            item.B = vif.B;
            item.op = vif.op;

            //sample outputs
            @(posedge vif.clk);
            item.out = vif.out;
            item.carry_out = vif.carry_out;

            //send item to scoreboard
            monitor_port.write(item);
        end
    endtask: run_phase

endclass: alu_monitor