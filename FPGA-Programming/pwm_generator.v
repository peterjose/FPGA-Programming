`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 	   UdS
// Engineer: 	   Peter Jose
// 
// Create Date:    10:40:20 09/13/2022 
// Design Name:    Experiment III
// Module Name:    pwm_generator 
// Project Name:   PWM Module
// Target Devices: Artix 7
// Tool versions:  ISE P.68d
// Description:    Module to generate PWM
//
// Dependencies:   
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module pwm_generator #(parameter PWM_RES = 10)(
		input clk,							// clock
		input reset,						// reset pin
		input sync_signal,					// sync_signal to resync the PWM value
		input [PWM_RES-1:0] pwm_value,		// pwm_value
		input [11:0] t_lsb,					// t_lsb to syn with the clock
		output reg pwm_signal				// pwm signal output
    );
	 
	// Registers
	reg [11:0] clk_cycle_counter;
	reg [PWM_RES-1:0] pwm_bit_counter;
	reg [PWM_RES:0] pwm_current_set_value; 
	
	// Initial block
	initial
	begin
		clk_cycle_counter = 0;
		pwm_bit_counter = 1;
		pwm_signal = 0;
		pwm_current_set_value = pwm_value;
	end

	// always block works with positive clock 
	always @(posedge clk)
	begin
		// when reset or sync button is pressed
		if (reset == 1 || sync_signal == 1)
		begin
			pwm_bit_counter <= 0;
			clk_cycle_counter <= 0;
			pwm_signal <= 0;
			// when sync button is pressed
			if (sync_signal == 1)
				pwm_current_set_value <= pwm_value;
		end
		else
		begin
			// count the clock cycles
			clk_cycle_counter <= clk_cycle_counter + 1;
			if(clk_cycle_counter == t_lsb)
			begin
				// Reset clk cycle count to zero
				clk_cycle_counter <= 0;
				if (pwm_bit_counter < 10'd1023)
					pwm_bit_counter <= pwm_bit_counter +1;
				else
					pwm_bit_counter <= 1;
				// Ton Toff control section
				pwm_signal <= (pwm_bit_counter <= pwm_current_set_value);
			end
		end
	end // @always end
	
endmodule
