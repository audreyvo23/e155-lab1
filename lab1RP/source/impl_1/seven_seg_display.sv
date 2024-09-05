// Audrey Vo
// avo@hmc.edu
// 9/3/2024
// This code controls the the 7-segement display based on the input of the switcbes.

module sevenSeg (
	input logic [3:0] s,
	output logic [6:0] seg
);

	always_comb 
	begin
		case(s)
			// checks the s input and assigns output to display appropriate values
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
		endcase
	end
	
	



endmodule
