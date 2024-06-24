class alu_base_sequence extends uvm_sequence;

    `uvm_object_utils(alu_base_sequence)

    alu_transaction reset_pkt;
    
    //=====================
    //==== Constructor ====
    //=====================
    function new(string name = "alu_base_sequence");
        super.new(name);
        `uvm_info("BASE_SEQUENCE", "Inside Constructor!", UVM_HIGH)
    endfunction: new

    //===================
    //==== Body task ====
    //===================
    task body();
      `uvm_info("BASE_SEQUENCE", "Inside body task!", UVM_HIGH)

      reset_pkt = alu_transaction::type_id::create("reset_pkt");
      start_item(reset_pkt);
      reset_pkt.randomize() with {rst == 1;};
      finish_item(reset_pkt);
    endtask: body

endclass: alu_base_sequence

class alu_test_sequence extends alu_base_sequence;

    `uvm_object_utils(alu_test_sequence)

    alu_transaction item;
    
    //=====================
    //==== Constructor ====
    //=====================
    function new(string name = "alu_test_sequence");
        super.new(name);
        `uvm_info("BASE_SEQUENCE", "Inside Constructor!", UVM_HIGH)
    endfunction: new

    //===================
    //==== Body task ====
    //===================
    task body();
      `uvm_info("BASE_SEQUENCE", "Inside body task!", UVM_HIGH)

      item = alu_transaction::type_id::create("item");
      start_item(item);
      item.randomize() with {rst == 0;};
      finish_item(item);
    endtask: body

endclass: alu_test_sequence