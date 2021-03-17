//Subject:     CO project 2 - Simple Single CPU
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      0510008 藍挺毓 & 0510026 陳司瑋
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------
module Simple_Single_CPU(
        clk_i,
		rst_i
		);
		
//I/O port
input         clk_i;
input         rst_i;

wire[31:0] pc_in_i, pc_out_o;
wire[31:0] adder1_o, shift_two_o, adder2_o;
wire branch, zero;
wire[31:0] instruction, Write_data,RSdata_o,RTdata_o;
wire RegWrite_o, ALUSrc_o, RegDst_o;
wire [3-1:0] ALU_op;
wire[5-1:0] RDaddr_i;
wire [3:0] ALUCtrl_o;
wire[31:0] extend, ALU_src2;
//Internal Signles
reg [3:0]counta;
reg [32-1:0]add_four;
wire [32-1:0] w_add_four;
reg [31:0] pc_input;
//wire [31:0] after_addr_mux;

assign w_add_four = add_four;
//assign pc_in_i = pc_input;

always@(posedge clk_i) begin
    if(~rst_i) begin
        counta<=0;
        pc_input <= 32'b0;
    end
    else begin
        if(counta==4) counta<=0;
        else counta<=counta+1;
        
        if(counta==0) add_four <=32'd4;
        else add_four<=32'b0;
        
       // pc_input<=after_addr_mux;
    end
    
end


//Greate componentes
ProgramCounter PC(
        .clk_i(clk_i),      
	    .rst_i (rst_i),     
	    .pc_in_i(pc_in_i) ,   
	    .pc_out_o(pc_out_o) 
	    );
	    
	    
Adder Adder1(
        .src1_i(pc_out_o),     
	    .src2_i(32'd4),     
	    .sum_o(adder1_o)    
	    );
	
Instr_Memory IM(
        .pc_addr_i(pc_out_o),  
	    .instr_o(instruction)    
	    );

MUX_2to1 #(.size(5)) Mux_Write_Reg(
        .data0_i(instruction[20:16]),
        .data1_i(instruction[15:11]),
        .select_i(RegDst_o),
        .data_o(RDaddr_i)
        );	
		
Reg_File RF(
        .clk_i(clk_i),      
	    .rst_i(rst_i) ,     
        .RSaddr_i(instruction[25:21]) ,  
        .RTaddr_i(instruction[20:16]) ,  
        .RDaddr_i(RDaddr_i) ,  
        .RDdata_i(Write_data)  , //Write Data
        .RegWrite_i (RegWrite_o), //control
        .RSdata_o(RSdata_o) ,  
        .RTdata_o(RTdata_o)   
        );
	

	
Decoder Decoder(
        .instr_op_i(instruction[31:26]), 
	    .RegWrite_o(RegWrite_o), 
	    .ALU_op_o(ALU_op),   
	    .ALUSrc_o(ALUSrc_o),   
	    .RegDst_o(RegDst_o),   
		.Branch_o(branch)   
	    );

ALU_Ctrl AC(
        .funct_i(instruction[5:0]),   
        .ALUOp_i(ALU_op),   
        .ALUCtrl_o(ALUCtrl_o) 
        );
	
Sign_Extend SE(
        .data_i(instruction[15:0]),
        .data_o(extend)
        );

MUX_2to1 #(.size(32)) Mux_ALUSrc(
        .data0_i(RTdata_o),
        .data1_i(extend),
        .select_i(ALUSrc_o),
        .data_o(ALU_src2)
        );	
		
ALU ALU(
        .src1_i(RSdata_o),
	    .src2_i(ALU_src2),
	    .ctrl_i(ALUCtrl_o),
	    .result_o(Write_data),
		.zero_o(zero)
	    );
		
Adder Adder2(
        .src1_i(adder1_o),     
	    .src2_i(shift_two_o),     
	    .sum_o(adder2_o)      
	    );
		
Shift_Left_Two_32 Shifter(
        .data_i(extend),
        .data_o(shift_two_o)
        ); 		
		
MUX_2to1 #(.size(32)) Mux_PC_Source(
        .data0_i(adder1_o),
        .data1_i(adder2_o),
        .select_i(branch & zero),
        .data_o(pc_in_i)
        );	

endmodule
		  


