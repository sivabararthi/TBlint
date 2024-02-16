module uvm_xor_tb_top;
    
    import uvm_pkg::*;

    bit i__clk;
    bit i__sreset_n;
    bit i__areset_n;

    xor_if  xor_top (.i__clk(i__clk),
                     .i__areset_n(i__areset_n),
                     .i__sreset_n(i__sreset_n),
                     .i__inA(i__inA),
                     .i__inB(i__inB),
                     .o__dout(o__dout)
                    );
   
    always #10 i__clk = ~i__clk;

    initial begin
        #5  i__areset_n = 1'b0;
        #25 i__areset_n = 1'b1;

        #15 i__sreset_n = 1'b0;
        #30 i__sreset_n = 1'b1;
    end

    initial begin
        run_test();
    end

endmodule: uvm_xor_tb_top