//  Class: uvm_xor_mon
/*
Connect the monitor through virtual interface to the output port. The monitor should print the output.
*/
//
class uvm_xor_mon extends uvm_monitor#(                                                                              
    parameter DATA_WIDTH = 10                                                 
 );
    
    `uvm_component_utils(uvm_xor_mon)
    
    //  Group: Components
    virtual xor_if  vif;

    uvm_analysis_port#(uvm_xor_seq_item) mon_ap;    

    //  Group: Functions
    extern function new(string name = "uvm_xor_mon", uvm_component parent=null);

    extern virtual function void build_phase(uvm_phase phase);

    extern virtual task run_phase(uvm_phase phase);
    
endclass: uvm_xor_mon

function uvm_xor_mon::new(string name = "uvm_xor_mon", uvm_component parent=null);
    super.new(name, parent);
endfunction: new

function uvm_xor_mon::build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual xor_if)::get(this, "", "vif", vif)) begin
        `uvm_fatal("UVM_XOR_MON", "NO VIF, handle is null")
    end
    mon_ap = new("mon_ap", this);
    `uvm_info(get_full_name(), "Build stage complete", UVM_LOW)
endfunction: build_phase

task uvm_xor_mon::run_phase(uvm_phase phase);
    uvm_xor_seq_item mon_txn = uvm_xor_seq_item::type_id::create("mon_txn", this);
    forever begin
        @(posedge vif.i__clk);
        if (i__areset_n == 1 && i__sreset_n == 1) begin
            mon_txn.i__inA  = vif.i__inA;
            mon_txn.i__inB  = vif.i__inB;
            mon_txn.o__dout = vif.o__dout;
            mon_ap.write(mon_txn);
            mon_ap.print("[%0t] Monitor Out: %b", $time, mon_txn.o__dout);
        end
    end
endtask: run_phase