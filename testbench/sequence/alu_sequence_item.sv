class alu_sequence_item extends uvm_sequence_item;

    // factory registration
    `uvm_object_utils(alu_sequence_item)

    // DUT input signals
    rand bit [`DW-1:0] OPA;
    rand bit [`DW-1:0] OPB;
    rand bit CE;
    rand bit MODE;
    rand bit CIN;
    rand bit [`CW-1:0] CMD;
    rand bit [1:0] INP_VALID;  

    // class constructor
    function new(string name);
        super.new(name);
    endfunction

    // do_copy method
    function void do_copy(uvm_object rhs);
        alu_sequence_item rhs_;
        if(!$cast(rhs_, rhs)) begin
            `uvm_error("do_copy:", "Cast failed")
            return;
        end
        super.do_copy(rhs);
        OPA = rhs_.OPA;
        OPB = rhs_.OPB;
        CE = rhs_.CE;
        MODE = rhs_.MODE;
        CIN = rhs_.CIN;
        CMD = rhs_.CMD;
        INP_VALID = rhs_.INP_VALID;
    endfunction

    // convert2string method
    function string convert2string();
        string s;
        s = super.convert2string();
        $sformat(s, "%s \n
                OPA \t %0d \n
                OPB \t %0d \n
                CE \t %0d \n
                MODE \t %0d \n
                CIN \t %0d \n
                CMD \t %0d \n
                INP_VALID \t %0d \n",
                s, OPA, OPB, CE, MODE, CIN, CMD, INP_VALID
        );
        return s;
    endfunction

endclass //alu_sequence_item extends uvm_sequence_item