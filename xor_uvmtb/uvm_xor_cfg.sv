//  Class: uvm_xor_cfg
/*
Inside config can be knob that controls the bit vector pattern.
*/
//
class uvm_xor_cfg extends uvm_object#(                                                                              
    parameter DATA_WIDTH = 10                                                 
 );
    
    `uvm_object_utils_begin(uvm_xor_cfg)
        `uvm_component_utils(enabled, UVM_DEFAULT)
        `uvm_field_enum(uvm_active_passive_enum, is_active, UVM_DEFAULT)
        `uvm_component_utils(scoreboarding_enabled, UVM_DEFAULT)
        `uvm_component_utils(knob_enabled, UVM_DEFAULT)
    `uvm_object_utils_end

    //  Group: Variables
    rand bit                        enabled;
    rand uvm_active_passive_enum    is_active;
    rand bit                        scoreboarding_enabled;
    bit                             knob_enabled;
    
    //uvm_xor_seq_item    seq_item;

    //  Group: Constraints
    constraint default_cfg_cons {
        soft enabled                 == 1;
        soft is_active               == UVM_PASSIVE;
        soft scoreboarding_enabled   == 1;
        soft knob_enabled            == 1;
    }

    /*
    constraint knob_cfg_cons_a {
        if (uvm_xor_cfg.knob_enabled == 1) {
            seq_item.i__inA.randomize();
            seq_item.i__inB.randomize();
        }
    }

    constraint knob_cfg_cons_b {
        if (knob_enabled) {
            // change vector pattern
            if (seq_item.i__inA == 9'h000) {
                // change pattern to NOT ZERO
            }
            else if (seq_item.i__inB == 9'hff1) {
                // change pattern to NOT ONE   
            }
        }
    }
    */
    //  Group: Functions
    extern function new(string name = "uvm_xor_cfg", uvm_component parent);

endclass: uvm_xor_cfg

function uvm_xor_cfg::new(string name = "uvm_xor_cfg", uvm_component parent);
    super.new(name, parent);
endfunction: new
