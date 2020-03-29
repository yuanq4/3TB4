module counter(
    input clk,
    input reset_n,
    input resume_n,
    input enable,
    output reg [19:0] ms_count
);
always @(posedge clk, negedge reset_n, negedge resume_n) 
begin
	if(!reset_n || !resume_n) 
	begin
		ms_count = 20'h00000000000000000000;
	end
	else 
	begin
		if(enable) 
		begin
			ms_count = ms_count+1;
		end
   end
end
endmodule