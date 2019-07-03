//Subject:     CO project 3 - Simple Single CPU
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      0616223 0616059
//----------------------------------------------
//Date:        5/20	
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
wire [1:0] RegDst;
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
assign signi = instr[15:0];
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

wire [25:0] Jtarget26;
assign Jtarget26 = instr[25:0];
wire [27:0] Jtarget28;
wire [31:0] Jtarget;
assign Jtarget[31:28] = sum_1[31:28];
assign Jtarget[27:0] = Jtarget28[27:0];
wire [31:0] originPC;
wire Jump;
wire MemRead;
wire MemWrite;
wire [1:0] MemtoReg;
wire [31:0] Readdata;
wire [31:0] wb;
wire [31:0] pc_in2;
wire Jr;
wire [5:0] defunct;
assign defunct = instr[5:0];

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
	    .pc_in_i(pc_in2) ,   
	    .pc_out_o(pc_out) 
	    );
	
Adder Adder1(
        .src1_i(32'd4),     
	    .src2_i(pc_out),     
	    .sum_o(sum_1)    
	    );
	
Instruction_Memory IM(
        .addr_i(pc_out),  
	    .instr_o(instr)    
	    );

MUX_4to1 #(.size(5)) Mux_Write_Reg(
        .data0_i(RTadd),
        .data1_i(muxRD),
        .data2_i(5'b11111),
        .data3_i(),
        .select_i(RegDst),
        .data_o(RDadd)
        );	
		
Reg_File RF(
        .clk_i(clk_i),      
	    .rst_i(rst_i) ,     
        .RSaddr_i(RSadd) ,  
        .RTaddr_i(RTadd) ,  
        .RDaddr_i(RDadd) ,  
        .RDdata_i(wb), 
        .RegWrite_i (RegWrite),
        .RSdata_o(RSdata) ,  
        .RTdata_o(RTdata)   
        );
	
Decoder Decoder(
        .instr_op_i(instr_op),
        .instr_fun_i(defunct), 
	    .RegWrite_o(RegWrite), 
	    .ALU_op_o(ALUOp),   
	    .ALUSrc_o(ALUsrc),   
	    .RegDst_o(RegDst),   
		.Branch_o(Branch),
                .Jump_o(Jump),
                .MemRead_o(MemRead),
                .MemWrite_o(MemWrite),
                .MemtoReg_o(MemtoReg)   
	    );

ALU_Ctrl AC(
        .funct_i(funct),   
        .ALUOp_i(ALUOp),   
        .ALUCtrl_o(ALUCtrl),
        .Jr_o(Jr) 
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
        .data_o(originPC)
        );	

Shift_Left_Two_28 Shifter2(
        .data_i(Jtarget26),
        .data_o(Jtarget28)
        );

MUX_2to1 #(.size(32)) Mux_PC_Source2(
        .data0_i(originPC),
        .data1_i(Jtarget),
        .select_i(Jump),
        .data_o(pc_in)
        );

Data_Memory Data_Memory(
        .clk_i(clk_i),
        .addr_i(ALUResult),
        .data_i(RTdata),
        .MemRead_i(MemRead),
        .MemWrite_i(MemWrite),
        .data_o(Readdata)
        );

MUX_4to1 #(.size(32)) WriteBack(
        .data0_i(ALUResult),
        .data1_i(Readdata),
        .data2_i(signo),
        .data3_i(sum_1),
        .select_i(MemtoReg),
        .data_o(wb)
        );

MUX_2to1 #(.size(32)) Mux_PC_Source3(
        .data0_i(pc_in),
        .data1_i(wb),
        .select_i(Jr),
        .data_o(pc_in2)
        );

endmodule
		  


