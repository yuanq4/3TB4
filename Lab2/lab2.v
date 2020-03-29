// using KEY[1] as reset, KEY[2] as resume, KEY[0] for player1, KEY[3] for player2


module lab2(input CLOCK_50, input [3:0] KEY, output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, output [9:0] LEDR);

	parameter [2:0] RESET=3'b000, RESUME=3'b001, BLINKING=3'b010, OFF=3'b011, TIMER_DISPLAY=3'b100, WINNER_TIME_DISPLAY=3'b101,
							WIN1=3'b110, WIN2=3'b111;
	
	reg [2:0] state=RESET, next_state=RESET;	
	
	wire clk_ms;
	wire [19:0] ms, display_ms;
	wire [3:0] w_ms0,w_ms1,w_ms2,w_ms3, w_ms4,w_ms5; //wires after hex_to_bcd_converter.v for displayed time
	wire [3:0] w_blink0, w_blink1, w_blink2, w_blink3, w_blink4, w_blink5;  //wires afer  blinking 
	wire [3:0] winner_ms0,winner_ms1,winner_ms2,winner_ms3, winner_ms4,winner_ms5; //wires afer hex_to_bcd_converter.v for winner time
	
	wire [3:0] digit0, digit1, digit2, digit3, digit4, digit5;  //wires afer mux.v
	
	wire [13:0] random_wait_time;
	wire w_rnd_ready;
	
	reg [2:0]  hex_sel=2'b000;  //whether blinking or not
	wire [2:0] w_hex_sel; 
	
	
	reg display_counter_start;
	wire w_display_counter_start;
	
	
	reg player1_win, player2_win;   // if is 0, not win, if 1 win,
	
	reg[4:0] win1=5'b00000, win2=5'b00000;   // score for player 1 and 2.

	reg [19:0]temp;

	reg [19:0] winner_time=8888;
	wire [19:0] w_winner_time;
	
	wire conditioned_key0, conditioned_key3;

	assign w_winner_time=winner_time;
	
	assign w_hex_sel=hex_sel;
	
	assign w_display_counter_start=display_counter_start; 

	assign LEDR[4:0]=win1;
	assign LEDR[9:5]={win2[0],win2[1],win2[2],win2[3],win2[4]} ;   

	mux41(.a1(w_blink0),.a2(4'b1111),.a3(w_ms0),.a4(winner_ms0),.a5(4'b0001),.a6(4'b0010),.Ind(hex_sel),.Out(digit0));
	mux41(.a1(w_blink1),.a2(4'b1111),.a3(w_ms1),.a4(winner_ms1),.a5(4'b0001),.a6(4'b0010),.Ind(hex_sel),.Out(digit1));
	mux41(.a1(w_blink2),.a2(4'b1111),.a3(w_ms2),.a4(winner_ms2),.a5(4'b0001),.a6(4'b0010),.Ind(hex_sel),.Out(digit2));
	mux41(.a1(w_blink3),.a2(4'b1111),.a3(w_ms3),.a4(winner_ms3),.a5(4'b0001),.a6(4'b0010),.Ind(hex_sel),.Out(digit3));
	mux41(.a1(w_blink4),.a2(4'b1111),.a3(w_ms4),.a4(winner_ms4),.a5(4'b0001),.a6(4'b0010),.Ind(hex_sel),.Out(digit4));
	mux41(.a1(w_blink5),.a2(4'b1111),.a3(w_ms5),.a4(winner_ms5),.a5(4'b0001),.a6(4'b0010),.Ind(hex_sel),.Out(digit5));
	clock_divider #(.factor(50000)) (.Clock(CLOCK_50), .Reset_n(KEY[1]), .pulse_ms(clk_ms));
	
	counter (.clk(clk_ms), .reset_n(KEY[1]), .resume_n(KEY[2]), .enable(1), .ms_count(ms));

	counter (.clk(clk_ms), .reset_n(KEY[1]), .resume_n(KEY[2]), .enable(w_display_counter_start), .ms_count(display_ms));

	blinkLED #(.factor(50) ) (.ms_clk(clk_ms), .Reset_n(KEY[1]), .d0(w_blink0), .d1(w_blink1), .d2(w_blink2), .d3(w_blink3), .d4(w_blink4),.d5(w_blink5));

	hex_to_bcd_converter winnerConvert( .clk(CLOCK_50), .reset(KEY[1]), .hex_number(w_winner_time),
	.bcd_digit_0(winner_ms0),.bcd_digit_1(winner_ms1),.bcd_digit_2(winner_ms2),.bcd_digit_3(winner_ms3), .bcd_digit_4(winner_ms4),
	.bcd_digit_5(winner_ms5));
	
	hex_to_bcd_converter clockConvert( .clk(CLOCK_50), .reset(KEY[1]), .hex_number(display_ms),
	.bcd_digit_0(w_ms0),.bcd_digit_1(w_ms1),.bcd_digit_2(w_ms2),.bcd_digit_3(w_ms3), .bcd_digit_4(w_ms4),
	.bcd_digit_5(w_ms5));
	
	
	random ( .clk(CLOCK_50), .reset_n(KEY[1]), .resume_n(KEY[2]),  .random(random_wait_time),
	 .rnd_ready(w_rnd_ready));
	
	seven_seg_decoder  decoder0(digit0, HEX0);
	seven_seg_decoder  decoder1(digit1, HEX1);
	seven_seg_decoder  decoder2(digit2, HEX2);
	seven_seg_decoder  decoder3(digit3, HEX3);
	seven_seg_decoder  decoder4(digit4, HEX4);
	seven_seg_decoder  decoder5(digit5, HEX5);
	
	
	
	always @ (posedge CLOCK_50, negedge KEY[1], negedge KEY[2])
	begin
		if (!KEY[1])    // reset
			begin
				state<=RESET;
			end
		else if (!KEY[2])   //start/resume
			begin
				state<=RESUME;
			end
	
		else
			begin
				state<=next_state;
			end
	end
	

	  
	always @(posedge CLOCK_50, negedge KEY[1] )    //for solving the inferred latch problem caused by win1 and win2.
	begin 
		if (!KEY[1]) begin
			win1<=5'b00000;
			win2<=5'b00000;
		end			
		else if (player1_win==1)
			begin
				win1<=(win1<<1) | 5'b00001;
			end
		else if (player2_win==1)
			begin
				win2<=(win2<<1) | 5'b00001;
			end
	end
	
		
	
	
	always @ (*) 
	begin
		next_state=state;   //default
		player1_win=0;
		player2_win=0;
		
		
		case (state)
			RESET: 
				begin					
					display_counter_start=0;
					winner_time=0;					
					
					hex_sel=3'b000;
					next_state=BLINKING;			
				end
			RESUME:
				begin					
					//hex_sel=2'b00;
					display_counter_start=0;
					winner_time=0;
				
					hex_sel=3'b000;
					next_state=BLINKING;
				end
			BLINKING:
				begin
					//hex_sel=2'b00;
					
	
					if (ms>=5000)     //blink for  about 5 second	
						begin
							//hex_sel=2'b01;
							next_state=OFF;
						end
					else 
						next_state=BLINKING;
						
				end
			
			OFF:
				begin
					hex_sel=3'b001;
					if(~KEY[0])
						begin
							next_state = WIN1;
						end
					else if(~KEY[3])
						begin
							next_state = WIN2;
						end
									
					else if (ms>(7000+random_wait_time)) begin     //(7-5) seconds + random seconds)
						
						next_state=TIMER_DISPLAY;	
						
					end
					
				end
			TIMER_DISPLAY:
				begin
					display_counter_start=1;  
					hex_sel=3'b010;	
					
				
					if (!KEY[0])
					begin
						player1_win=1;
						next_state=WINNER_TIME_DISPLAY;
					end
					else if(!KEY[3])
					begin
						player2_win=1;
						next_state=WINNER_TIME_DISPLAY;
					end
				end


			WINNER_TIME_DISPLAY:
				begin
					hex_sel=3'b011;
					display_counter_start=0;
					winner_time=display_ms;
					
				end
			WIN1:
				begin
					hex_sel=3'b100;
				end
			WIN2:
				begin
					hex_sel=3'b101;
				end
			default: 
				begin
					next_state=RESET;
				end
		endcase	

	end


endmodule	