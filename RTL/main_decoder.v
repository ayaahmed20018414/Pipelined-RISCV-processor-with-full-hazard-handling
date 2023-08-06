module main_decoder(input wire [6:0]op_code, 
output reg [1:0] Result_Src,
output reg mem_write,
output reg branch,
output reg [1:0] ImmSrc,
output reg reg_write,
output reg ALU_SRC,
output reg [1:0] ALU_OP);
/*micro processor instruction set ISA*/
always @(*)
begin
case(op_code)
//load word instruction 
7'b000_0011:
begin
Result_Src=2'b01;
ImmSrc=2'b00;
mem_write=1'b0;
branch=1'b0;
reg_write=1'b1;
ALU_SRC=1'b1;
ALU_OP=2'b00;
end
//store word instruction
7'b010_0011:
begin
Result_Src=2'b00;
ImmSrc=2'b01;
mem_write=1'b1;
branch=1'b0;
reg_write=1'b0;
ALU_SRC=1'b1;
ALU_OP=2'b00;
end
// I-type instructions 
7'b001_0011:
begin
Result_Src=2'b00;
ImmSrc=2'b00;
mem_write=1'b0;
branch=1'b0;
reg_write=1'b1;
ALU_SRC=1'b1;
ALU_OP=2'b10;
end
//branch instructions beq,bnq,blt 
7'b110_0011:
begin
Result_Src=2'b00;
ImmSrc=2'b10;
mem_write=1'b0;
branch=1'b1;
reg_write=1'b0;
ALU_SRC=1'b0;
ALU_OP=2'b01;
end
//R_type instructions 
7'b011_0011:
begin
Result_Src=2'b00;
ImmSrc=2'b01;
mem_write=1'b0;
branch=1'b0;
reg_write=1'b1;
ALU_SRC=1'b0;
ALU_OP=2'b10;
end
default:
begin
Result_Src=2'b00;
ImmSrc=2'b00;
mem_write=1'b0;
branch=1'b0;
reg_write=1'b0;
ALU_SRC=1'b0;
ALU_OP=2'b00;
end
endcase
end

endmodule
