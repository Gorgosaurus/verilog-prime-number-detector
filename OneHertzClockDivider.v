`timescale 1ns / 1ps
// One Hertz clock divider, should be used for second display
module OneHertzClockDivider(input clk, output reg OneHertzClock);
	integer count;
	initial begin
		count = 0;
		OneHertzClock = 0;
	end
	
	always@(posedge clk)
		if(count == 4999999) begin
			count = 0;
			OneHertzClock = ~OneHertzClock;                                
		end
		else begin
			count = count + 1;
      end			
endmodule
