//Subject:     CO project 2 - Sign extend
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      0616223 0616059
//----------------------------------------------
//Date:        4/27	
//----------------------------------------------
//Description: extend 16 bits to 32 bits
//--------------------------------------------------------------------------------

module Sign_Extend(
    data_i,
    data_o
    );
               
//I/O ports
input   [16-1:0] data_i;
output  [32-1:0] data_o;

//Internal Signals
reg     [32-1:0] data_o;
reg     [31:0] i;
//Sign extended

always @(data_i)
	begin
		
		for( i=0 ; i<=15 ; i=i+1)
			data_o[i]=data_i[i];
		
		for( i=16 ; i<=31 ; i=i+1)
			data_o[i]=data_i[15];
	end

endmodule      
     
