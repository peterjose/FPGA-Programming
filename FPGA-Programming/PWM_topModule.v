`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:03:09 09/13/2022 
// Design Name: 
// Module Name:    PWM_topModule 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module PWM_topModule(
		input refclkin_100,					// clock
		input reset,						// reset pin
		input sync_signal,					// sync_signal to resync the PWM value
		output pwm_signal					// pwm signal output
    );
	 
	reg [11:0] t_lsb = 12'd407;				// 12'd1629 for 60 Hz, 12'd407 for 240 Hz
	reg [9:0] pwm_value = 512;
	 
	pwm_generator pwm_mod (
		.clk(refclkin_100), 
		.reset(reset), 
		.sync_signal(sync_signal), 
		.pwm_value(pwm_value), 
		.t_lsb(t_lsb), 
		.pwm_signal(pwm_signal)
	);

endmodule
