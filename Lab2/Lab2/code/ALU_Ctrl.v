//Subject:     CO project 2 - ALU Controller
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      0616223 0616059
//----------------------------------------------
//Date:        4/27
//----------------------------------------------
//Description: determine which control code should give to ALU
//--------------------------------------------------------------------------------

module ALU_Ctrl(
          funct_i,
          ALUOp_i,
          ALUCtrl_o
          );
          
//I/O ports 
input      [6-1:0] funct_i;
input      [3-1:0] ALUOp_i;

output     [4-1:0] ALUCtrl_o;    
     
//Internal Signals
reg        [4-1:0] ALUCtrl_o;

//Parameter

       
//Select exact operation
always @( * )
	begin
		case(ALUOp_i)

			3'b010 : //R-type
				begin
					case(funct_i)
						6'b100001 : ALUCtrl_o = 4'b0010; //add
						
						6'b100011 : ALUCtrl_o = 4'b0110; //sub
						
						6'b100100 : ALUCtrl_o = 4'b0000; //and
						
						6'b100101 : ALUCtrl_o = 4'b0001; //or

						6'b101010 : ALUCtrl_o = 4'b0111; //slt

						6'b000011 : ALUCtrl_o = 4'b1101; //sra

						6'b000111 : ALUCtrl_o = 4'b1001; //srav
					endcase
				end
			
			3'b001 : ALUCtrl_o = 4'b0110;// beq
			
			3'b011 : ALUCtrl_o = 4'b1111;// bne
			
			3'b100 : ALUCtrl_o = 4'b0010;// addi
			
			3'b101 : ALUCtrl_o = 4'b1110;// sltiu
			
			3'b110 : ALUCtrl_o = 4'b1000;// lui
			
			3'b111 : ALUCtrl_o = 4'b0001;// ori
		endcase
	end
endmodule     





                    
                    
