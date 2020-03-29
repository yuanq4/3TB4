module blinkLED(input ms_clk, Reset_n, output reg [3:0] d0, d1, d2, d3, d4, d5);
parameter factor = 50;
reg [11:0] countQ;

always@(posedge ms_clk, negedge Reset_n)
begin	
		if(!Reset_n)
		begin
				countQ<=0;
				d0<=4'b0000;
				d1<=4'b0000;
				d2<=4'b0000;
				d3<=4'b0000;
		end
		
		else
		begin
				if(countQ<factor/2)
				begin
						countQ<=countQ+1;
						d0<=4'b0000;
						d1<=4'b0000;
						d2<=4'b0000;
						d3<=4'b0000;
				end		
				
				else if(countQ<factor)
				begin
						countQ<=countQ+1;
						d0<=4'b1111;
						d1<=4'b1111;
						d2<=4'b1111;
						d3<=4'b1111;
				end
				else
				begin
						countQ<=0;
						d0<=4'b0000;
						d1<=4'b0000;
						d2<=4'b0000;
						d3<=4'b0000;
				end
		end
end
endmodule