// Code your testbench here
// or browse Examples
`include "uvm_macros.svh"
`include "ram_interface.sv"
module ram_tb;
import uvm_pkg::*;
`include "ram_transaction.sv"
`include "ram_sequence.sv"
`include "ram_monitor.sv"
`include "ram_driver.sv"
`include "ram_scoreboard.sv"
`include "ram_bus_monitor.sv"
`include "ram_agent.sv"
`include "ram_env.sv"
`include "ram_test.sv"
 

test t;
ram_if rif();
 
ram dut (.clk(rif.clk), .wr(rif.wr), .din(rif.din), .dout(rif.dout), .addr(rif.addr));
 
initial begin
rif.clk = 0;
end
 
always#10 rif.clk = ~rif.clk;
 
initial begin
t = new("TEST", null);
uvm_config_db #(virtual ram_if)::set(null, "*", "rif", rif);
run_test();
end
 
endmodule
