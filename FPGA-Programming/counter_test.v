`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 	  UdS
// Engineer:	  Peter Jose
//
// Create Date:   10:03:26 09/07/2022
// Design Name:   counter
// Module Name:   counter_test.v
// Project Name:  PeterJose
// Target Device: Basys2
// Tool versions: ISE P.68d
// Description:   Test bench for counter module
//
// Verilog Test Fixture created by ISE for module: counter
//
// Dependencies:  counter
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module counter_test;

	// Inputs
	reg clk;
	reg init;
	reg enable;
	reg downCounter;

	// Outputs
	wire [11:0] out;

	// Instantiate the Unit Under Test (UUT)
	counter uut (
		.clk(clk), 
		.init(init), 
		.enable(enable), 
		.downCounter(downCounter), 
		.out(out)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		init = 0;
		enable = 0;
		downCounter = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		enable = 1;
		// Wait 1000 ns for global reset to finish
		#1000;
		// count downwards
		downCounter = 1;
	end

	always begin
		clk<=~clk;
		#100;
	end
endmodule

