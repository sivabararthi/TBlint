//  Class: uvm_xor_agent
//
class uvm_xor_agent extends uvm_agent#(                                                                              
    parameter DATA_WIDTH = 10                                                 
 );
    
    `uvm_component_utils_begin(uvm_xor_agent)
        `uvm_field_enum(uvm_active_passive_enum, is_active, UVM_DEFAULT)
    `uvm_component_utils_end

    //  Group: Components
    uvm_xor_drv     drv_a;
    uvm_xor_mon     mon_a;
    uvm_xor_sqr     sqr_a;
    uvm_xor_cfg     cfg_a;

    //  Group: Variables
    rand uvm_active_passive_enum    is_active;

    //  Group: Functions
    extern function new(string name = "uvm_xor_agent", uvm_component parent);

    extern void function build_phase(uvm_phase phase);

    extern void function connect_phase(uvm_phase phase);
    
endclass: uvm_xor_agent

function uvm_xor_agent::new(string name = "uvm_xor_agent", uvm_component parent);
    super.new(name, parent);
endfunction: new

function uvm_xor_agent::build_phase(uvm_phase phase);
    super.build_phase(phase);
    uvm_config_db#(cfg_a)::get(this, "*", "uvm_xor_cfg", cfg_a);
    if (get_is_active()) begin
        sqr_a = uvm_xor_sqr::type_id::create("sqr_a", this);
        drv_a = uvm_xor_drv::type_id::create("drv_a", this);
    end
    mon_a = uvm_xor_mon::type_id::create("mon_a", this);
    
    `uvm_info(get_full_name(), "Build stage complete", UVM_LOW)
endfunction: build_phase

function uvm_xor_agent::connect_phase(uvm_phase phase);
    if (get_is_active()) begin
        drv_a.seq_item_port.connect(sqr_a.seq_item_export);
    end
    `uvm_info(get_full_name(), "Connect stage complete", UVM_LOW)
endfunction: connect_phase