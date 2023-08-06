module ALU #(parameter DATA_WIDTH=32, CONTROL_WIDTH=3)(
input  wire  [DATA_WIDTH-1:0] rs1,
input  wire  [DATA_WIDTH-1:0] rs2,
input  wire  [CONTROL_WIDTH-1:0] ALU_FUN,
output reg   [DATA_WIDTH-1:0] rd,
output wire Zero_Flag,
output wire Sign_Flag);
always @(*)
	begin
		case(ALU_FUN)
		'b000:begin
		      rd=rs1+rs2;
		     end	
		'b001:begin
		     rd=rs1<<rs2;
		     end
		'b010:begin
		     rd=rs1-rs2;
		     end
		'b100:begin
			rd=rs1^rs2;
		     end
		'b101:begin
		      rd=rs1>>rs2;
		     end 
		'b110:begin
		      rd=rs1|rs2;
                     end
		'b111:begin
		       rd=rs1&rs2;
                     end
		 default:begin
			 rd='b0;
			 end 
	endcase
        end

assign Zero_Flag= !rd ? 1'b1 : 1'b0;
assign Sign_Flag=  rd[31];
endmodule
