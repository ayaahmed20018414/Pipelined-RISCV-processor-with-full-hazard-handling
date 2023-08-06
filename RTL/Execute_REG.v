module Execute_REG #(parameter WIDTH = 32)(
input CLK,
input RST,
input [WIDTH-1:0] ALURESULT,
input [1:0] ResultSrcE,
input MemWriteE,
input RegWriteE,
input [WIDTH-1:0] WriteDataE,
input [4:0] RdE,
input [WIDTH-1:0] PCPlus4E,
output reg [WIDTH-1:0] ALURESULTM,
output reg [1:0] ResultSrcM,
output reg MemWriteM,
output reg RegWriteM,
output reg [WIDTH-1:0] WriteDataM,
output reg [WIDTH-1:0] RdM,
output reg [WIDTH-1:0] PCPlus4M);


always @(posedge CLK or negedge RST)
 begin
	if(!RST)
	 begin
		ALURESULTM <='b0;
		ResultSrcM <='b0;
 		MemWriteM <='b0;
 		RegWriteM <='b0;
 		WriteDataM <='b0;
 		RdM <='b0;
		PCPlus4M <='b0;
	 end
	else
	 begin
		ALURESULTM <= ALURESULT;
		ResultSrcM <= ResultSrcE;
 		MemWriteM <= MemWriteE;
 		RegWriteM <= RegWriteE;
 		WriteDataM <= WriteDataE;
 		RdM <= RdE;
		PCPlus4M <= PCPlus4E;
	 end
 end
endmodule
