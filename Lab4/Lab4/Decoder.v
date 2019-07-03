//Subject:     CO project 3 - Decoder
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      
//0616059 吳炯毅 0616223 劉柏宇
//Date:        5/20
//----------------------------------------------
//Description: controller
//--------------------------------------------------------------------------------

module Decoder(
  instr_op_i,
  instr_fun_i,
	RegWrite_o,
	ALU_op_o,
	ALUSrc_o,
	RegDst_o,
	Branch_o,
//lab
	Jump_o,
	MemRead_o,
	MemWrite_o,
	MemtoReg_o
	);
     
//I/O ports
input  [6-1:0] instr_op_i;
input  [6-1:0] instr_fun_i;

output         RegWrite_o;
output [3-1:0] ALU_op_o;
output         ALUSrc_o;
output [2-1:0] RegDst_o;
output         Branch_o;
//lab3
output		   Jump_o;
output		   MemRead_o;
output		   MemWrite_o;
output [2-1:0] MemtoReg_o;
 
//Internal Signals
reg    [3-1:0] ALU_op_o;
reg            ALUSrc_o;
reg            RegWrite_o;
reg    [2-1:0] RegDst_o;
reg            Branch_o;
//lab3
reg		       Jump_o;
reg		       MemRead_o;
reg		       MemWrite_o;
reg	   [2-1:0] MemtoReg_o;

//Parameter


//Main function

always @( * )
	
	begin

	case(instr_op_i)

		6'b000000 : 
			begin
				if(instr_fun_i==6'b001000) //jr
					begin
					 	ALU_op_o = 3'b010; 
						ALUSrc_o = 1'b0; 
						RegWrite_o = 1'b0;
						//RegDst_o = 2'b01;
						Branch_o = 1'b0;
						//lab3
						Jump_o = 1'b0;
						MemRead_o = 1'b0;
						MemWrite_o = 1'b0;
						MemtoReg_o = 2'b00;
					 end
				else	  
					begin
						ALU_op_o = 3'b010; 
						ALUSrc_o = 1'b0; 
						RegWrite_o = 1'b1;
						RegDst_o = 2'b01;
						Branch_o = 1'b0;
						//lab3
						Jump_o = 1'b0;
						MemRead_o = 1'b0;
						MemWrite_o = 1'b0;
						MemtoReg_o = 2'b00;
					end
			end

		6'b001000 : // addi
			begin
				ALU_op_o = 3'b100;
				ALUSrc_o = 1'b1;
				RegWrite_o = 1'b1;
				RegDst_o = 2'b00;
				Branch_o = 1'b0;
				//lab3
				Jump_o = 1'b0;
				MemRead_o = 1'b0;
				MemWrite_o = 1'b0;
				MemtoReg_o = 2'b00;
			end

		6'b001011 : // sltiu 
			begin
				ALU_op_o = 3'b101;
				ALUSrc_o = 1'b1;
				RegWrite_o = 1'b1;
				RegDst_o = 2'b00;
				Branch_o = 1'b0;
				//lab3
				Jump_o = 1'b0;
				MemRead_o = 1'b0;
				MemWrite_o = 1'b0;
				MemtoReg_o = 2'b00;
			end	

		6'b000100 : // beq
			begin
				ALU_op_o = 3'b001;
				ALUSrc_o = 1'b0;
				RegWrite_o = 1'b0;
				Branch_o = 1'b1;
				//lab3
				Jump_o = 1'b0;
				MemRead_o = 1'b0;
				MemWrite_o = 1'b0;
				//MemtoReg_o = 2'b01;
			end

		/*6'b001111 : //lui
			begin
				ALU_op_o = 3'b110;
				ALUSrc_o = 1'b1;
				RegWrite_o = 1'b1;
				RegDst_o = 2'b00;
				Branch_o = 1'b0;
				//lab3
				Jump_o = 1'b0;
				MemRead_o = 1'b0;
				MemWrite_o = 1'b0;
				MemtoReg_o = 2'b00;
			end*/

		6'b001101 : //ori
			begin
				ALU_op_o = 3'b111;
				ALUSrc_o = 1'b1;
				RegWrite_o = 1'b1;
				RegDst_o = 2'b00;
				Branch_o = 1'b0;
				//lab3
				Jump_o = 1'b0;
				MemRead_o = 1'b0;
				MemWrite_o = 1'b0;
				MemtoReg_o = 2'b00;
			end

		6'b000101 : //bne
			begin
				ALU_op_o = 3'b011;
				ALUSrc_o = 1'b0;
				RegWrite_o = 1'b0;
				//RegDst_o = ;
				Branch_o = 1'b1;
				//lab3
				Jump_o = 1'b0;
				MemRead_o = 1'b0;
				MemWrite_o = 1'b0;
				//MemtoReg_o = ;
			end
// lab3
		6'b100011 : //lw
			begin
				ALU_op_o = 3'b100;
				ALUSrc_o = 1'b1;
				RegWrite_o = 1'b1;
				RegDst_o = 2'b00;
				Branch_o = 1'b0;
				Jump_o = 1'b0;
				MemRead_o = 1'b1;
				MemWrite_o = 1'b0;
				MemtoReg_o = 2'b01;
			end

		6'b101011 : //sw
			begin
				ALU_op_o = 3'b100;
				ALUSrc_o = 1'b1;
				RegWrite_o = 1'b0;
				//RegDst_o = 2'b0;
				Branch_o = 1'b0;
				Jump_o = 1'b0;
				MemRead_o = 1'b0;
				MemWrite_o = 1'b1;
				//MemtoReg_o = ;
			end

		6'b000010 : //j
			begin
				ALU_op_o = 3'b100;
				//ALUSrc_o = 1'b1;
				RegWrite_o = 1'b0;
				//RegDst_o = 2'b0;
				Branch_o = 1'b0;
				Jump_o = 1'b1;
				MemRead_o = 1'b0;
				MemWrite_o = 1'b0;
				//MemtoReg_o = ;
			end

		6'b000011 : //jal
			begin
				ALU_op_o = 3'b100;
				//ALUSrc_o = 1'b1;
				RegWrite_o = 1'b1;
				RegDst_o = 2'b10;
				Branch_o = 1'b0;
				Jump_o = 1'b1;
				MemRead_o = 1'b0;
				MemWrite_o = 1'b0;
				MemtoReg_o = 2'b11;
			end

		6'b001111 : //li
			begin
				ALU_op_o = 3'b100;
				ALUSrc_o = 1'b1;
				RegWrite_o = 1'b1;
				RegDst_o = 2'b00;
				Branch_o = 1'b0;
				//lab3
				Jump_o = 1'b0;
				MemRead_o = 1'b0;
				MemWrite_o = 1'b0;
				MemtoReg_o = 2'b00;
			end

		6'b000110 : //ble
			begin
				ALU_op_o = 3'b000;
				ALUSrc_o = 1'b0;
				RegWrite_o = 1'b0;
				//RegDst_o = ;
				Branch_o = 1'b1;
				//lab3
				Jump_o = 1'b0;
				MemRead_o = 1'b0;
				MemWrite_o = 1'b0;
				//MemtoReg_o = ;
			end

		6'b000001 : //bltz
			begin
				ALU_op_o = 3'b101;
				ALUSrc_o = 1'b0;
				RegWrite_o = 1'b0;
				//RegDst_o = ;
				Branch_o = 1'b1;
				//lab3
				Jump_o = 1'b0;
				MemRead_o = 1'b0;
				MemWrite_o = 1'b0;
				//MemtoReg_o = ;
			end






	endcase

	end

endmodule





                    
                    