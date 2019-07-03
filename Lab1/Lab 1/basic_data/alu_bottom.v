// 劉柏宇 0616223
`timescale 1ns/1ps

module alu_bottom(
               src1,       //1 bit source 1 (input)
               src2,       //1 bit source 2 (input)
               less,       //1 bit less     (input)
               A_invert,   //1 bit A_invert (input)
               B_invert,   //1 bit B_invert (input)
               cin,        //1 bit carry in (input)
               operation,  //operation      (input)
               result,     //1 bit result   (output)
               cout,       //1 bit carry out(output)
               overflow,   //1 bit for overflow(output)
               set        //1 bit for set  (output)
               );

input         src1;
input         src2;
input         less;
input         A_invert;
input         B_invert;
input         cin;
input [2-1:0] operation;

output        result;
output        cout;
output        overflow;
output        set;

reg           result;
reg           cout;
reg           overflow;
reg           set;
reg           a1, b1;

always@( * )
begin
  case(A_invert)
  1'b1: a1 = ~src1;
  default: a1 = src1;
  endcase

  case(B_invert)
  1'b1: b1 = ~src2;
  default: b1 = src2;
  endcase

  case(operation)
  2'b00:
  begin
    result = a1&b1;
    cout = 1'b0;
    overflow = 1'b0;
    set = 1'b0;
  end
  2'b01:
  begin
    result = a1|b1;
    cout = 1'b0;
    overflow = 1'b0;
    set = 1'b0;
  end
  2'b10:
  begin
    result = (a1^b1)^cin;
    cout = (a1&b1)|(a1&cin)|(b1&cin);
    overflow = cout^cin;
    set = result;
  end
  2'b11:
  begin
    result = less;
    cout = 1'b0;
    overflow = 1'b0;
    set = 1'b0;
  end
  endcase


end

endmodule
