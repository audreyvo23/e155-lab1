// Audrey Vo
// avo@hmc.edu
// 9/3/2024
// This code controls the 3 Leds on the development board and also calls the 7-segement display. In addition, code for the test benches of this file was added.

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
	
	
	
	// Simple clock divider
	always_ff @(posedge clk)
		begin
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
		
	assign led[2] = led_state;
	
	
		always_comb 
	begin
		case(s)
			4'h0: 	seg = 7'b1000000;
			4'h1:	seg = 7'b1111001;
			4'h2: 	seg = 7'b0100100;
			4'h3: 	seg = 7'b0110000;
			4'h4:	seg = 7'b0011001;
			4'h5: 	seg = 7'b0010010;
			4'h6: 	seg = 7'b0000010;
			4'h7:	seg = 7'b1111000;
			4'h8: 	seg = 7'b0000000;
			4'h9: 	seg = 7'b0011000;
			4'ha:	seg = 7'b0001000;
			4'hb: 	seg = 7'b0000011;
			4'hc: 	seg = 7'b1000110;
			4'hd: 	seg = 7'b0100001;
			4'he:	seg = 7'b0000110;
			4'hf: 	seg = 7'b0001110;
			
			
				// 7 segment device
	
		endcase
	end
	
endmodule
`timescale 1ns/1ns
`default_nettype none
`define N_TV 16

// This module contains the testbench code for the lab
module lab1_tb();
 // Set up test signals
 logic clk, reset;
 logic [3:0] s;
 logic [2:0] led,  led_expected;
 logic [6:0] seg, seg_expected;
 logic [31:0] vectornum, errors;
 logic [13:0] testvectors[10000:0]; // Vectors of format s[3:0]_seg[6:0]


 // Instantiate the device under test
 top dut(.clk(clk), .s(s), .led(led), .seg(seg));

 // Generate clock signal with a period of 10 timesteps.
 always
   begin
     clk = 1; #5;
     clk = 0; #5;
   end
  
 // At the start of the simulation:
 //  - Load the testvectors
 //  - Pulse the reset line (if applicable)
 initial
   begin
     $readmemb("lab1testbench_av.tv", testvectors, 0, `N_TV - 1);
     vectornum = 0; errors = 0;
     reset = 1; #27; reset = 0;
   end
  // Apply test vector on the rising edge of clk
 always @(posedge clk)
   begin
       #1; {s, led_expected, seg_expected} = testvectors[vectornum];
   end
  initial
 begin
   // Create dumpfile for signals
   $dumpfile("lab1tb.vcd");
   $dumpvars(0, lab1_tb);
 end
  // Check results on the falling edge of clk
 always @(negedge clk)
   begin
     if (~reset) // skip during reset
       begin
         if (seg != seg_expected || led != led_expected)
           begin
             $display("Error: inputs: s=%b", s);
             $display(" outputs: seg=%b (%b expected), led=%b (%b expected)", seg, seg_expected, led, led_expected);
             errors = errors + 1;
           end

      
       vectornum = vectornum + 1;
      
       if (testvectors[vectornum] === 14'bx)
         begin
           $display("%d tests completed with %d errors.", vectornum, errors);
           $finish;
         end
     end
   end
endmodule
	

	
  

