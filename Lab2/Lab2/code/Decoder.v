//Subject:     CO project 2 - Decoder
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      0616223 0616059
//----------------------------------------------
//Date:        4/27
//----------------------------------------------
//Description: instruction decoder
//--------------------------------------------------------------------------------

module Decoder(
  instr_op_i,
	RegWrite_o,
	ALU_op_o,
	ALUSrc_o,
	RegDst_o,
	Branch_o
	);
     
//I/O ports
input  [6-1:0] instr_op_i;

output         RegWrite_o;
output [3-1:0] ALU_op_o;
output         ALUSrc_o;
output         RegDst_o;
output         Branch_o;
 
//Internal Signals
reg    [3-1:0] ALU_op_o;
reg            ALUSrc_o;
reg            RegWrite_o;
reg            RegDst_o;
reg            Branch_o;

//Parameter


//Main function

always @( * )
	
	begin

	case(instr_op_i)

		6'b000000 : 
			begin 
				ALU_op_o = 3'b010; 
				ALUSrc_o = 1'b0; 
				RegWrite_o = 1'b1;
				RegDst_o = 1'b1;
				Branch_o = 1'b0;
			end

		6'b001000 : // aadi
			begin
				ALU_op_o = 3'b100;
				ALUSrc_o = 1'b1;
				RegWrite_o = 1'b1;
				RegDst_o = 1'b0;
				Branch_o = 1'b0;
			end

		6'b001011 : // sltiu 
			begin
				ALU_op_o = 3'b101;
				ALUSrc_o = 1'b1;
				RegWrite_o = 1'b1;
				RegDst_o = 1'b0;
				Branch_o = 1'b0;
			end	

		6'b000100 : // beq
			begin
				ALU_op_o = 3'b001;
				ALUSrc_o = 1'b0;
				RegWrite_o = 1'b0;
				Branch_o = 1'b1;
			end

		6'b001111 : //lui
			begin
				ALU_op_o = 3'b110;
				ALUSrc_o = 1'b1;
				RegWrite_o = 1'b1;
				RegDst_o = 1'b0;
				Branch_o = 1'b0;
			end

		6'b001101 : //ori
			begin
				ALU_op_o = 3'b111;
				ALUSrc_o = 1'b1;
				RegWrite_o = 1'b1;
				RegDst_o = 1'b0;
				Branch_o = 1'b0;
			end

		6'b000101 : //bne
			begin
				ALU_op_o = 3'b011;
				ALUSrc_o = 1'b0;
				RegWrite_o = 1'b0;
				Branch_o = 1'b1;
			end



	endcase

	end

endmodule





                    
                    
