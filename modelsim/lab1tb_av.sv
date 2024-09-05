`timescale 1ns/1ns
`default_nettype none
`define N_TV 16

module lab1_tb();
 // Set up test signals
 logic clk, reset;
 logic [3:0] s, [2:0] led, [6:0] seg, [6:0] seg_expected, [2:0] led_expected;
 logic [31:0] vectornum, errors;
 logic [13:0] testvectors[10000:0]; // Vectors of format s[3:0]_seg[6:0]


 // Instantiate the device under test
 lab1 dut(.s(s), .led(led), .seg(seg));

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
             $display("Error: inputs: s=%s", s);
             $display(" outputs: s=%seg (%led expected), seg=%seg (%seg expected)", seg, seg_expected, led, led_expected);
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