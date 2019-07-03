//Subject:     CO project 3 - PC
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      0616223 0616059
//----------------------------------------------
//Date:        5/20
//----------------------------------------------
//Description: PC
//--------------------------------------------------------------------------------

module ProgramCounter(
    clk_i,
	start_i,
	pc_in_i,
	pc_out_o
	);
     
//I/O ports
input           clk_i;
input	        start_i;
input  [32-1:0] pc_in_i;
output [32-1:0] pc_out_o;
 
//Internal Signals
reg    [32-1:0] pc_out_o;
 
//Parameter

    
//Main function
always @(posedge clk_i) begin
    if(~start_i)
	    pc_out_o <= 0;
	else
	    pc_out_o <= pc_in_i;
end

endmodule



                    
                    
