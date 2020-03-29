module part1total(input CLK_50, input [3:0] KEY, output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
wire [19:0] hexvalue;
wire [13:0] random_wait_time;
wire randReady;
assign hexvalue[13:0] = random_wait_time[13:0];
wire [3:0] digit0,digit1,digit2,digit3,digit4,digit5;
wire clk_ms;
	part1_clock #(5000000) (CLOCK_50, KEY[3], clk_ms);
	randomnum (clk_ms, KEY[0], KEY[1], random_wait_time, randReady);
	display_converter(clk_ms, KEY[0],hexvalue, digit0, digit1, digit2, digit3, digit4, digit5);
	part1_sevenseg  decoder0(digit0, HEX0);
	part1_sevenseg  decoder1(digit1, HEX1);
	part1_sevenseg  decoder2(digit2, HEX2);
	part1_sevenseg  decoder3(digit3, HEX3);
	part1_sevenseg  decoder4(digit4, HEX4);
	part1_sevenseg  decoder5(digit5, HEX5);
endmodule
