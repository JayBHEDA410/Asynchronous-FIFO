`timescale 1ns/1ps
module write_ptr_module #(parameter PTR_WIDTH=4) (w_clk,w_rst,w_en,g_read_ptr_sync,b_write_ptr,g_write_ptr,full);
  input w_clk, w_rst, w_en;
  input [PTR_WIDTH:0] g_read_ptr_sync;
  output reg [PTR_WIDTH:0] b_write_ptr, g_write_ptr;
  output reg full;
  
  wire [PTR_WIDTH:0] b_write_ptr_next;
  wire [PTR_WIDTH:0] g_write_ptr_next;
   
  reg wrap_around;
  wire write_full;
  
  assign b_write_ptr_next = b_write_ptr+(w_en & !full);                  
  assign g_write_ptr_next = (b_write_ptr_next >>1)^b_write_ptr_next;     //convert binary to gray code
  
  always@(posedge w_clk or negedge w_rst) begin
    if(!w_rst)
		begin
			b_write_ptr <= 0; 
			g_write_ptr <= 0;
		end                                                   // contain location of next write 
    else 
		begin
			b_write_ptr <= b_write_ptr_next; 
			g_write_ptr <= g_write_ptr_next;              
		end
  end
  
  always@(posedge w_clk or negedge w_rst) begin
    if(!w_rst)
			full <= 0;                                                    
    else                                               // generate full condition
			full <= write_full;
  end
                                       
  assign write_full = ({~g_write_ptr_next[PTR_WIDTH:PTR_WIDTH-1],g_write_ptr_next[PTR_WIDTH-2:0]} ==  g_read_ptr_sync);

endmodule
