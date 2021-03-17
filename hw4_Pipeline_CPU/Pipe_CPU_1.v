`timescale 1ns / 1ps
//Subject:     CO project 4 - Pipe CPU 1
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      0510008 藍挺毓 & 0510026 陳司瑋
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------
module Pipe_CPU_1(
    clk_i,
    rst_i
    );
    
/****************************************
I/O ports
****************************************/
input clk_i;
input rst_i;
wire [31:0] adder1_o,instr_mem,Mux0_o,Mux3_o,Mux1_o;
wire [63:0] IF_ID_o;
wire Regwrite,MemtoReg,branch,Memread,Memwrite,RegDst,ALUSrc,zero;
wire [2:0]ALUOp;
wire[31:0] read_data1_o,read_data2_o,extend;
wire[147:0]ID_EX_o;
wire[31:0]result1_o,result2_o;
wire[4:0]Mux2_o;
wire[106:0]EX_MEM_o;
wire [31:0]Datamem_o;
wire [70:0]MEM_WB_o;
wire [31:0]pc_out_o,pc_in_i,shift_o;
wire [3:0]ALU_ctrl;



/****************************************
Internal signal
****************************************/
/**** IF stage ****/

/**** ID stage ****/

//control signal


/**** EX stage ****/

//control signal


/**** MEM stage ****/

//control signal


/**** WB stage ****/

//control signal


/****************************************
Instantiate modules
****************************************/
//Instantiate the components in IF stage

MUX_2to1 #(.size(32)) Mux0(
               .data0_i(adder1_o),
               .data1_i(EX_MEM_o[101:70]),
               .select_i(EX_MEM_o[105]&EX_MEM_o[69]),
               .data_o(Mux0_o)

);

ProgramCounter PC(
  .clk_i(clk_i),
  .rst_i(rst_i),
  .pc_in_i(Mux0_o),
  .pc_out_o(pc_out_o)

);

Instruction_Memory IM(
  .addr_i(pc_out_o),
  .instr_o(instr_mem)

);
			
Adder Add_pc(
  .src1_i(pc_out_o),
  .src2_i(32'd4),
  .sum_o(adder1_o)

);

		
Pipe_Reg #(.size(64))IF_ID(     
  .clk_i(clk_i),
  .rst_i(rst_i),
  .data_i({adder1_o,instr_mem}),
  .data_o(IF_ID_o)//N is the total length of input/output


);


//Instantiate the components in ID stage
Reg_File RF(
    .clk_i(clk_i),
    .rst_i(rst_i),
    .RSaddr_i(IF_ID_o[25:21]),
    .RTaddr_i(IF_ID_o[20:16]),
    .RDaddr_i(MEM_WB_o[4:0]),
    .RDdata_i(Mux3_o),
    .RegWrite_i(MEM_WB_o[70]),
    .RSdata_o(read_data1_o),
    .RTdata_o(read_data2_o)

);

Decoder DecoderA(
   .instr_op_i(IF_ID_o[31:26]), 
   .RegWrite_o(Regwrite), 
   .ALU_op_o(ALUOp),   
   .ALUSrc_o(ALUSrc),   
   .RegDst_o(RegDst),   
   .Branch_o(branch),
   .MemRead_o(Memread),
   .MemWrite_o(Memwrite),
   .MemtoReg_o(MemtoReg)   
);

Sign_Extend Sign_Extend(
  .data_i(IF_ID_o[15:0]),
  .data_o(extend)
);	

Pipe_Reg #(.size(148) )ID_EX(     
  .clk_i(clk_i),
  .rst_i(rst_i),
  .data_i({Regwrite,MemtoReg,branch,Memread,Memwrite,RegDst,ALUOp,ALUSrc,IF_ID_o[63:32],read_data1_o,read_data2_o,extend,IF_ID_o[20:11]}),
  .data_o(ID_EX_o)//N is the total length of input/output


);


//Instantiate the components in EX stage	   
Shift_Left_Two_32 Shifter(
  .data_i(ID_EX_o[41:10]),
  .data_o(shift_o)

);

ALU ALU(
  .src1_i(ID_EX_o[105:74]),
  .src2_i(Mux1_o),
  .ctrl_i(ALU_ctrl),
  .result_o(result2_o),
  .zero_o(zero)

);
		
ALU_Control ALU_Control(
  .funct_i(ID_EX_o[15:10]),
  .ALUOp_i(ID_EX_o[141:139]),
  .ALUCtrl_o(ALU_ctrl)
);

MUX_2to1 #(.size(32)) Mux1(
  .data0_i(ID_EX_o[73:42]),
  .data1_i(ID_EX_o[41:10]),
  .select_i(ID_EX_o[138]),
  .data_o(Mux1_o)


);
		
MUX_2to1 #(.size(5)) Mux2(
  .data0_i(ID_EX_o[9:5]),
  .data1_i(ID_EX_o[4:0]),
  .select_i(ID_EX_o[142]),
  .data_o(Mux2_o)

);

Adder Add_pc_branch(
  .src1_i(ID_EX_o[137:106]),
  .src2_i(shift_o),
  .sum_o(result1_o)
   
);

Pipe_Reg #(.size(107)) EX_MEM(
 .clk_i(clk_i),
 .rst_i(rst_i),
 .data_i({ID_EX_o[147:143],result1_o,zero,result2_o,ID_EX_o[73:42],Mux2_o}),
 .data_o(EX_MEM_o)//N is the total length of input/output
);


//Instantiate the components in MEM stage
Data_Memory DM(
  .clk_i(clk_i),
  .addr_i(EX_MEM_o[68:37]),
  .data_i(EX_MEM_o[36:5]),
  .MemRead_i(EX_MEM_o[103]),
  .MemWrite_i(EX_MEM_o[102]),
  .data_o(Datamem_o)

);

Pipe_Reg #(.size(71) )MEM_WB(
 .clk_i(clk_i),
 .rst_i(rst_i),
 .data_i({EX_MEM_o[106:105],Datamem_o,EX_MEM_o[68:37],EX_MEM_o[4:0]}),
 .data_o(MEM_WB_o)//N is the total length of input/output

);


//Instantiate the components in WB stage
MUX_2to1 #(.size(32)) Mux3(
  .data0_i(MEM_WB_o[68:37]),
  .data1_i(MEM_WB_o[36:5]),
  .select_i(MEM_WB_o[69]),
  .data_o(Mux3_o)

);

/****************************************
signal assignment
****************************************/

endmodule

