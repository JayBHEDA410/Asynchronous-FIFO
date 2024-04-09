`timescale 1ns/1ps
module read_ptr_module #(parameter PTR_WIDTH=4) (r_clk, r_rst, r_en, g_write_ptr_sync, b_read_ptr, g_read_ptr, empty);
  input r_clk, r_rst, r_en;
  input [PTR_WIDTH:0] g_write_ptr_sync;
  output reg [PTR_WIDTH:0] b_read_ptr, g_read_ptr;
  output reg empty;
  
  wire [PTR_WIDTH:0] b_read_ptr_next;
  wire [PTR_WIDTH:0] g_read_ptr_next;
  wire r_empty;
  
  assign b_read_ptr_next = b_read_ptr+(r_en & !empty);
  assign g_read_ptr_next = (b_read_ptr_next >>1)^b_read_ptr_next;             //binary to gray conversion
                                                                          
  assign r_empty = (g_write_ptr_sync == g_read_ptr_next);                    // empty condition
  
  always@(posedge r_clk or negedge r_rst) begin
    if(!r_rst)
		begin
			b_read_ptr <= 0;
			g_read_ptr <= 0;
      end
    else 
	   begin
         b_read_ptr <= b_read_ptr_next;
         g_read_ptr <= g_read_ptr_next;                     //contain next location for read value
      end
  end
  
  always@(posedge r_clk or negedge r_rst) begin
    if(!r_rst)
			empty <= 1;
    else       
			empty <= r_empty;                                  
  end
endmodule