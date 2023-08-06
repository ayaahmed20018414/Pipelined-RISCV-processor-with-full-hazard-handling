module sign_extend(input wire [24:0] Instr,
input  wire [1:0] ImmSrc,
output reg [31:0] Imm_Ext);
always @(*)
 begin
  	case(ImmSrc)
  	 2'b00:begin
		  Imm_Ext={{20{Instr[24]}},Instr[24:13]};
		 end
  	 2'b01:begin
		  Imm_Ext={{20{Instr[24]}},Instr[24:18],Instr[4:0]};
		 end
  	 2'b10:begin
		  Imm_Ext={{20{Instr[24]}}, Instr[0], Instr[23:18], Instr[4:1], 1'b0};
  	 	 end
  	 default:begin
		   Imm_Ext='b0;
            	  end
	
   	   endcase
	  end

endmodule
