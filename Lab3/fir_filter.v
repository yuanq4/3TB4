`timescale 1ns / 1ps
module fir_filter(input sample_clock, input reset, input [15:0] input_sample, output reg [15:0] output_sample);

parameter N = 17;

reg [15:0] delayholder[N-1: 0];
wire signed [15:0] summation [N-1:0];
reg signed [15:0] finsummations [N-1:0];
reg signed [15:0] finsummation;

reg signed [15:0] coeff[16:0];

integer x;
integer z;

always @(*)
begin
	coeff[0]  = -3778;
	coeff[1]  = -2;
	coeff[2]  = 2889;
	coeff[3]  = -4;
	coeff[4]  = -3571;
	coeff[5]  = -4;
	coeff[6]  = 4044;
	coeff[7]  = -2;
	coeff[8]  = 28564;
	coeff[9]  = -2;
	coeff[10] = 4044;
	coeff[11] = -4;
	coeff[12] = -3571;
	coeff[13] = -4;
	coeff[14] = 2889;
	coeff[15] = -2;
	coeff[16] = -3778;
end

generate 
genvar i;

for (i=0; i<N; i=i+1)
begin: mult1
	multiplier mult1(.dataa(coeff[i]), .datab(delayholder[i]), .result(summation[i]));
end
endgenerate

always @(posedge sample_clock or posedge reset)
begin
	if(reset)
	begin
		output_sample = 0;
		for (z=0; z<N; z=z+1)
		begin
			delayholder[z] = 0;
		end
	end
	
	else
	begin
		for (z=N-1; z>0; z=z-1)
		begin
			delayholder[z] = delayholder[z-1];
		end
		delayholder[0] = input_sample;
	end
	
	for (z=0; z<N; z=z+1)
	begin
		finsummations[z] = summation[z];
	end
	
	finsummation = 0;
	for (z=0; z<N; z=z+1)
	begin
		finsummation = finsummation + finsummations[z];
	end
	
	output_sample = finsummation;
end
endmodule
