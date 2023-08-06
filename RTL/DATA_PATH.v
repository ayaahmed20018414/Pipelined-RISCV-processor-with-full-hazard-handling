module data_path #(parameter data_width1=5,data_width2=32,data_width3=28,CONTROL_WIDTH=3)
(input wire CLK,
input  wire RST,
input  wire [data_width2-1:0] instr,
input  wire PCSrc,
input  wire mem_write,
input  wire [1:0]ImmSrc,
input  wire reg_write,
input  wire ALU_SRC,
input  wire [1:0] Result_SRC,
input  wire [2:0] ALU_control,
input  wire [data_width2-1:0] Read_Data,
output  wire FlushE,
output wire zero,
output wire MemWriteM,
output wire sign_flag,
output wire [data_width2-1:0] PC,
output wire [data_width2-1:0] ALURESULTM,
output wire [data_width2-1:0] WriteDataM, 
output [6:0] op_code,
output [2:0] funct3,
output  funct7);
wire [data_width2-1:0] SRC_A,SRC_B,RD1,RD2,ReadDataW,PCE,RD1E,RD2E,ALU_OUT,PCPLUS4E;
wire [data_width2-1:0] ImmExt,WriteDataE,IMMEXTE;
wire [data_width1-1:0] RdM,RdW,Rs1E,Rs2E,RdE;
wire [data_width2-1:0] PC_PLUS4,PCPlus4W,PCPlus4D,INST_D,PCD;
wire [data_width2-1:0] PC_Target;
wire [data_width2-1:0] PCNext,PCPlus4M;
wire [data_width2-1:0] Result;
wire [data_width2-1:0] ALUResultW;
wire RegWriteW,RegWriteM;
wire [1:0] ForwardAE,ForwardBE,ResultSrcM,ResultSrcW;
wire StallF,StallD,FlushD;


/*************************************/
assign op_code=INST_D[6:0];
assign funct3=INST_D[14:12];
assign funct7=INST_D[30];
/**************************ALU  MUX**********************/

MUX #(.data_width(data_width2)) MUX3 (.in1(WriteDataE),.in2(IMMEXTE),.sel(ALU_SRC),.out(SRC_B));

/*************************sign extend Block*************************/

sign_extend SIGN_EXTEND (.Instr(INST_D[31:7]),.ImmSrc(ImmSrc),.Imm_Ext(ImmExt));

/**************************ALU module**********************/

ALU #(.DATA_WIDTH(data_width2),.CONTROL_WIDTH(CONTROL_WIDTH)) ALU1 (.rs1(SRC_A),.rs2(SRC_B),.ALU_FUN(ALU_control),.rd(ALU_OUT),
.Zero_Flag(zero),.Sign_Flag(sign_flag));



/**************************1st ADDER(1st shifter output is input to it) **********************/

simple_Adder Adder1(.A(PCE),.B(IMMEXTE),.C(PC_Target));


/**************************2nd ADER (program counter plus 4)**********************/

