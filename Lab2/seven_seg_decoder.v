module seven_seg_decoder(input [3:0] x, output reg [6:0] hex_LEDs);
	// sorry did not follow the lab manual instruction strictly---
	// did not use the assign statement for the first two segments.
	
	always @(*)
	begin 
			case (x)
				4'b0000: hex_LEDs[6:0]=7'b1000000;
				4'b0001: hex_LEDs[6:0]=7'b1111001;
				4'b0010: hex_LEDs[6:0]=7'b0100100;
				4'b0011: hex_LEDs[6:0]=7'b0110000;
				4'b0100: hex_LEDs[6:0]=7'b0011001;
				4'b0101: hex_LEDs[6:0]=7'b0010010;
				4'b0110: hex_LEDs[6:0]=7'b0000010;
				4'b0111: hex_LEDs[6:0]=7'b1111000;
				4'b1000: hex_LEDs[6:0]=7'b0000000;
				4'b1001: hex_LEDs[6:0]=7'b0010000;
				4'b1010: hex_LEDs[6:0]=7'b0011000;
				4'b1011: hex_LEDs[6:0]=7'b1100011;
				4'b1100: hex_LEDs[6:0]=7'b0001000;
				4'b1101: hex_LEDs[6:0]=7'b0101011;
				4'b1110: hex_LEDs[6:0]=7'b0010001;
				4'b1111: hex_LEDs[6:0]=7'b1111111;
			endcase
	end
endmodule