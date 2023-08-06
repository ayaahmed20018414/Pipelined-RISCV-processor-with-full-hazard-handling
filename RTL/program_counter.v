module program_counter(input clk, 
input [31:0] inst_Address,
input rst,
input EN,
output reg [31:0] fetched_inst);
always @(posedge clk or negedge rst)
begin
if(!rst)
	fetched_inst<='b0;
else if(!EN)
	fetched_inst<=inst_Address;
end
endmodule 
