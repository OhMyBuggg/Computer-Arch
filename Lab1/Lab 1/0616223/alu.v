// 劉柏宇 0616223
`timescale 1ns/1ps

module alu(
           rst_n,         // negative reset            (input)
           src1,          // 32 bits source 1          (input)
           src2,          // 32 bits source 2          (input)
           ALU_control,   // 4 bits ALU control input  (input)
		 //bonus_control, // 3 bits bonus control input(input) 
           result,        // 32 bits result            (output)
           zero,          // 1 bit when the output is 0, zero must be set (output)
           cout,          // 1 bit carry out           (output)
           overflow       // 1 bit overflow            (output)
           );


input           rst_n;
input  [32-1:0] src1;
input  [32-1:0] src2;
input   [4-1:0] ALU_control;
//input   [3-1:0] bonus_control; 

output [32-1:0] result;
output          zero;
output          cout;
output          overflow;

reg    [32-1:0] result;
reg             zero;
reg             cout;
reg             overflow;

reg            lessr;
reg            A_invertr;
reg            B_invertr;
reg            cinr;
reg   [2-1:0]  opr;
reg            zeror;

wire   [32-1:0] result_t;
wire   [31-1:0] coutr;
wire            cout_t;
wire            overflow_t;
wire            set_t;

while(rst_n)
begin
always@( * ) 
  begin
    case(ALU_control)
      4'b0000: //AND
        begin
          lessr = 1'b0;
          A_invertr = 1'b0;
          B_invertr = 1'b0;
          cinr = 1'b0;
          opr = 2'b00;
          zeror = 1'b0;
          result = result_t;
          overflow = overflow_t;
          cout = cout_t;
          zero = ~(result[0]|result[1]|result[2]|result[3]|result[4]|result[5]|result[6]|result[7]|result[8]|result[9]|result[10]|result[11]|result[12]|result[13]|result[14]|result[15]|result[16]|result[17]|result[18]|result[19]|result[20]|result[21]|result[22]|result[23]|result[24]|result[25]|result[26]|result[27]|result[28]|result[29]|result[30]|result[31]);
        end
      4'b0001: //OR
        begin
          lessr = 1'b0;
          A_invertr = 1'b0;
          B_invertr = 1'b0;
          cinr = 1'b0;
          opr = 2'b01;
          zeror = 1'b0;
          result = result_t;
          overflow = overflow_t;
          cout = cout_t;
          zero = ~(result[0]|result[1]|result[2]|result[3]|result[4]|result[5]|result[6]|result[7]|result[8]|result[9]|result[10]|result[11]|result[12]|result[13]|result[14]|result[15]|result[16]|result[17]|result[18]|result[19]|result[20]|result[21]|result[22]|result[23]|result[24]|result[25]|result[26]|result[27]|result[28]|result[29]|result[30]|result[31]);
        end
      4'b0010: //ADD
        begin
          lessr = 1'b0;
          A_invertr = 1'b0;
          B_invertr = 1'b0;
          cinr = 1'b0;
          opr = 2'b10;
          zeror = 1'b0;
          result = result_t;
          overflow = overflow_t;
          cout = cout_t;
          zero = ~(result[0]|result[1]|result[2]|result[3]|result[4]|result[5]|result[6]|result[7]|result[8]|result[9]|result[10]|result[11]|result[12]|result[13]|result[14]|result[15]|result[16]|result[17]|result[18]|result[19]|result[20]|result[21]|result[22]|result[23]|result[24]|result[25]|result[26]|result[27]|result[28]|result[29]|result[30]|result[31]);
        end
      4'b0110: //SUB
        begin
          lessr = 1'b0;
          A_invertr = 1'b0;
          B_invertr = 1'b1;
          cinr = 1'b1;
          opr = 2'b10;
          zeror = 1'b0;
          result = result_t;
          overflow = overflow_t;
          cout = cout_t;
          zero = ~(result[0]|result[1]|result[2]|result[3]|result[4]|result[5]|result[6]|result[7]|result[8]|result[9]|result[10]|result[11]|result[12]|result[13]|result[14]|result[15]|result[16]|result[17]|result[18]|result[19]|result[20]|result[21]|result[22]|result[23]|result[24]|result[25]|result[26]|result[27]|result[28]|result[29]|result[30]|result[31]);
        end
      4'b1100: //NOR
        begin
          lessr = 1'b0;
          A_invertr = 1'b1;
          B_invertr = 1'b1;
          cinr = 1'b0;
          opr = 2'b00;
          zeror = 1'b0;
          result = result_t;
          overflow = overflow_t;
          cout = cout_t;
          zero = ~(result[0]|result[1]|result[2]|result[3]|result[4]|result[5]|result[6]|result[7]|result[8]|result[9]|result[10]|result[11]|result[12]|result[13]|result[14]|result[15]|result[16]|result[17]|result[18]|result[19]|result[20]|result[21]|result[22]|result[23]|result[24]|result[25]|result[26]|result[27]|result[28]|result[29]|result[30]|result[31]);
        end
      4'b1101: //NAND
        begin
          lessr = 1'b0;
          A_invertr = 1'b1;
          B_invertr = 1'b1;
          cinr = 1'b0;
          opr = 2'b01;
          zeror = 1'b0;
          result = result_t;
          overflow = overflow_t;
          cout = cout_t;
          zero = ~(result[0]|result[1]|result[2]|result[3]|result[4]|result[5]|result[6]|result[7]|result[8]|result[9]|result[10]|result[11]|result[12]|result[13]|result[14]|result[15]|result[16]|result[17]|result[18]|result[19]|result[20]|result[21]|result[22]|result[23]|result[24]|result[25]|result[26]|result[27]|result[28]|result[29]|result[30]|result[31]);
        end
      4'b0111: //SLT
        begin
          lessr = set_t;
          A_invertr = 1'b0;
          B_invertr = 1'b1;
          cinr = 1'b1;
          opr = 2'b11;
          zeror = 1'b0;
          result = result_t;
          overflow = overflow_t;
          cout = cout_t;
          zero = ~(result[0]|result[1]|result[2]|result[3]|result[4]|result[5]|result[6]|result[7]|result[8]|result[9]|result[10]|result[11]|result[12]|result[13]|result[14]|result[15]|result[16]|result[17]|result[18]|result[19]|result[20]|result[21]|result[22]|result[23]|result[24]|result[25]|result[26]|result[27]|result[28]|result[29]|result[30]|result[31]);
        end
    endcase
  end
end

  alu_top M0(src1[0],src2[0],lessr,A_invertr,B_invertr,cinr,opr,result_t[0],coutr[0]);
  alu_top M1(src1[1],src2[1],zeror,A_invertr,B_invertr,coutr[0],opr,result_t[1],coutr[1]);
  alu_top M2(src1[2],src2[2],zeror,A_invertr,B_invertr,coutr[1],opr,result_t[2],coutr[2]);
  alu_top M3(src1[3],src2[3],zeror,A_invertr,B_invertr,coutr[2],opr,result_t[3],coutr[3]);
  alu_top M4(src1[4],src2[4],zeror,A_invertr,B_invertr,coutr[3],opr,result_t[4],coutr[4]);
  alu_top M5(src1[5],src2[5],zeror,A_invertr,B_invertr,coutr[4],opr,result_t[5],coutr[5]);
  alu_top M6(src1[6],src2[6],zeror,A_invertr,B_invertr,coutr[5],opr,result_t[6],coutr[6]);
  alu_top M7(src1[7],src2[7],zeror,A_invertr,B_invertr,coutr[6],opr,result_t[7],coutr[7]);
  alu_top M8(src1[8],src2[8],zeror,A_invertr,B_invertr,coutr[7],opr,result_t[8],coutr[8]);
  alu_top M9(src1[9],src2[9],zeror,A_invertr,B_invertr,coutr[8],opr,result_t[9],coutr[9]);
  alu_top M10(src1[10],src2[10],zeror,A_invertr,B_invertr,coutr[9],opr,result_t[10],coutr[10]);
  alu_top M11(src1[11],src2[11],zeror,A_invertr,B_invertr,coutr[10],opr,result_t[11],coutr[11]);
  alu_top M12(src1[12],src2[12],zeror,A_invertr,B_invertr,coutr[11],opr,result_t[12],coutr[12]);
  alu_top M13(src1[13],src2[13],zeror,A_invertr,B_invertr,coutr[12],opr,result_t[13],coutr[13]);
  alu_top M14(src1[14],src2[14],zeror,A_invertr,B_invertr,coutr[13],opr,result_t[14],coutr[14]);
  alu_top M15(src1[15],src2[15],zeror,A_invertr,B_invertr,coutr[14],opr,result_t[15],coutr[15]);
  alu_top M16(src1[16],src2[16],zeror,A_invertr,B_invertr,coutr[15],opr,result_t[16],coutr[16]);
  alu_top M17(src1[17],src2[17],zeror,A_invertr,B_invertr,coutr[16],opr,result_t[17],coutr[17]);
  alu_top M18(src1[18],src2[18],zeror,A_invertr,B_invertr,coutr[17],opr,result_t[18],coutr[18]);
  alu_top M19(src1[19],src2[19],zeror,A_invertr,B_invertr,coutr[18],opr,result_t[19],coutr[19]);
  alu_top M20(src1[20],src2[20],zeror,A_invertr,B_invertr,coutr[19],opr,result_t[20],coutr[20]);
  alu_top M21(src1[21],src2[21],zeror,A_invertr,B_invertr,coutr[20],opr,result_t[21],coutr[21]);
  alu_top M22(src1[22],src2[22],zeror,A_invertr,B_invertr,coutr[21],opr,result_t[22],coutr[22]);
  alu_top M23(src1[23],src2[23],zeror,A_invertr,B_invertr,coutr[22],opr,result_t[23],coutr[23]);
  alu_top M24(src1[24],src2[24],zeror,A_invertr,B_invertr,coutr[23],opr,result_t[24],coutr[24]);
  alu_top M25(src1[25],src2[25],zeror,A_invertr,B_invertr,coutr[24],opr,result_t[25],coutr[25]);
  alu_top M26(src1[26],src2[26],zeror,A_invertr,B_invertr,coutr[25],opr,result_t[26],coutr[26]);
  alu_top M27(src1[27],src2[27],zeror,A_invertr,B_invertr,coutr[26],opr,result_t[27],coutr[27]);
  alu_top M28(src1[28],src2[28],zeror,A_invertr,B_invertr,coutr[27],opr,result_t[28],coutr[28]);
  alu_top M29(src1[29],src2[29],zeror,A_invertr,B_invertr,coutr[28],opr,result_t[29],coutr[29]);
  alu_top M30(src1[30],src2[30],zeror,A_invertr,B_invertr,coutr[29],opr,result_t[30],coutr[30]);
  alu_bottom M31(src1[31],src2[31],zeror,A_invertr,B_invertr,coutr[30],opr,result_t[31],cout_t,overflow_t,set_t);

endmodule

