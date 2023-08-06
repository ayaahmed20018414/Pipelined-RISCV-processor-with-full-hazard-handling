module ALU_decoder(
input wire  OP,
input wire [1:0] ALU_OP,
input wire [2:0] funct3,
input wire funct7,
output reg [2:0] ALU_control);
always @(*)
begin
case(ALU_OP)
2'b00:
begin
	ALU_control=3'b000; //for load and store instructions 
end
2'b01:             //for branch instructions beq and bnq
begin
  case(funct3)
   	3'b000:begin
			   ALU_control=3'b010; //subtract
		   end
	3'b001:begin
			   ALU_control=3'b010; //subtract
		    end
	3'b100:begin
			   ALU_control=3'b010; //less than
	       end
	endcase		 
	
end
2'b10:
begin
 case(funct3)
 3'b000: 
 begin
  if({OP,funct7}==2'b11)
    begin
   	ALU_control=3'b010;
    end
   else
    begin
		ALU_control=3'b000;
    end
 end
 3'b110:
 begin
 ALU_control=3'b110;
 end
 3'b111:
 begin
 ALU_control=3'b111;
 end
 3'b001:
 begin
 ALU_control=3'b001;
 end
 3'b100:
 begin
 ALU_control=3'b100;
 end
 3'b101:
 begin
 ALU_control=3'b101;
 end
endcase
end
default:
begin
ALU_control=3'b000;
end
endcase
end
endmodule
