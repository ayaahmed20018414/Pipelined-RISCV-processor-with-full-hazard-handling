module decode_REG #(parameter WIDTH = 32)(
input wire CLK,
input wire RST,
input wire CLR,
input wire [WIDTH-1:0] RD1,
input wire [WIDTH-1:0] RD2,
input wire [WIDTH-1:0] PCD,
input wire [4:0] RS1D,
input wire [4:0] RS2D,
input wire [4:0] RdD,
input wire [WIDTH-1:0] IMMEXTD,
input wire [WIDTH-1:0] PCPLUS4D,
output reg [WIDTH-1:0] RD1E,
output reg [WIDTH-1:0] RD2E,
output reg [WIDTH-1:0] PCE,
output reg [4:0] RS1E,
output reg [4:0] RS2E,
output reg [4:0] RdE,
output reg [WIDTH-1:0] IMMEXTE,
output reg [WIDTH-1:0] PCPLUS4E);
 always@(posedge CLK or negedge RST)
  begin
	if(!RST)
	 begin
		RD1E<='b0;
		RD2E<='b0;
		PCE<='b0;
		RS1E<='b0;
		RS2E<='b0;
		RdE<='b0;
		IMMEXTE<='b0;
		PCPLUS4E<='b0;
	 end
	else if(CLR)
	 begin
		RD1E<='b0;
		RD2E<='b0;
		PCE<='b0;
		RS1E<='b0;
		RS2E<='b0;
		RdE<='b0;
		IMMEXTE<='b0;
		PCPLUS4E<='b0;		
	 end
	else
	 begin
		RD1E<=RD1;
		RD2E<=RD2;
		PCE<=PCD;
		RS1E<=RS1D;
		RS2E<=RS2D;
		RdE<=RdD;
		IMMEXTE<=IMMEXTD;
		PCPLUS4E<=PCPLUS4D;		
	 end
  end















endmodule
