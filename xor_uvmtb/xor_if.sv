interface xor_if#(                                                                              
    parameter DATA_WIDTH = 10                                                 
 );
    
    logic                       i__clk;
    logic                       i__areset_n;
    logic                       i__sreset_n;
    logic   [DATA_WIDTH-1:0]    i__inA;
    logic   [DATA_WIDTH-1:0]    i__inB;
    logic   [DATA_WIDTH-1:0]    o__dout;

endinterface: xor_if