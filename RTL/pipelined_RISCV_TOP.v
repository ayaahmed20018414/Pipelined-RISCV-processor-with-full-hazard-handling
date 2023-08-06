module pipelined_RISCV_TOP #(parameter Data_Width1=5,Data_Width2=32,Data_Width3=28,CONTROL_WIDTH=3) 
(input  CLK,
input  RESET,
output [Data_Width2-1:0] test_value);
wire [Data_Width2-1:0] Read_Data;
wire [Data_Width2-1:0] Instruction;
wire [Data_Width2-1:0] Program_Counter;
wire [Data_Width2-1:0] ALU_RESULT;
wire [Data_Width2-1:0] WRITE_DATA;
wire MEM_WE;

pipelined_RISCV #(.Data_Width1(Data_Width1),.Data_Width2(Data_Width2),.Data_Width3(Data_Width3),.CONTROL_WIDTH(CONTROL_WIDTH)) RISCV1
(.CLK(CLK),.RST(RESET),.INSTR(Instruction),.PC(Program_Counter),.ALU_result(ALU_RESULT),
.Write_Data(WRITE_DATA),.MemWriteM(MEM_WE),.Read_Data(Read_Data));

inst_mem INSTRUCTION_MEMORY(.Add_PC(Program_Counter),.inst(Instruction));

data_mem DATA_MEMORY (.clk(CLK),.mem_WE(MEM_WE),.mem_WD(WRITE_DATA),.mem_Address(ALU_RESULT),.reset(RESET),
.mem_RD(Read_Data),.test_value(test_value));

endmodule
