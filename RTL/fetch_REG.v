module Fetch_REG #(parameter WIDTH = 32)(
input CLK,
input RST,
input EN,
input CLR,
input  [WIDTH-1:0] RD,
input  [WIDTH-1:0] PCF,
input  [WIDTH-1:0] PCPLUS4F,
output reg [WIDTH-1:0] INST_D,
output reg [WIDTH-1:0] PCD,
output reg [WIDTH-1:0] PCPLUS4D);
always @(posedge CLK or negedge RST)
 begin
	if (!RST)
	 begin
		INST_D<='b0;
		PCD<='b0;
		PCPLUS4D<='b0;
	 end
	else if(CLR)
	 begin
		INST_D<='b0;
		PCD<='b0;
		PCPLUS4D<='b0;
	 end
	else if(!EN)
 	 begin
		INST_D<=RD;
		PCD<=PCF;
		PCPLUS4D<=PCPLUS4F;
	 end
	else
 	 begin
		INST_D<='b0;
		PCD<='b0;
		PCPLUS4D<='b0;
	 end
 
 end

endmodule
