`timescale 1ns/1ps
module Asynchronous_FIFO #(parameter DEPTH=16, PTR_WIDTH=4, DATA_WIDTH=8) (w_clk, w_rst, r_clk, r_rst, w_en, r_en, data_in, data_out, full, empty);
  
  input w_clk, w_rst;
  input r_clk, r_rst;
  input w_en, r_en;
  input [DATA_WIDTH-1:0] data_in;
  
  output [DATA_WIDTH-1:0] data_out;
  output  full, empty;
 
  wire [PTR_WIDTH:0] g_write_ptr_sync, g_read_ptr_sync;
  wire [PTR_WIDTH:0] b_write_ptr, b_read_ptr;
  wire [PTR_WIDTH:0] g_write_ptr, g_read_ptr;

  synchronizer #(PTR_WIDTH) sync_write_ptr (.clk(r_clk), .rst(r_rst), .d_in(g_write_ptr), .d_out(g_write_ptr_sync)); //write pointer to read clock domain
  synchronizer #(PTR_WIDTH) sync_read_ptr  (.clk(w_clk), .rst(w_rst), .d_in(g_read_ptr), .d_out(g_read_ptr_sync)); //read pointer to write clock domain 
  
  write_ptr_module #(PTR_WIDTH) write_ptr_copymodule (.w_clk(w_clk), .w_rst(w_rst), .w_en(w_en), .g_read_ptr_sync(g_read_ptr_sync), .b_write_ptr(b_write_ptr), .g_write_ptr(g_write_ptr), .full(full));
  read_ptr_module  #(PTR_WIDTH) read_ptr_copymodule  (.r_clk(r_clk), .r_rst(r_rst), .r_en(r_en), .g_write_ptr_sync(g_write_ptr_sync), .b_read_ptr(b_read_ptr), .g_read_ptr(g_read_ptr), .empty(empty));
  
  FIFO_MEM #(DEPTH, DATA_WIDTH, PTR_WIDTH) fifo_copy (w_clk, r_clk, r_en, w_en, b_write_ptr, b_read_ptr, data_in, data_out, full, empty);

endmodule
