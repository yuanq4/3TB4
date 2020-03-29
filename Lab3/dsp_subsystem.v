module dsp_subsystem (input sample_clock,  input reset, input [1:0] selector, input [15:0] input_sample, output reg [15:0] output_sample);
	wire [15:0] myecho;
	wire [15:0] myfilter;
	
	echo_machine sw10 (.sample_clock(sample_clock), .input_sample(input_sample), .output_sample(myecho));
	fir_filter   sw01 (.sample_clock(sample_clock), .reset(reset), .input_sample(input_sample), .output_sample(myfilter));
	
	always @(posedge sample_clock)
	begin
		case(selector)
			2'b00: output_sample = input_sample;
			2'b01: output_sample = myfilter;
			2'b10: output_sample = myecho;
			2'b11: output_sample = 16'd0;
		endcase
	end

endmodule
