class alu_transaction extends uvm_sequence_item;

    `uvm_object_utils(alu_transaction)

    //=======================
    //==== Instantiation ====
    //=======================
    rand logic rst;
    rand logic [7:0] A;
    rand logic [7:0] B;
    rand logic [1:0] op;

    logic [7:0] out;
    bit carry_out;

    //=====================
    //==== Constraints ====
    //=====================
    constraint op_c {op inside {0,1,2,3};} //just an example, no need to do it because op have 2-bit

    //=====================
    //==== Constructor ====
    //=====================
    function new(string name = "alu_transaction");
        super.new(name);
    endfunction: new

endclass: alu_transaction