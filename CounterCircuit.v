`timescale 1ns / 1ps
// This Verilog module is used for demonstrating seconds
// Counter will not count anymore once calculation for if
// TestNumber is prime or not is done. This is ensured with
// StopCounter input from PrimeNumberDetector Verilog module
module CounterCircuit(input clk, output reg [15:0] Count, input StopCounter);
initial begin
Count <= 0;
end
always@(posedge clk)
begin
if(StopCounter == 1) begin
Count <= Count + 0;
end
else if(StopCounter == 0) begin
Count <= Count + 1;
end
end
endmodule
