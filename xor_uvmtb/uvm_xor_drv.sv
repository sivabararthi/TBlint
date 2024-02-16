//  Class: uvm_xor_drv
/*
Through virtual interface drives the two input ports.
*/
//
class uvm_xor_drv extends uvm_driver#(                                                                              
    parameter DATA_WIDTH = 10                                                 
 );
    
    `uvm_component_utils(uvm_xor_drv)

    virtual xor_if  vif;

    //uvm_xor_cfg     cfg;

    //  Group: Functions    
    extern function new(string name = "uvm_xor_drv", uvm_component parent);

    extern virtual function void build_phase(uvm_phase phase);

    extern virtual task run_phase(uvm_phase phase);

    extern virtual task drive_items();
    
endclass: uvm_xor_drv

function uvm_xor_drv::new(string name = "uvm_xor_drv", uvm_component parent);
    super.new(name, parent);
endfunction: new

function uvm_xor_drv::build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual xor_if)::get(this, "", "vif", vif)) begin
        `uvm_fatal("UVM_XOR_DRV", "NO VIF, handle is null")
    end
    `uvm_info(get_full_name(), "Build stage complete", UVM_LOW)
endfunction: build_phase

task uvm_xor_drv::run_phase(uvm_phase phase);
    uvm_xor_seq_item    drv_item;

    forever begin
        while (vif.i__areset_n != 1'b0 && vif.i__sreset_n != 1'b0) begin
            seq_item_port.get_next_item(drv_item);
            drive_items(drv_item);
            seq_item_port.item_done(); 
        end
    end
endtask: run_phase

task uvm_xor_drv::drive_items();
    forever begin
        @(posedge vif.i__clk);
        vif.i__inA <= drv_item.i__inA;
        vif.i__inB <= drv_item.i__inB;
    end
endtask