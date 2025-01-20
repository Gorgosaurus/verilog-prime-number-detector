`timescale 1ns / 1ps
// This is the main Verilog module for the project
module MainCircuitPrimeNumberProject(input clk,
                                     output [3:0] Anode,
												 output [7:0] Cathode,
												 output [31:0] ShowTestNumberValue,
												 output [31:0] ShowSquareRootResultValue,
												 output StatusStopCounter,
												 output StatusEnablePrimeNumberDetection,
												 output [3:0] StatusDigit3,
												 output [3:0] StatusDigit2,
												 output [3:0] StatusDigit1,
												 output [3:0] StatusDigit0);
// TestNumber is defined below
// User may change value of TestNumber for testing
// different values.
integer TestNumber;
reg reset;
initial begin
TestNumber <= 4294967291;
// This reset is useless, however it must
// be defined as zero, otherwise cathode anode
// Verilog module does not work
reset <= 0;
end
// To show TestNumber on simulations, this value is defined
assign ShowTestNumberValue[31:0] = TestNumber;
// Clock dividers are demonstrated below
// One Hertz clock will be used for demonstrating how long does calculation takes
wire OneHertzClk;
// One KiloHertz clock will be used for prime number detection Verilog module
wire OneKiloHertzClk;
// Ten KiloHertz clock will be used for square root calculation Verilog module
wire TenKiloHertzClk;
OneHertzClockDivider OneHertzClkDividerCircuit(clk, OneHertzClk);
OneKiloHertzClockDivider OneKiloHertzClkDividerCircuit(clk, OneKiloHertzClk);
TenKiloHertzClockDivider TenKiloHertzClkDividerCircuit(clk, TenKiloHertzClk);
// Square root calculation circuit is defined below
wire [31:0] SquareRootResult;
wire EnablePrimeNumberDetection;
SquareRootCircuit SqrtCalculatorCircuit(TenKiloHertzClk, TestNumber, SquareRootResult, EnablePrimeNumberDetection);
// To show square root result on simulations, this value is defined
assign ShowSquareRootResultValue[31:0] = SquareRootResult;
// Prime number check is performed below
// Digit3 represents status of operations
// It shows C if operations are still being performed
// It shows 1 if TestNumber is a prime number
// It shows 0 if TestNumber is not a prime number
wire [3:0] Digit3;
wire StopCounter;
PrimeNumberDetector PrimeNumCircuit(OneKiloHertzClk, TestNumber, EnablePrimeNumberDetection, SquareRootResult, Digit3, StopCounter);
// Counter for demonstrating how many seconds pass is defined below
wire [15:0] count;
CounterCircuit CounterModuleForProject(OneHertzClk, count, StopCounter);
// Binary to BCD conversion is done below for demonstrating seconds
wire [3:0] UselessDigit;
wire [3:0] Digit2;
wire [3:0] Digit1;
wire [3:0] Digit0;
BinaryToBCDconverter BinaryValueToBCDcircuit(count, UselessDigit, Digit2, Digit1, Digit0);
CathodeAnodePrimeNumber CathodeAnodeCircuit(clk, reset, Digit0, Digit1, Digit2, Digit3, Anode, Cathode);
// To show status and count on simulations, these values are defined below
assign StatusDigit3[3:0] = Digit3;
assign StatusDigit2[3:0] = Digit2;
assign StatusDigit1[3:0] = Digit1;
assign StatusDigit0[3:0] = Digit0;
assign StatusStopCounter = StopCounter;
assign StatusEnablePrimeNumberDetection = EnablePrimeNumberDetection;
endmodule
