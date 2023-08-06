module inst_mem(input wire [31:0] Add_PC,
output wire [31:0] inst);

reg [31:0] ROM_inst_mem [0:99];

initial $readmemh("1st_program.txt",ROM_inst_mem);

assign inst= ROM_inst_mem[Add_PC[31:2]];


endmodule

