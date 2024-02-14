module mcp_1_top;
   wire clk1;
   wire clk2;
   wire reset;
   wire [7:0] data_in;
   wire [7:0] data_out;
   
   mcp_1 mcp_1_i (.reset(reset),
                  .clk1(clk1),
                  .clk2(clk2),
                  .data_in(data_in),
                  .data_out(data_out)
                  );
   
   mcp_1_tb mcp_1_tb_i (.reset(reset),
                        .clk1(clk1),
                        .clk2(clk2),
                        .data_in(data_in),
                        .data_out(data_out)
                        );
endmodule // mcp_1_top
