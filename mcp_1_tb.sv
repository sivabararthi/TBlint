module mcp_1_tb (
                 output reg       reset,
                 output reg       clk1,
                 output reg       clk2,
                 output reg [7:0] data_in,
                 input [7:0]      data_out
                 );

   reg [2:0]                      count;
   
   initial begin
      $dumpvars();
      
      clk1 = 0;
      clk2 = 0;
      data_in = 0;
      count = 0;
      
      reset = 0;
      reset = #30 1;
      reset = #30 0;
      
      #100 $finish;
   end

   always @(posedge clk2) begin
      if (count == 0) begin
         data_in = 10;
      end
      else begin
         data_in = data_in * count;
      end
      count = count + 1;
   end
   
   always clk1 = #5 ~clk1;
   always clk2 = #10 ~clk2;

endmodule // mcp_1_tb



      
   