simple_Adder Adder2(.A(PC),.B(32'd4),.C(PC_PLUS4));


/**************************Program Counter**********************/

program_counter PROGRAM_COUNTER (.clk(CLK),.inst_Address(PCNext),.rst(RST),.EN(StallF),.fetched_inst(PC));


/************************** MUX before PC**********************/

MUX #(.data_width(data_width2)) MUX5 (.in1(PC_PLUS4),.in2(PC_Target),.sel(PCSrc),.out(PCNext));

/********************** 1st 4X1MUX beforeALU************************/
MUX_4x1 #(.data_width(data_width2)) MUX_4x1_U1(
.in0(RD1E),.in1(Result),.in2(ALURESULTM),.in3('b0),.sel(ForwardAE),.out(SRC_A));

/********************** 2nd 4X1MUX beforeALU************************/
MUX_4x1 #(.data_width(data_width2)) MUX_4x1_U2(
.in0(RD2E),.in1(Result),.in2(ALURESULTM),.in3('b0),.sel(ForwardBE),.out(WriteDataE));
/*************************3rd 4x1MUX ******************************/
MUX_4x1 #(.data_width(data_width2)) MUX_4x1_U3(
.in0(ALUResultW),.in1(ReadDataW),.in2(PCPlus4W),.in3('b0),.sel(ResultSrcW),.out(Result));
/*MUX #(.data_width(data_width2)) MUX7 (.in1(ALUResultW),.in2(ReadDataW),.sel(ResultSrcW),.out(Result));
/**************************register file module**********************/

register_file REGISTER_FILE (.clk(CLK),.rst(RST),.WE3(RegWriteW),.WD3(Result),.A1(INST_D[19:15]),.A2(INST_D[24:20]), 
.A3(RdW),.RD1(RD1),.RD2(RD2));
/****************************************Fetch stage REGISTER********************************/
Fetch_REG #(.WIDTH(data_width2)) Fetch_REG_U0 (.CLK(CLK),.RST(RST),.EN(StallD),.CLR(FlushD),
.RD(instr),.PCF(PC),.PCPLUS4F(PC_PLUS4),.INST_D(INST_D),.PCD(PCD),.PCPLUS4D(PCPlus4D));

/*****************************************control hazard*********************/
Hazard_unit Hazard_unit_U0(
.Rs1D(INST_D[19:15]),.Rs2D(INST_D[24:20]),.Rs1E(Rs1E),.Rs2E(Rs2E),.RdE(RdE),.PCSrcE(PCSrc),
.ResultSrcE(Result_SRC[0]),.RdM(RdM),.RegWriteM(RegWriteM),.RdW(RdW),.RegWriteW(RegWriteW),
.StallF(StallF),.StallD(StallD),.FlushD(FlushD),.FlushE(FlushE),.ForwardAE(ForwardAE),.ForwardBE(ForwardBE));

/****************************************Decode stage REGISTER********************************/

decode_REG #(.WIDTH(data_width2)) decode_REG_U0 (.CLK(CLK),.RST(RST),.CLR(FlushE),
.RD1(RD1),.RD2(RD2),.PCD(PCD),.RS1D(INST_D[19:15]),.RS2D(INST_D[24:20]),.RdD(INST_D[11:7]),.IMMEXTD(ImmExt),
.PCPLUS4D(PCPlus4D),.RD1E(RD1E),.RD2E(RD2E),.PCE(PCE),.RS1E(Rs1E),
.RS2E(Rs2E),.RdE(RdE),.IMMEXTE(IMMEXTE),.PCPLUS4E(PCPLUS4E));

/****************************************Execute stage REGISTER********************************/
Execute_REG #(.WIDTH(data_width2)) Execute_REG_U0(.CLK(CLK),.RST(RST),.ALURESULT(ALU_OUT),
.ResultSrcE(Result_SRC),.MemWriteE(mem_write),.RegWriteE(reg_write),.WriteDataE(WriteDataE),.RdE(RdE),.PCPlus4E(PCPLUS4E),
.ALURESULTM(ALURESULTM),.ResultSrcM(ResultSrcM),.MemWriteM(MemWriteM),.RegWriteM(RegWriteM),.WriteDataM(WriteDataM),.RdM(RdM),.PCPlus4M(PCPlus4M));

/****************************************Writeback stage REGISTER********************************/
WriteBack_REG #(.WIDTH(data_width2)) WriteBack_REG_U0 (.CLK(CLK),.RST(RST),.ALURESULTM(ALURESULTM),
.ResultSrcM(ResultSrcM),.RegWriteM(RegWriteM),.RD(Read_Data),.RdM(RdM),.PCPlus4M(PCPlus4M),.ALURESULTW(ALUResultW),
.ResultSrcW(ResultSrcW),.RegWriteW(RegWriteW),.ReadDataW(ReadDataW),.RdW(RdW),.PCPlus4W(PCPlus4W));

endmodule
