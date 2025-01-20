`timescale 1ns / 1ps
// This Verilog module is used for determining test numbers square root in an approximate value
// This module does not calculate square root value correctly
// However, purpose of this module is reducing division amount
// Due to that reason, this module is sufficient
module SquareRootCircuit(input clk, input [31:0] TestNumber, output reg [31:0] SquareRootResult, output reg EnablePrimeNumberDetection);
// Potential square root is used for checking if PotentialSquareRoot = count X count
// EnoughCalculation is used for locking calculation process when an approximate value is found
// Count is increased at every clock pulse until an approximate value is found
integer PotentialSquareRoot;
integer EnoughCalculation;
integer Count;
// Initial values are demonstrated below for calculations
initial begin
PotentialSquareRoot <= 0;
EnoughCalculation <= 0;
Count <= 0;
end
// At every clock pulse, it will be check if count is approximately equal to the real square root
// If an approximate value is found, two will be added to result for not missing potential divisors in prime number detection
// When operations for square root calculation is done, no more calculations will be performed
// and this module will produce an enable signal for prime number detector Verilog module
always@(posedge clk)
begin
// Enable signal for prime number is given below if square root value is calculated
if(EnoughCalculation == 1) begin
EnablePrimeNumberDetection <= 1;
end
// Approximate square root is calculated below for TestNumber
else if(EnoughCalculation == 0) begin
PotentialSquareRoot <= (Count)*(Count); 
      if(PotentialSquareRoot == TestNumber) begin
		SquareRootResult <= Count + 2;
		EnablePrimeNumberDetection <= 1;
		EnoughCalculation <= 1;
		end
// Very big numbers after 4,292,870,400 causes issues
// due to that reason following lines are written
		else if(Count == 65520) begin
		SquareRootResult <= 66000;
		EnablePrimeNumberDetection <= 1;
		EnoughCalculation <= 1;
		end
		else if(PotentialSquareRoot < TestNumber) begin
		Count <= Count + 1;
		EnablePrimeNumberDetection <= 0;
		end
		else if(PotentialSquareRoot > TestNumber) begin
		SquareRootResult <= Count + 2;
		EnablePrimeNumberDetection <= 1;
		EnoughCalculation <= 1;
		end
end
end
endmodule
