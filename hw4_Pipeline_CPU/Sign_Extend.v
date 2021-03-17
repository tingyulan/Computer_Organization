//Subject:     CO project 2 - Sign extend
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      0510008 藍挺毓 & 0510026 陳司瑋
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------

module Sign_Extend(
    data_i,
    data_o
    );
               
//I/O ports
input   [16-1:0] data_i;
output  [32-1:0] data_o;

//Internal Signals
reg     [32-1:0] data_o;

//Sign extended
always@(*) begin
    data_o[15:0] <= data_i[15:0];
    if(data_i[15]==1'b1) begin
        data_o[31:16]<=16'b1111111111111111;
    end
    else begin
        data_o[31:16]<=16'b0000000000000000;
    end

end
          
endmodule      
     