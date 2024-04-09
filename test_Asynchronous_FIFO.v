`timescale 1ns/1ps
module test_Asynchronous_FIFO;

	reg w_en,r_en,w_clk,r_clk,w_rst,r_rst;
	reg [7:0] data_in;    
	
	wire full,empty;
	wire [7:0] data_out;
	
	integer i;
	
	Asynchronous_FIFO test_copy(.w_clk(w_clk), .w_rst(w_rst), .r_clk(r_clk), .r_rst(r_rst), .w_en(w_en), .r_en(r_en), .data_in(data_in), .data_out(data_out), .full(full), .empty(empty));
	
	initial begin
		w_clk=0;
		r_clk=0;
		
		w_rst=1;
		r_rst=1;
		             
		r_en=0;
		w_en=0;
		
		#2 w_rst=0;
	      r_rst=0;         //reset effect
		
		#4 w_rst=1;
	      r_rst=1;
		end
		
	always #5 w_clk= ~w_clk;                   //read frequency is lower then write frequency
	always #10 r_clk= ~r_clk;
	
	initial begin
		#9 w_en=1;
		for(i=0;i<16;i=i+1)
			@(negedge w_clk)
			begin
				data_in=$random;
		   end                               // write total 15 random value in FIFO
			#20 r_en= 1;
		   w_en=0;                            // read all value 
			   
			
			
		end
		
	initial begin
		$monitor("%d %d %d %d" ,$time,test_copy.read_ptr_copymodule.b_read_ptr_next, test_copy.read_ptr_copymodule.b_read_ptr, test_copy.write_ptr_copymodule.g_write_ptr, test_copy.fifo_copy.fifo[0]);
		end
		                                   // debugging
			
		                 
	initial begin
		#600 $finish;
		end         
		
		
endmodule