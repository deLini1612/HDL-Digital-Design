class alu_driver extends uvm_driver#(alu_transaction);

    `uvm_component_utils(alu_driver)

    virtual alu_interface vif;
    alu_transaction item;

    //=====================
    //==== Constructor ====
    //=====================
    function new(string name = "alu_driver", uvm_component parent);
        super.new(name, parent);
        `uvm_info("DRIVER_CLASS", "Inside Constructor!", UVM_HIGH)
    endfunction: new

    //=====================
    //==== Build Phase ====
    //=====================
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info("DRIVER_CLASS", "Build Phase!", UVM_HIGH)

        if(!(uvm_config_db #(virtual alu_interface)::get(this, "*", "vif", vif))) begin
            `uvm_error("DRIVER_CLASS", "Failed to get VIF from config DB!")
        end
    endfunction: build_phase

    //=======================
    //==== Connect Phase ====
    //=======================
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        `uvm_info("DRIVER_CLASS", "Connect Phase!", UVM_HIGH)
    endfunction: connect_phase

    //===================
    //==== Run Phase ====
    //===================
    task run_phase (uvm_phase phase);
        super.run_phase(phase);
        `uvm_info("DRIVER_CLASS", "Run Phase!", UVM_HIGH)

        forever begin
            item = alu_transaction::type_id::create("item");
            seq_item_port.get_next_item(item);
            drive(item);
            seq_item_port.item_done();
        end
    endtask: run_phase

    //========================
    //==== [Method] Drive ====
    //========================
    task drive(alu_transaction item);
        @(posedge vif.clk);
        vif.rst <= item.rst;
        vif.A <= item.A;
        vif.B <= item.B;
        vif.op <= item.op;
    endtask: drive

endclass: alu_driver