class alu_driver extends uvm_driver #(alu_sequence_item);
    
    // factory registration
    `uvm_component_utils(alu_driver)

    // virtual interface decleration
    virtual alu_interface.DRV vif;

    // class constructor
    function new (string name="alu_driver", uvm_component parent);
        super.new(name, parent);
    endfunction

    // build_phase: vif config
    function void build_phase(uvm_phase uvm_phase);
        if(!uvm_config_db #(virtual alu_interface.DRV)::get(this,"","vif",vif)) begin
            `uvm_fatal("NOVIF",{"virtual interface must be set for:", get_full_name(),".vif"})
        end
    endfunction

    // run_phase: handle driving signals to DUT
    task run_phase(uvm_phase phase);
        forever begin
            seq_item_port.get_next_item(req);
            drive_item(req);
            seq_item_port.item_done();
        end
    endtask

    // drive_item: convert to pin level and drive to DUT
    task drive_item(input alu_sequence_item item);
        @(vif.drv_cb);
        vif.drv_cb.OPA <= item.OPA;
        vif.drv_cb.OPB <= item.OPB;
        vif.drv_cb.CE <= item.CE;
        vif.drv_cb.MODE <= item.MODE;
        vif.drv_cb.CIN <= item.CIN;
        vif.drv_cb.CMD <= item.CMD;
        vif.drv_cb.INP_VALID <= item.INP_VALID;
    endtask

endclass