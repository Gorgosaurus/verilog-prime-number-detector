`timescale 1ns / 1ps
// This Verilog module is used for converting binary
// values to BCD format, should be used for displaying
// second on seven segment display
module BinaryToBCDconverter(input [15:0] BinaryValue,output reg [3:0] Digit4,output reg [3:0] Digit3,output reg [3:0] Digit2,output reg [3:0] Digit1,output reg [3:0] Digit0);
  integer interimDigit4;
  integer interimDigit3;
  integer interimDigit2;
  integer interimDigit1;
  integer interimDigit0;
  always @(*)
  begin
  interimDigit4 <= BinaryValue/10000;
  interimDigit3 <= (BinaryValue%10000)/1000;
  interimDigit2 <= ((BinaryValue%10000)%1000)/100;
  interimDigit1 <= (((BinaryValue%10000)%1000)%100)/10;
  interimDigit0 <= (((BinaryValue%10000)%1000)%100)%10;
  Digit4 <= interimDigit4[3:0];
  Digit3 <= interimDigit3[3:0];
  Digit2 <= interimDigit2[3:0];
  Digit1 <= interimDigit1[3:0];
  Digit0 <= interimDigit0[3:0];
  end
endmodule
