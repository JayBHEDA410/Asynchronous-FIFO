`timescale 1ns/1ps
module synchronizer #(parameter WIDTH=4) (clk,rst,d_in,d_out);
  input clk,rst;
  input [WIDTH:0] d_in;
  output reg [WIDTH:0] d_out;
  
  reg [WIDTH:0] q;
  
  always@(posedge clk) begin
    if(!rst) begin                      //avoid metastability effect used synchronizer
      q <= 0;
      d_out <= 0;
    end
	 
    else begin
      q <= d_in;
      d_out <= q;
    end
  end
endmodule