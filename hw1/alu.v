`timescale 1ns/1ps

//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    15:15:11 08/18/2013
// Design Name:
// Module Name:    alu
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

module alu(
           clk,           // system clock              (input)
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

input           clk;
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
reg          cout;
reg             overflow;

wire [31:0] w_result;
wire w_cout;
wire zzeerroo;
wire [31:0]carry_temp;
wire set;

assign zzeerroo=1'b0; // set a zero wire

reg cin_lastbit;
wire w_cin_lastbit;
wire w_overflow;
//determine the first cin is 0 or 1
//we have to set it 1 if it is sub or slt operation
assign w_cin_lastbit = (ALU_control==4'b0110 || ALU_control==4'b0111) ? 1: 0 ; 

//connect 32 1-bit ALU to become a 32-bit  ALU
alu_top m0(.src1(src1[0]), .src2(src2[0]), .less(set), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(w_cin_lastbit), .operation(ALU_control[1:0]), .result(w_result[0]), .cout(carry_temp[0]) );
alu_top m1(.src1(src1[1]), .src2(src2[1]), .less(zzeerroo), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(carry_temp[0]), .operation(ALU_control[1:0]), .result(w_result[1]), .cout(carry_temp[1]) );
alu_top m2(.src1(src1[2]), .src2(src2[2]), .less(zzeerroo), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(carry_temp[1]), .operation(ALU_control[1:0]), .result(w_result[2]), .cout(carry_temp[2]) );
alu_top m3(.src1(src1[3]), .src2(src2[3]), .less(zzeerroo), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(carry_temp[2]), .operation(ALU_control[1:0]), .result(w_result[3]), .cout(carry_temp[3]) );
alu_top m4(.src1(src1[4]), .src2(src2[4]), .less(zzeerroo), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(carry_temp[3]), .operation(ALU_control[1:0]), .result(w_result[4]), .cout(carry_temp[4]) );
alu_top m5(.src1(src1[5]), .src2(src2[5]), .less(zzeerroo), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(carry_temp[4]), .operation(ALU_control[1:0]), .result(w_result[5]), .cout(carry_temp[5]) );
alu_top m6(.src1(src1[6]), .src2(src2[6]), .less(zzeerroo), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(carry_temp[5]), .operation(ALU_control[1:0]), .result(w_result[6]), .cout(carry_temp[6]) );
alu_top m7(.src1(src1[7]), .src2(src2[7]), .less(zzeerroo), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(carry_temp[6]), .operation(ALU_control[1:0]), .result(w_result[7]), .cout(carry_temp[7]) );
alu_top m8(.src1(src1[8]), .src2(src2[8]), .less(zzeerroo), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(carry_temp[7]), .operation(ALU_control[1:0]), .result(w_result[8]), .cout(carry_temp[8]) );
alu_top m9(.src1(src1[9]), .src2(src2[9]), .less(zzeerroo), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(carry_temp[8]), .operation(ALU_control[1:0]), .result(w_result[9]), .cout(carry_temp[9]) );
alu_top m10(.src1(src1[10]), .src2(src2[10]), .less(zzeerroo), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(carry_temp[9]), .operation(ALU_control[1:0]), .result(w_result[10]), .cout(carry_temp[10]) );
alu_top m11(.src1(src1[11]), .src2(src2[11]), .less(zzeerroo), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(carry_temp[10]), .operation(ALU_control[1:0]), .result(w_result[11]), .cout(carry_temp[11]) );
alu_top m12(.src1(src1[12]), .src2(src2[12]), .less(zzeerroo), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(carry_temp[11]), .operation(ALU_control[1:0]), .result(w_result[12]), .cout(carry_temp[12]) );
alu_top m13(.src1(src1[13]), .src2(src2[13]), .less(zzeerroo), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(carry_temp[12]), .operation(ALU_control[1:0]), .result(w_result[13]), .cout(carry_temp[13]) );
alu_top m14(.src1(src1[14]), .src2(src2[14]), .less(zzeerroo), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(carry_temp[13]), .operation(ALU_control[1:0]), .result(w_result[14]), .cout(carry_temp[14]) );
alu_top m15(.src1(src1[15]), .src2(src2[15]), .less(zzeerroo), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(carry_temp[14]), .operation(ALU_control[1:0]), .result(w_result[15]), .cout(carry_temp[15]) );
alu_top m16(.src1(src1[16]), .src2(src2[16]), .less(zzeerroo), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(carry_temp[15]), .operation(ALU_control[1:0]), .result(w_result[16]), .cout(carry_temp[16]) );
alu_top m17(.src1(src1[17]), .src2(src2[17]), .less(zzeerroo), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(carry_temp[16]), .operation(ALU_control[1:0]), .result(w_result[17]), .cout(carry_temp[17]) );
alu_top m18(.src1(src1[18]), .src2(src2[18]), .less(zzeerroo), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(carry_temp[17]), .operation(ALU_control[1:0]), .result(w_result[18]), .cout(carry_temp[18]) );
alu_top m19(.src1(src1[19]), .src2(src2[19]), .less(zzeerroo), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(carry_temp[18]), .operation(ALU_control[1:0]), .result(w_result[19]), .cout(carry_temp[19]) );
alu_top m20(.src1(src1[20]), .src2(src2[20]), .less(zzeerroo), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(carry_temp[19]), .operation(ALU_control[1:0]), .result(w_result[20]), .cout(carry_temp[20]) );
alu_top m21(.src1(src1[21]), .src2(src2[21]), .less(zzeerroo), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(carry_temp[20]), .operation(ALU_control[1:0]), .result(w_result[21]), .cout(carry_temp[21]) );
alu_top m22(.src1(src1[22]), .src2(src2[22]), .less(zzeerroo), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(carry_temp[21]), .operation(ALU_control[1:0]), .result(w_result[22]), .cout(carry_temp[22]) );
alu_top m23(.src1(src1[23]), .src2(src2[23]), .less(zzeerroo), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(carry_temp[22]), .operation(ALU_control[1:0]), .result(w_result[23]), .cout(carry_temp[23]) );
alu_top m24(.src1(src1[24]), .src2(src2[24]), .less(zzeerroo), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(carry_temp[23]), .operation(ALU_control[1:0]), .result(w_result[24]), .cout(carry_temp[24]) );
alu_top m25(.src1(src1[25]), .src2(src2[25]), .less(zzeerroo), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(carry_temp[24]), .operation(ALU_control[1:0]), .result(w_result[25]), .cout(carry_temp[25]) );
alu_top m26(.src1(src1[26]), .src2(src2[26]), .less(zzeerroo), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(carry_temp[25]), .operation(ALU_control[1:0]), .result(w_result[26]), .cout(carry_temp[26]) );
alu_top m27(.src1(src1[27]), .src2(src2[27]), .less(zzeerroo), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(carry_temp[26]), .operation(ALU_control[1:0]), .result(w_result[27]), .cout(carry_temp[27]) );
alu_top m28(.src1(src1[28]), .src2(src2[28]), .less(zzeerroo), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(carry_temp[27]), .operation(ALU_control[1:0]), .result(w_result[28]), .cout(carry_temp[28]) );
alu_top m29(.src1(src1[29]), .src2(src2[29]), .less(zzeerroo), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(carry_temp[28]), .operation(ALU_control[1:0]), .result(w_result[29]), .cout(carry_temp[29]) );
alu_top m30(.src1(src1[30]), .src2(src2[30]), .less(zzeerroo), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(carry_temp[29]), .operation(ALU_control[1:0]), .result(w_result[30]), .cout(carry_temp[30]) );

alu_bottom m31(.src1(src1[31]), .src2(src2[31]), .less(zzeerroo), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(carry_temp[30]), .operation(ALU_control[1:0]), .result(w_result[31]), .cout(w_cout), .overflow(w_overflow), .set(set));


reg overflow_temp;

always@( posedge clk or negedge rst_n ) 
begin
	if(!rst_n) begin
        result = 32'b0;
        zero = 0;
       // overflow=0;
        cout=0;
	end
	else begin 
	
        result = w_result; 
        
        //set cout if there is caryout in add or sub
        if(ALU_control== 4'b0010||ALU_control==4'b0110) cout = w_cout;
        else cout=1'b0;
        
        //set zero=0 if the result is zero
        if(result==32'b0) zero<=1;
        else zero<=0;
        
        overflow=w_overflow;
        //set overflow =1 if add or sub operation has overflow happened
       /* if((ALU_control==4'b0010||ALU_control==4'b0110) && src1[31]==src2[31] && result[31]!= src1[31]) overflow<=1;
        else overflow<=0;*/
	end
end

endmodule
