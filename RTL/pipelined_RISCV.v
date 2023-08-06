module pipelined_RISCV #(parameter Data_Width1=5,Data_Width2=32,Data_Width3=28,CONTROL_WIDTH=3) 
(input  wire CLK,
input   wire RST,
input   wire [Data_Width2-1:0] INSTR,
input   wire [Data_Width2-1:0] Read_Data,
output  wire  [Data_Width2-1:0] PC,
output  wire [Data_Width2-1:0] ALU_result,
output  wire [Data_Width2-1:0] Write_Data,
output MemWriteM
);
wire Zero;
wire sign_flag;
wire [1:0] Result_SRC;
wire [1:0] ImmSrc;
wire REG_WRITE;
wire ALU_src;
wire [2:0] ALU_CONTROL;
wire PC_SRC,CLR;
wire [6:0] op_code;
wire [2:0] funct3;
wire funct7;
 control_unit CONTROL_UNIT (.op_code(op_code),.funct3(funct3),.funct7(funct7),.Zero(Zero),.sign_flag(sign_flag),.PCSrc(PC_SRC),
.mem_writeE(MEM_WRITE_WE),.ImmSrc(ImmSrc),.reg_writeE(REG_WRITE),.CLK(CLK),.RST(RST),.ALU_SRCE(ALU_src),.Result_SRCE(Result_SRC),.ALU_controlE(ALU_CONTROL),.CLR(CLR));

data_path #(.data_width1(Data_Width1),.data_width2(Data_Width2),.data_width3(Data_Width3),.CONTROL_WIDTH(CONTROL_WIDTH)) DATA_PATH
(.CLK(CLK),.RST(RST),.instr(INSTR),.PCSrc(PC_SRC),.mem_write(MEM_WRITE_WE),.ImmSrc(ImmSrc),.reg_write(REG_WRITE),.ALU_SRC(ALU_src),
.Result_SRC(Result_SRC),.ALU_control(ALU_CONTROL),.Read_Data(Read_Data),.FlushE(CLR),.zero(Zero),.MemWriteM(MemWriteM),
.sign_flag(sign_flag),.PC(PC),.ALURESULTM(ALU_result),.WriteDataM(Write_Data),.op_code(op_code),
.funct3(funct3),.funct7(funct7));

endmodule
