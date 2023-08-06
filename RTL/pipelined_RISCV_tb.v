`timescale 1ns/1ps
module pipelined_RISCV_tb #(parameter Data_Width1=5,Data_Width2=32,Data_Width3=28,CONTROL_WIDTH=3)();
reg CLK_tb;
reg RESET_tb;
wire [15:0]test_value;

initial
 begin
  $dumpfile("RISCV_tb.vcd");
  $dumpvars; 
  CLK_tb=0;
  RESET_tb=0;
  repeat(10)@(posedge CLK_tb);
  RESET_tb=1;
  repeat(1100)@(posedge CLK_tb);	
  $stop;
 end
  always #10 CLK_tb=!CLK_tb;
pipelined_RISCV_TOP #(.Data_Width1(Data_Width1),.Data_Width2(Data_Width2),.Data_Width3(Data_Width3),.CONTROL_WIDTH(CONTROL_WIDTH)) RISCV_DUT
(.CLK(CLK_tb),.RESET(RESET_tb),.test_value(test_value));





endmodule 
