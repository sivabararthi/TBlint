module mcp_1 (
              input reset,
              input clk1,
              input clk2,
              input [7:0] data_in,
              output reg [7:0] data_out
              );

   reg [8:0]                   data_tmp;
   reg [7:0]                   data_tmp1;
   logic [7:0]                   data_tmp2;
     
   always @(posedge clk2) begin
      if (reset) begin
         data_out <=  8'b0;
         data_tmp2 <=  8'b0;
      end 
      else begin
         data_tmp2 <=  data_tmp1;
         data_out <=  data_tmp2;
      end
   end

   always @(posedge clk1) begin
      if (reset) begin
         data_tmp1 <=  8'b0;
      end
      else begin
         data_tmp1 <=  data_tmp;
      end
   end

   always @(data_in) begin
      if (reset) begin
         data_tmp = 0;
      end
      else begin
         data_tmp =  data_in + data_in;
      end
   end
endmodule // mcp_1
