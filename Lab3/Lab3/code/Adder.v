//Subject:     CO project 3 - Adder
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      0616223 0616059
//----------------------------------------------
//Date:        5/20 
//----------------------------------------------
//Description: add two 32 bits data
//--------------------------------------------------------------------------------

module Adder(
  src1_i,
	src2_i,
	sum_o
	);
     
//I/O ports
input  [32-1:0]  src1_i;
input  [32-1:0]	 src2_i;
output [32-1:0]	 sum_o;

//Internal Signals
wire    [32-1:0]	 sum_o;

//Parameter
    
//Main function

assign sum_o = src1_i + src2_i;

endmodule





                    
                    
