//Subject:     CO project 2 - Simple Single CPU
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      0616223 0616059
//----------------------------------------------
//Date:        4/27	
//----------------------------------------------
//Description: main CPU
//--------------------------------------------------------------------------------
module Simple_Single_CPU(
        clk_i,
		rst_i
		);
		
//I/O port
input         clk_i;
input         rst_i;

//Internal Signles
wire [31:0] pc_out;
wire [31:0] sum_1;
wire [31:0] instr;
wire [5:0] instr_op;
assign instr_op = instr[31:26];
wire [4:0] RSadd;
assign RSadd = instr[25:21];
wire [4:0] RTadd;
assign RTadd = instr[20:16];
wire RegDst;
wire [4:0] muxRD;
assign muxRD = instr[15:11];
wire [4:0] RDadd;
wire RegWrite;
wire [31:0] RSdata;
wire [31:0] RTdata;
wire ALUsrc;
wire Branch;
wire [2:0] ALUOp;
wire [5:0] funct;
assign funct = instr[5:0];
wire [15:0] signi;
assign signi =instr[15:0];
wire [31:0] signo;
wire [31:0] ALUsrc2;
wire [3:0] ALUCtrl;
wire [31:0] Shifto;
wire [31:0] ALUResult;
wire zero;
wire [31:0] ADD2o;
wire bselect;
assign bselect = Branch & zero;
wire [31:0] pc_in;

//wire [31:0] shamt;
//assign shamt = 32'd0;
//assign shamt[4:0] = instr[10:6];
wire select_shamt;
assign select_shamt = (instr[10] | instr[9] | instr[8] | instr[7] | instr[6]) & RegDst & ~Branch;
wire [31:0]shamt_output;
//Greate componentes
ProgramCounter PC(
        .clk_i(clk_i),      
	    .rst_i (rst_i),     
	    .pc_in_i(pc_in) ,   
	    .pc_out_o(pc_out) 
	    );
	
Adder Adder1(
        .src1_i(32'd4),     
	    .src2_i(pc_out),     
	    .sum_o(sum_1)    
	    );
	
Instr_Memory IM(
        .pc_addr_i(pc_out),  
	    .instr_o(instr)    
	    );

MUX_2to1 #(.size(5)) Mux_Write_Reg(
        .data0_i(RTadd),
        .data1_i(muxRD),
        .select_i(RegDst),
        .data_o(RDadd)
        );	
		
Reg_File RF(
        .clk_i(clk_i),      
	    .rst_i(rst_i) ,     
        .RSaddr_i(RSadd) ,  
        .RTaddr_i(RTadd) ,  
        .RDaddr_i(RDadd) ,  
        .RDdata_i(ALUResult)  , 
        .RegWrite_i (RegWrite),
        .RSdata_o(RSdata) ,  
        .RTdata_o(RTdata)   
        );
	
Decoder Decoder(
        .instr_op_i(instr_op), 
	    .RegWrite_o(RegWrite), 
	    .ALU_op_o(ALUOp),   
	    .ALUSrc_o(ALUsrc),   
	    .RegDst_o(RegDst),   
		.Branch_o(Branch)   
	    );

ALU_Ctrl AC(
        .funct_i(funct),   
        .ALUOp_i(ALUOp),   
        .ALUCtrl_o(ALUCtrl) 
        );
	
Sign_Extend SE(
        .data_i(signi),
        .data_o(signo)
        );

MUX_2to1 #(.size(32)) Mux_ALUSrc(
        .data0_i(RTdata),
        .data1_i(signo),
        .select_i(ALUsrc),
        .data_o(ALUsrc2)
        );

MUX_2to1 #(.size(32)) shamt_control(
        .data0_i(RSdata),
        .data1_i(instr),
        .select_i(select_shamt),
        .data_o(shamt_output)
        );      	
		
ALU ALU(
        .src1_i(shamt_output),
	    .src2_i(ALUsrc2),
	    .ctrl_i(ALUCtrl),
	    .result_o(ALUResult),
		.zero_o(zero)
	    );
		
Adder Adder2(
        .src1_i(sum_1),     
	    .src2_i(Shifto),     
	    .sum_o(ADD2o)      
	    );
		
Shift_Left_Two_32 Shifter(
        .data_i(signo),
        .data_o(Shifto)
        ); 		
		
MUX_2to1 #(.size(32)) Mux_PC_Source(
        .data0_i(sum_1),
        .data1_i(ADD2o),
        .select_i(bselect),
        .data_o(pc_in)
        );	

endmodule
		  


