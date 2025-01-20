`timescale 1ns / 1ps
// This module is used for checking if test number is prime number or not
module PrimeNumberDetector(input clk, input [31:0] TestNumber, input EnableFromSquareRootCircuit, input [31:0] SquareRootValue, output reg [3:0] Digit3, output reg StopCounter);
integer divisor;
// If sufficient trial is performed, no more calculation will be performed
// DetectionDone is used for this purpose
integer DetectionDone;
// TestNumber will be checked if it is even or not
integer CheckDoneEvenNumber;
// remainder value is an important value for determing if TestNumber is prime number or not
integer remainder;
// Initial values are demonstrated here
initial begin
// Digit3 is defined as 1100, so that seven segment display will show C letter
Digit3 <= 4'b1100;
// divisor is defined as 3 at the beginning
divisor <= 3;
StopCounter <= 0;
DetectionDone <= 0;
CheckDoneEvenNumber <= 0;
end
// Prime number detection operations are defined below
always@(posedge clk)
begin
if(DetectionDone == 0) begin
// divisor is incremented by 2 at every clock pulse
// This is only possible if TestNumber is an odd number
// due to that reason, it is checked if TestNumber is even or not
     if((CheckDoneEvenNumber == 0) && (DetectionDone == 0)) begin
     remainder <= (TestNumber % 2);
        if(remainder == 0) begin
	     Digit3 <= 4'b0000;
		  StopCounter <= 1;
	     DetectionDone <= 1;
	     CheckDoneEvenNumber <= 1;
	     end
	     else if(remainder == 1) begin
	     CheckDoneEvenNumber <= 1;
	     end
     end
// After calculation of square root of TestNumber, it is
// checked if TestNumber is prime or not, divisions
// will be performed for this purpose
     else if((EnableFromSquareRootCircuit == 1) && (DetectionDone == 0)) begin
     remainder <= (TestNumber % divisor);
        if(remainder == 0) begin
        Digit3 <= 4'b0000;
		  StopCounter <= 1;
	     DetectionDone <= 1;
		  end
		  else if(remainder > 0) begin
		    if(divisor > SquareRootValue) begin
			 Digit3 <= 4'b0001;
			 StopCounter <= 1;
			 DetectionDone <= 1;
			 end
			 else if(divisor == SquareRootValue) begin
			 divisor <= divisor + 2;
			 end
			 else if(divisor < SquareRootValue) begin
			 divisor <= divisor + 2;
			 end
		  end
	  end
end
end
endmodule
