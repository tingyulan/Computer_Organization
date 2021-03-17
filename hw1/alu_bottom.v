`timescale 1ns/1ps

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:58:01 10/10/2013
// Design Name: 
// Module Name:    alu_top 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

module alu_bottom(
               src1,       //1 bit source 1 (input)
               src2,       //1 bit source 2 (input)
               less,       //1 bit less     (input)
               A_invert,   //1 bit A_invert (input)
               B_invert,   //1 bit B_invert (input)
               cin,        //1 bit carry in (input)
               operation,  //operation      (input)
               result,     //1 bit result   (output)
               cout,    //1 bit carry out(output)
               overflow,
               set    
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
output          set;

reg           result;
wire	src1_temp, src2_temp;
wire	or_temp,and_temp;
wire 	temp1,temp2,sum;


xor a_invert(src1_temp,A_invert,src1);
xor b_invert(src2_temp,B_invert,src2);
and ANDgate(and_temp,src1_temp,src2_temp);
or  ORgate(or_temp,src1_temp,src2_temp);

//fulladder
xor AxorB(temp1,src1_temp,src2_temp);
xor xorcin(sum,temp1,cin);//cinxorAxorB
and cout_step1(temp2,temp1,cin);
or  carryout(cout,temp2,and_temp);//carry_out

//

wire n_src1_temp, n_src2_temp;
wire n_sum;
wire v0,v1,v2; 
not (n_src1_temp,src1_temp);
not (n_src2_temp,src2_temp);
not (n_sum,sum);
and (v0,n_src1_temp,n_src2_temp);//A' & B'
and (v1,v0,sum);//A' & B' & C
and (v2,and_temp,n_sum);//A & B & C'
or  (overflow,v2,v1);//case1 or case2 

//wire set;

reg s_temp;
assign set =s_temp;
always@(*)begin
	if(overflow)
		s_temp = (sum)?1'b0:1'b1;
	else s_temp = sum;
end
//assign set=sum;





always@(*)begin
	case(operation)
	2'b00:result = and_temp;
	2'b01:result = or_temp;
	2'b10:result = sum;
	2'b11:result = less;
	endcase

end

endmodule
