//Subject:      CO project 2 - Shift_Left_Two_32
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Description: shift data left two bits
//--------------------------------------------------------------------------------

module Shift_Left_Two_32(
    data_i,
    data_o
    );

//I/O ports                    
input [32-1:0] data_i;

output [32-1:0] data_o;

reg [31:0] i,data_o;

//shift left 2

always @( * )
	begin
	
	data_o[0] = 1'b0;
	data_o[1] = 1'b0;

	for(i=2; i<=31; i=i+1)
		begin
		data_o[i] = data_i[i-2];
		end
		
	end

endmodule
