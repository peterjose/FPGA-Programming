`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 	  UdS
// Engineer:	  Peter Jose
//
// Create Date:   11:26:27 09/13/2022
// Design Name:   pwm_generator
// Module Name:   pwm_generator_test.v
// Project Name:  PeterJose_Exp3
// Target Device: Artix7
// Tool versions: ISE P.68d
// Description:   Test bench for PWM module
//
// Verilog Test Fixture created by ISE for module: pwm_generator
//
// Dependencies:  pwm_generator
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module pwm_generator_test;

	// Inputs
	reg clk;
	reg reset;
	reg sync_signal;
	reg [9:0] pwm_value;
	reg [11:0] t_lsb;

	// Outputs
	wire pwm_signal;

	// Instantiate the Unit Under Test (UUT)
	pwm_generator uut (
		.clk(clk), 
		.reset(reset), 
		.sync_signal(sync_signal), 
		.pwm_value(pwm_value), 
		.t_lsb(t_lsb), 
		.pwm_signal(pwm_signal)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		sync_signal = 1;
		reset = 0;
		pwm_value = 500;
		t_lsb = 2;
		
		// Wait 100 ns for global reset to finish
		#100;
     	sync_signal = 0;
		// Add stimulus here

	end
	
	always 
	begin
		#10
		clk = ~clk;
	end
      
endmodule

