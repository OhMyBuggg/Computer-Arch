//Subject:     CO project 3 - ALU Controller
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      0616223 0616059
//----------------------------------------------
//Date:        5/20
//----------------------------------------------
//Description: determine which control code should give to ALU
//--------------------------------------------------------------------------------

module ALU_Ctrl(
          funct_i,
          ALUOp_i,
          ALUCtrl_o,
          Jr_o
          );
          
//I/O ports 
input      [6-1:0] funct_i;
input      [3-1:0] ALUOp_i;

output     [4-1:0] ALUCtrl_o;    
output 						 Jr_o;
//Internal Signals
reg        [4-1:0] ALUCtrl_o;
reg								 Jr_o;

//Parameter

       
//Select exact operation
always @( * )
	begin
		case(ALUOp_i)

			3'b010 : //R-type
				begin
					case(funct_i)
						6'b100001 : begin
							ALUCtrl_o = 4'b0010; //add
							Jr_o = 1'b0;
							end

						6'b100011 : begin
							ALUCtrl_o = 4'b0110; //sub
							Jr_o = 1'b0;
							end

						6'b100100 : begin
							ALUCtrl_o = 4'b0000; //and
							Jr_o = 1'b0;
							end

						6'b100101 : begin
							ALUCtrl_o = 4'b0001; //or
							Jr_o = 1'b0;
							end

						6'b101010 : begin
							ALUCtrl_o = 4'b0111; //slt
							Jr_o = 1'b0;
							end

						6'b000011 : begin
							ALUCtrl_o = 4'b1101; //sra
							Jr_o = 1'b0;
							end

						6'b000111 : begin
							ALUCtrl_o = 4'b1001; //srav
							Jr_o = 1'b0;
							end

						6'b011000 : begin
							ALUCtrl_o = 4'b0101; //mul
							Jr_o = 1'b0;
							end

						6'b001000 : begin
							ALUCtrl_o = 4'b0010; //jr
							Jr_o = 1'b1;
							end

						6'b000000 : begin
							ALUCtrl_o = 4'b0010; //nop
							Jr_o = 1'b0;
						end
					endcase
				end
			
			3'b001 : begin
				ALUCtrl_o = 4'b0110;// beq
				Jr_o = 1'b0;
				end
			3'b011 : begin
				ALUCtrl_o = 4'b1111;// bne, bnez
				Jr_o = 1'b0;
				end
			3'b100 : begin
				ALUCtrl_o = 4'b0010;// addi, lw, sw, li
				Jr_o = 1'b0;
				end
			3'b101 : begin
				ALUCtrl_o = 4'b1110;// bltz
				Jr_o = 1'b0;
				end
			3'b110 : begin
				ALUCtrl_o = 4'b1000;// lui
				Jr_o = 1'b0;
				end
			3'b111 : begin
				ALUCtrl_o = 4'b0001;// ori
				Jr_o = 1'b0;
				end
			3'b000 : begin 
				ALUCtrl_o = 4'b0011;//ble
				Jr_o = 1'b0;
			end
		endcase
	end
endmodule     





                    
                    
