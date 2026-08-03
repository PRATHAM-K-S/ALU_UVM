class alu_inp_monitor extends uvm_monitor;
    
    // factory registration
    `uvm_component_utils(alu_inp_monitor)

    virtual alu_interface.INP_MON vif; //virtual interface decleration
    uvm_analysis_port #(alu_sequence_item) inp_mon_ap; //analysis port decleration
    alu_sequence_item item;

    // class constructor
    function new(string name="alu_inp_monitor", uvm_component parent);
        super.new(name, parent);    
    endfunction

    // build phase: vif and analysis port configuration
    function void build_phase(uvm_phase phase);
        if(!uvm_config_db #(virtual alu_interface.INP_MON)::get(this,"","vif",vif)) begin
            `uvm_fatal("NOVIF",{"virtual interface must be set for:", get_full_name(),".vif"})
        end
        inp_mon_ap = new("inp_mon_ap", this);
    endfunction

    // run_phase: sample DUT inputs
    task run_phase(uvm_phase phase);
        @(vif.inp_mon_cb);
        forever begin
            collect_item();
            `uvm_info("INPUT MONITOR",item.convert2String(),UVM_NONE)
        end
    endtask

    // collect_item task: convert pin level to transaction object and broadcast to subscribers
    task collect_item();
        @(vif.inp_mon_cb);
        item.OPA = vif.inp_mon_cb.OPA;
        item.OPB = vif.inp_mon_cb.OPB;
        item.CE = vif.inp_mon_cb.CE;
        item.MODE = vif.inp_mon_cb.MODE;
        item.CIN = vif.inp_mon_cb.CIN;
        item.CMD = vif.inp_mon_cb.CMD;
        item.INP_VALID = vif.INP_VALID;
        inp_mon_ap.write(item);
    endtask
endclass