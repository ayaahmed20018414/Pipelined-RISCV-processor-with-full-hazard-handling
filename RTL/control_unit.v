module control_unit(input wire [6:0] op_code,
input CLK,
input RST,
input  wire [2:0] funct3,
input  wire funct7,
input  wire Zero,
input  wire sign_flag,
input wire CLR,  
output reg PCSrc,
output reg mem_writeE,
output reg reg_writeE,
output reg ALU_SRCE,
output reg [1:0] Result_SRCE,
output reg [2:0] ALU_controlE,
output [1:0] ImmSrc);
wire [1:0] ALU_OP;
wire BEQ;
wire BNQ;
wire BLT;
wire mem_write,branch,ALU_SRC,reg_write;
reg branchE;
wire [1:0] Result_SRC;
wire [2:0] ALU_control;
reg [2:0] funct3E;
main_decoder MAIN_DECODER(.op_code(op_code), .Result_Src(Result_SRC),.mem_write(mem_write),.branch(branch),
.ImmSrc(ImmSrc),.reg_write(reg_write),.ALU_SRC(ALU_SRC),.ALU_OP(ALU_OP));

ALU_decoder ALU_DECODER(.OP(op_code[5]),.ALU_OP(ALU_OP),.funct3(funct3),.funct7(funct7),.ALU_control(ALU_control));
always @(posedge CLK or negedge RST)
 begin
	if(!RST)
   	 begin
		funct3E<='b0;
	 end
	else
     	 begin
		funct3E<=funct3;
	 end
 end

always@(posedge CLK or negedge RST)
  begin
	if(!RST)
	 begin
		mem_writeE<='b0;
		reg_writeE<='b0;
		ALU_SRCE<='b0;
		Result_SRCE<='b0;
		ALU_controlE<='b0;
		branchE<='b0;
	 end
	else if(CLR)
	 begin
		mem_writeE<='b0;
		reg_writeE<='b0;
		ALU_SRCE<='b0;
		Result_SRCE<='b0;
		ALU_controlE<='b0;
		branchE<='b0;
	 end
	else
	 begin
		mem_writeE<=mem_write;
		reg_writeE<=reg_write;
		ALU_SRCE<=ALU_SRC;
		Result_SRCE<=Result_SRC;
		ALU_controlE<=ALU_control;
		branchE<=branch;
	 end
  end

and_gate gate1 (.IN1(branchE),.IN2(Zero),.OUT(BEQ));
and_gate gate2 (.IN1(branchE),.IN2(!Zero),.OUT(BNQ));
and_gate gate3 (.IN1(branchE),.IN2(sign_flag),.OUT(BLT));
always @(*)
begin
 case(funct3E)
   3'b000:begin
	PCSrc=BEQ;
       end
   3'b001:begin
	PCSrc=BNQ;
       end
   3'b100:begin
	PCSrc=BLT;
       end
   default:begin
	    PCSrc=1'b0;
           end
  endcase
  end
endmodule
