`timescale 1ns/1ps
module FIFO_MEM #(parameter DEPTH=16, DATA_WIDTH=8, PTR_WIDTH=4) (w_clk, r_clk, r_en, w_en, b_write_ptr, b_read_ptr, data_in, data_out, full, empty);

  input w_clk, w_en, r_clk, r_en;
  input [PTR_WIDTH:0] b_write_ptr, b_read_ptr;
  input [DATA_WIDTH-1:0] data_in;
  input full, empty;
  
  output [DATA_WIDTH-1:0] data_out;
  
  reg [DATA_WIDTH-1:0] fifo[0:DEPTH-1];
  
  always@(posedge w_clk) begin
    if(w_en & !full)                                     // write value in FIFO
		begin
			fifo[b_write_ptr[PTR_WIDTH-1:0]] <= data_in;
		end
  end
  
  
  assign data_out = fifo[b_read_ptr[PTR_WIDTH-1:0]];      // read value from FIFO
endmodule
