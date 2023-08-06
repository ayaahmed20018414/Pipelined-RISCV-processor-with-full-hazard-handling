module MUX #(parameter data_width=32)
(input [data_width-1:0] in1,
input [data_width-1:0] in2,
input sel,
output [data_width-1:0] out);



assign out=(sel) ? in2:in1;

endmodule
