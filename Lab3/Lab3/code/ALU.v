//Subject:     CO project 3 - ALU
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      0616223 0616059
//----------------------------------------------
//Date:        5/20
//----------------------------------------------
//Description: ALU with ALUCtrl input
//--------------------------------------------------------------------------------

module ALU(
    src1_i,
	src2_i,
	ctrl_i,
	result_o,
	zero_o
	);
     
//I/O ports
input  [32-1:0]  src1_i;
input  [32-1:0]	 src2_i;
input  [4-1:0]   ctrl_i;

output [32-1:0]	 result_o;
output           zero_o;

//Internal signals
reg    [32-1:0]  result_o;
wire             zero_o;

//Parameter
integer i;
reg [15:0] temp;
reg [4:0]  temp_2;
reg [31:0] temp_3;
//Main function

always@ ( * )
	begin
		case(ctrl_i)
			4'b0010:
				begin
					result_o = src1_i + src2_i;
				end
			4'b0110:
				begin
					result_o = src1_i + ~src2_i + 1;
				end
			4'b0000:
				begin
					result_o = src1_i & src2_i;
				end
			4'b0001:
				begin
					result_o = src1_i | src2_i;
				end
			4'b0111:
				begin
					result_o = src1_i + ~src2_i + 1;
					if(result_o[31])begin
						result_o = 1;
					end
					else begin
						result_o = 0;
					end
				end
			4'b1101 : //sra
				begin
					temp_2 = src1_i[10:6];
					result_o = src2_i >> temp_2;
					if(src2_i[31])begin
						for(temp_2=temp_2;temp_2>0;temp_2=temp_2-1)
							begin
								result_o[31-temp_2+1]=1'b1;
							end
					end
				end
			4'b1001 : //srav
				begin
					result_o = src2_i >> src1_i;
					if(src2_i[31])begin
					temp_3=src1_i;
						for(temp_3=temp_3;temp_3>0;temp_3=temp_3-1)
							begin
								result_o[31-temp_3+1]=1'b1;
							end
					end
				end
			4'b1000 : //lui
				begin
					temp = src2_i[15:0];
					result_o = temp << 16; 
				end
			4'b1110 : //bltz
				begin
					if(src1_i[31] == 1)begin
						result_o = 0;
					end
					else begin
						result_o = 1;
					end
				end
			4'b1111 : //bne, bnez
				begin
					result_o = src1_i + ~src2_i + 1;
					if(result_o == 0)begin
						result_o = 1;
					end
					else begin
						result_o = 0;
					end
				end
			4'b0101 : //mul
				begin
					result_o = src1_i * src2_i;
				end
			4'b0011 : //ble
				begin
					if(src1_i <= src2_i)begin
						result_o = 0;
					end
					else begin
						result_o = 1;
					end
				end
		endcase
	end

assign zero_o = result_o == 0 ? 1 : 0;
endmodule





                    
                    
