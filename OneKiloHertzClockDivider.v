`timescale 1ns / 1ps
// One KiloHertz clock divider should be used
// for prime number detection circuit
module OneKiloHertzClockDivider(input clk, output reg OneKiloHertzClock);
	integer count;
	initial begin
		count = 0;
		OneKiloHertzClock = 0;
	end
	
	always@(posedge clk)
		if(count == 49999) begin
			count = 0;
			OneKiloHertzClock = ~OneKiloHertzClock;                                
		end
		else begin
			count = count + 1;
      end			
endmodule
