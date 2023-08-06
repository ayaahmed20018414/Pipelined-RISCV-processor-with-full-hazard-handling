module MUX_4x1 #(parameter data_width = 32)(
input [data_width-1:0] in0,
input [data_width-1:0] in1,
input [data_width-1:0] in2,
input [data_width-1:0] in3,
input [1:0] sel,
output reg [data_width-1:0] out);
 always @(*)
  begin
   case(sel)
    2'b00:begin
		out=in0;
	  end
    2'b01:begin
		out=in1;
	  end
    2'b10:begin
		out=in2;	
	  end
    2'b11:begin
		out=in3;	
	  end
    default:begin
		out='b0;
	  end
    endcase
  end











endmodule 
