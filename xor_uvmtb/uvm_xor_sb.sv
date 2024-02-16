//  Class: uvm_xor_sb
/*
Write a scoreboard to predict and check the output.
*/
//
class uvm_xor_sb extends uvm_component#(                                                                              
    parameter DATA_WIDTH = 10                                                 
 );
    
    `uvm_component_utils(uvm_xor_sb)

    //  Group: Configuration Object(s)

    //  Var: config_obj
    //uvm_xor_cfg     scb_cfg;

    //  Group: Components
    uvm_tlm_analysis_fifo#(uvm_xor_seq_item)    sb_in_txn;
    uvm_tlm_analysis_fifo#(uvm_xor_seq_item)    sb_out_txn;
    
    //  Group: Variables
    uvm_xor_seq_item    txn_in;
    uvm_xor_seq_item    txn_out;

    //  Group: Functions
    extern function new(string name = "uvm_xor_sb", uvm_component parent);

    extern void function build_phase(uvm_phase phase);

    extern virtual task run_phase(uvm_phase phase);

    extern virtual task sample_txns();

    extern virtual task process_txns();

endclass: uvm_xor_sb

function uvm_xor_sb::new(string name = "uvm_xor_sb", uvm_component parent);
    super.new(name, parent);
endfunction: new

function uvm_xor_sb::build_phase(uvm_phase phase);
    super.build_phase(phase);

    sb_in_txn   = new("sb_in_txn", this);
    sb_out_txn  = new("sb_out_txn", this);

    txn_in  = uvm_xor_seq_item::type_id::create("txn_in");
    txn_out = uvm_xor_seq_item::type_id::create("txn_out");

    `uvm_info(get_full_name(), "Build stage completed", UVM_LOW)    
endfunction: build_phase

task uvm_xor_sb::run_phase(uvm_phase phase);
    sample_txns();
endtask: run_phase

task uvm_xor_sb::sample_txns();
    forever begin
        sb_in_txn.get(txn_in);
        sb_out_txn.get(txn_out);
        process_txns();
    end
endtask: sample_txns

task uvm_xor_sb::process_txns();
    //bit [DATA_WIDTH-1:0]  = prd_inA;
    //bit [DATA_WIDTH-1:0]  = prd_inB;
    bit [DATA_WIDTH-1:0]  = prd_dout;

    if ((txn_in.i__inA == 0 && txn_in.i__inB == 0) || (txn_in.i__inA == 1 && txn_in.i__inB == 1)) begin
        prd_dout = 9'h000;
        if (prd_dout != txn_out.o__dout) begin
            `uvm_error(get_full_name(), "Scoreboard Mismatch: Expected Value - %0b     Actual Value - %0b", prd_dout, txn_in.o__dout)
        end
    end
    else begin
        if ((txn_in.i__inA == 0 && txn_in.i__inB == 1) || (txn_in.i__inA == 1 && txn_in.i__inB == 0)) begin
            prd_dout = txn_in.i__inA ^ txn_in.i__inB;
            if (prd_dout != txn_out.o__dout) begin
                `uvm_error(get_full_name(), "Scoreboard Mismatch: Expected Value - %0b     Actual Value - %0b", prd_dout, txn_out.o__dout) 
            end
        end
    end
endtask: process_txns