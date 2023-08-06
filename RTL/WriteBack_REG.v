module WriteBack_REG #(parameter WIDTH = 32)(
input CLK,
input RST,
input [WIDTH-1:0] ALURESULTM,
input [1:0] ResultSrcM,
input RegWriteM,
input [WIDTH-1:0] RD,
input [4:0] RdM,
input [WIDTH-1:0] PCPlus4M,
output reg [WIDTH-1:0] ALURESULTW,
output reg [1:0] ResultSrcW,
output reg RegWriteW,
output reg [WIDTH-1:0] ReadDataW,
output reg [4:0] RdW,
output reg [WIDTH-1:0] PCPlus4W);


always @(posedge CLK or negedge RST)
 begin
	if(!RST)
	 begin
		ALURESULTW <='b0;
		ResultSrcW <='b0;
 		RegWriteW <='b0;
 		ReadDataW <='b0;
 		RdW <='b0;
		PCPlus4W <='b0;
	 end
	else
	 begin
		ALURESULTW <= ALURESULTM;
		ResultSrcW <= ResultSrcM;
 		RegWriteW <= RegWriteM;
 		ReadDataW <= RD;
 		RdW <= RdM;
		PCPlus4W <= PCPlus4M;
	 end
 end
endmodule
