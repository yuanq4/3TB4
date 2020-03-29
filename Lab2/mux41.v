module mux41(input [3:0]a1,a2,a3,a4,a5,a6,input [2:0]Ind, output reg[3:0] Out);
	always@(*)
	begin
		case(Ind)
			3'b000: Out<=a1;
			3'b001: Out<=a2;
			3'b010: Out<=a3;
			3'b011: Out<=a4;
			3'b100: Out<=a5;
			3'b101: Out<=a6;
		endcase
	end
endmodule