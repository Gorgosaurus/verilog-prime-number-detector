`timescale 1ns / 1ps
// Cathode anode Verilog module for project
module CathodeAnodePrimeNumber(input clk, input reset, input [3:0] Digit3, input [3:0] Digit2, input [3:0] Digit1, input [3:0] Digit0, output reg [3:0] Anode, output reg [7:0] Cathode);
	 reg [19:0] Refresh;
	 initial begin
	 Refresh <= 0;
	 end
    always @(posedge clk or posedge reset)
    begin 
    if(reset==1)
    Refresh <= 0;
    else
    Refresh <= Refresh + 1'b1;
    end
	 
	 wire [1:0] ChannelSelector;
    assign ChannelSelector = Refresh[19:18];
	 
	 reg [3:0] CaseCathode;
    always @(*)
    begin
    case(ChannelSelector)
    2'b00: begin
    Anode = 4'b0111; 
    CaseCathode = Digit0;
    end
    2'b01: begin
    Anode = 4'b1011; 
    CaseCathode = Digit1;
    end
    2'b10: begin
    Anode = 4'b1101; 
    CaseCathode = Digit2;
    end
    2'b11: begin
    Anode = 4'b1110;
    CaseCathode = Digit3;   
    end
    endcase
    end
	 
    always @(*)
    begin
    case(CaseCathode)
    4'b0000: Cathode = 8'b11000000;
    4'b0001: Cathode = 8'b11111001;
    4'b0010: Cathode = 8'b10100100;
    4'b0011: Cathode = 8'b10110000;
    4'b0100: Cathode = 8'b10011001;
    4'b0101: Cathode = 8'b10010010;
    4'b0110: Cathode = 8'b10000010;
    4'b0111: Cathode = 8'b11111000;
    4'b1000: Cathode = 8'b10000000;
    4'b1001: Cathode = 8'b10010000;
	 4'b1100: Cathode = 8'b11000110;
    default: Cathode = 8'b10101010;
    endcase
    end
endmodule
