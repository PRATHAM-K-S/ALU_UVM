class alu_sequencer extends uvm_sequencer #(alu_sequence_item);
    
    // factory registration
    `uvm_component_utils(alu_sequencer) 

    // class constructor
    function new(string name="alu_sequencer", uvm_component parent);
        super.new(name, parent);        
    endfunction   
    
endclass