
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      0510008 藍挺毓 & 0510026 陳司瑋
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------

module ALU(
    src1_i,
    src2_i,
    ctrl_i,
    result_o,
    zero_o
    );
     
//I/O ports
input  [32-1:0]  src1_i;
input  [32-1:0]  src2_i;
input  [4-1:0]   ctrl_i;

output [32-1:0]  result_o;
output           zero_o;

//Internal signals
reg    [32-1:0]  result_o;
wire             zero_o;

//Parameter
assign zero_o = (result_o==0);
always @(ctrl_i, src1_i, src2_i) begin
    case (ctrl_i)
        0: result_o<=src1_i&src2_i;
        1: result_o<= src1_i | src2_i;
        2: result_o<=src1_i + src2_i;
        6: result_o<=src1_i - src2_i;
        7: result_o<=( $signed (src1_i) < $signed(src2_i)) ? 32'd1:32'd0 ;
        8: result_o<= src1_i*src2_i ;
        12: result_o<= ~(src1_i | src2_i);
        default: result_o<=0;
    endcase
end

//Main function

endmodule





                    
                    