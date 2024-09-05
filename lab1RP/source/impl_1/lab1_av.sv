// Audrey Vo
// avo@hmc.edu
// 9/3/2024
// This code controls the 3 Leds on the development board and also calls the 7-segement display based on the input of the switches.

module top(

	input	logic	clk, [3:0] s,
	output 	logic [2:0] led, [6:0] seg


);
	// call led display
	ledDisplay s2 (s, led);
	
	// call 7 segment display
	sevenSeg s1 (s, seg);
			
	

endmodule