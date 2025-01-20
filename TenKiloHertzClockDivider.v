`timescale 1ns / 1ps
// Ten KiloHertz clock divider, should be used for
// square root calculation Verilog module
module TenKiloHertzClockDivider(input clk, output reg TenKiloHertzClock);
	integer count;
	initial begin
		count = 0;
		TenKiloHertzClock = 0;
	end
	
	always@(posedge clk)
		if(count == 4999) begin
			count = 0;
			TenKiloHertzClock = ~TenKiloHertzClock;                                
		end
		else begin
			count = count + 1;
      end			
endmodule
