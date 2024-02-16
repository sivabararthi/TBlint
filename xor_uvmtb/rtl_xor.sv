module rtl_xor                                        
   #(                                                                              
      parameter DATA_WIDTH = 10                                                 
   )(                                                                              
      input  wire                   i__clk,
      input  wire                   i__areset_n,
      input  wire                   i__sreset_n,
                                                    
      input  wire  [DATA_WIDTH-1:0] i__inA,
      input  wire  [DATA_WIDTH-1:0] i__inB,
      output reg   [DATA_WIDTH-1:0] o__dout
   );         

   always @(posedge i__clk or negedge i__areset_n) begin
      if (!i__areset_n) o__dout <= {DATA_WIDTH{1'b0}};
      else if (!i__sreset_n) o__dout <= {DATA_WIDTH{1'b0}};
      else begin
         o__dout <= i__inA ^ i__inB;
      end
   end
    
endmodule