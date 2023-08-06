module Hazard_unit(
input [4:0] Rs1D,
input [4:0] Rs2D,
input [4:0] Rs1E,
input [4:0] Rs2E,
input [4:0] RdE,
input PCSrcE,
input ResultSrcE,
input [4:0] RdM,
input RegWriteM,
input [4:0] RdW,
input RegWriteW,
output reg StallF,
output reg StallD,
output reg FlushD,
output reg FlushE,
output reg [1:0] ForwardAE,
output reg [1:0] ForwardBE);
reg lwStall;
always @(*)
 begin
	if (((Rs1E == RdM) && RegWriteM) && (Rs1E != 0))
	 begin
		ForwardAE = 2'b10;
	 end
	else if (((Rs1E == RdW) && RegWriteW) && (Rs1E != 0))
	 begin
		ForwardAE = 2'b01;
	 end
	else
	 begin 
		ForwardAE = 2'b00;
		lwStall = ResultSrcE & ((Rs1D == RdE) | (Rs2D == RdE));
		StallF = lwStall;
		StallD = lwStall;
		FlushD = PCSrcE;
		FlushE = lwStall | PCSrcE;
	 end
	if (((Rs2E == RdM) && RegWriteM) && (Rs2E != 0))
	 begin
		ForwardBE = 2'b10;
	 end
	else if (((Rs2E == RdW) && RegWriteW) && (Rs2E != 0))
	 begin
		ForwardBE = 2'b01;
	 end
	else
	 begin 
		ForwardBE = 2'b00;
		lwStall = ResultSrcE & ((Rs1D == RdE) | (Rs2D == RdE));
		StallF = lwStall;
		StallD = lwStall;
		FlushD = PCSrcE;
		FlushE = lwStall | PCSrcE;
	 end
 end

endmodule 
