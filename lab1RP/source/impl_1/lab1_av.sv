// Audrey Vo
// avo@hmc.edu
// 9/3/2024
// This code controls the 3 Leds on the development board and also calls the 7-segement display based on the input of the switches.

module top(

	input	logic	clk, [3:0] s,
	output 	logic [2:0] led, [6:0] seg


);
	// LED 0
	xor g1(led[0], s[0], s[1]);
	
	// LED 1
	and g2(led[1], s[2], s[3]);
	
	// LED 2
	
	logic int_osc;
	logic pulse;
	logic led_state = 1;
	logic [24:0] counter = 0;
	
	
	// Internal high-speed oscillator
	HSOSC hf_osc (.CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(int_osc));
	
	// Simple clock divider
	always_ff @(posedge int_osc)
		begin
			// checks if counter has hit 10M (to get 2.4 Hz signal)
			if(counter != 10000000) counter <= counter + 1;
			else if (counter == 10000000 & led_state == 0) 
				begin 
					led_state <= 1;
					counter <= 0;
				end
			else if (counter == 10000000 & led_state == 1) 
				begin 
					led_state <= 0;
					counter <= 0;
				end
		end
	
	// turns led on or off
	assign led[2] = led_state;
	
	
	sevenSeg s1 (s, seg);
			
	

endmodule