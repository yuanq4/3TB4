// megafunction wizard: %Shift register (RAM-based)%
// GENERATION: STANDARD
// VERSION: WM1.0
// MODULE: ALTSHIFT_TAPS 

// ============================================================
// File Name: echoshift.v
// Megafunction Name(s):
// 			ALTSHIFT_TAPS
//
// Simulation Library Files(s):
// 			altera_mf
// ============================================================
// ************************************************************
// THIS IS A WIZARD-GENERATED FILE. DO NOT EDIT THIS FILE!
//
// 17.1.0 Build 590 10/25/2017 SJ Standard Edition
// ************************************************************


//Copyright (C) 2017  Intel Corporation. All rights reserved.
//Your use of Intel Corporation's design tools, logic functions 
//and other software and tools, and its AMPP partner logic 
//functions, and any output files from any of the foregoing 
//(including device programming or simulation files), and any 
//associated documentation or information are expressly subject 
//to the terms and conditions of the Intel Program License 
//Subscription Agreement, the Intel Quartus Prime License Agreement,
//the Intel FPGA IP License Agreement, or other applicable license
//agreement, including, without limitation, that your use is for
//the sole purpose of programming logic devices manufactured by
//Intel and sold by Intel or its authorized distributors.  Please
//refer to the applicable agreement for further details.


// synopsys translate_off
`timescale 1 ps / 1 ps
// synopsys translate_on
module echoshift (
	clock,
	shiftin,
	shiftout,
	taps);

	input	  clock;
	input	[15:0]  shiftin;
	output	[15:0]  shiftout;
	output	[15999:0]  taps;

	wire [15:0] sub_wire0;
	wire [15999:0] sub_wire1;
	wire [15:0] shiftout = sub_wire0[15:0];
	wire [15999:0] taps = sub_wire1[15999:0];

	altshift_taps	ALTSHIFT_TAPS_component (
				.clock (clock),
				.shiftin (shiftin),
				.shiftout (sub_wire0),
				.taps (sub_wire1)
				// synopsys translate_off
				,
				.aclr (),
				.clken (),
				.sclr ()
				// synopsys translate_on
				);
	defparam
		ALTSHIFT_TAPS_component.intended_device_family = "Cyclone V",
		ALTSHIFT_TAPS_component.lpm_hint = "RAM_BLOCK_TYPE=MLAB",
		ALTSHIFT_TAPS_component.lpm_type = "altshift_taps",
		ALTSHIFT_TAPS_component.number_of_taps = 1000,
		ALTSHIFT_TAPS_component.tap_distance = 8,
		ALTSHIFT_TAPS_component.width = 16;


endmodule

// ============================================================
// CNX file retrieval info
// ============================================================
// Retrieval info: PRIVATE: ACLR NUMERIC "0"
// Retrieval info: PRIVATE: CLKEN NUMERIC "0"
// Retrieval info: PRIVATE: GROUP_TAPS NUMERIC "0"
// Retrieval info: PRIVATE: INTENDED_DEVICE_FAMILY STRING "Cyclone V"
// Retrieval info: PRIVATE: NUMBER_OF_TAPS NUMERIC "1000"
// Retrieval info: PRIVATE: RAM_BLOCK_TYPE NUMERIC "0"
// Retrieval info: PRIVATE: SYNTH_WRAPPER_GEN_POSTFIX STRING "0"
// Retrieval info: PRIVATE: TAP_DISTANCE NUMERIC "8"
// Retrieval info: PRIVATE: WIDTH NUMERIC "16"
// Retrieval info: LIBRARY: altera_mf altera_mf.altera_mf_components.all
// Retrieval info: CONSTANT: INTENDED_DEVICE_FAMILY STRING "Cyclone V"
// Retrieval info: CONSTANT: LPM_HINT STRING "RAM_BLOCK_TYPE=MLAB"
// Retrieval info: CONSTANT: LPM_TYPE STRING "altshift_taps"
// Retrieval info: CONSTANT: NUMBER_OF_TAPS NUMERIC "1000"
// Retrieval info: CONSTANT: TAP_DISTANCE NUMERIC "8"
// Retrieval info: CONSTANT: WIDTH NUMERIC "16"
// Retrieval info: USED_PORT: clock 0 0 0 0 INPUT NODEFVAL "clock"
// Retrieval info: USED_PORT: shiftin 0 0 16 0 INPUT NODEFVAL "shiftin[15..0]"
// Retrieval info: USED_PORT: shiftout 0 0 16 0 OUTPUT NODEFVAL "shiftout[15..0]"
// Retrieval info: USED_PORT: taps 0 0 16000 0 OUTPUT NODEFVAL "taps[15999..0]"
// Retrieval info: CONNECT: @clock 0 0 0 0 clock 0 0 0 0
// Retrieval info: CONNECT: @shiftin 0 0 16 0 shiftin 0 0 16 0
// Retrieval info: CONNECT: shiftout 0 0 16 0 @shiftout 0 0 16 0
// Retrieval info: CONNECT: taps 0 0 16000 0 @taps 0 0 16000 0
// Retrieval info: GEN_FILE: TYPE_NORMAL echoshift.v TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL echoshift.inc FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL echoshift.cmp FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL echoshift.bsf FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL echoshift_inst.v FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL echoshift_bb.v FALSE
// Retrieval info: LIB_FILE: altera_mf
