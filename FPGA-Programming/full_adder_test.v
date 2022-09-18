`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company:		  UdS
// Engineer: 	  Peter Jose
//
// Create Date:   13:48:28 09/06/2022
// Design Name:   full_adder
// Module Name:   full_adder_test.v
// Project Name:  PeterJose
// Target Device: Basys2
// Tool versions: ISE P.68d
// Description:   Test bench for full adder
//
// Verilog Test Fixture created by ISE for module: full_adder
//
// Dependencies:  full_adder
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module full_adder_test;

	// Inputs
	reg A;
	reg B;
	reg C0;

	// Outputs
	wire S;
	wire C1;

	// Instantiate the Unit Under Test (UUT)
	full_adder uut (
		.A(A), 
		.B(B), 
		.C0(C0), 
		.S(S), 
		.C1(C1)
	);

	initial begin
		// Initialize Inputs
		A = 0;
		B = 0;
		C0 = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
        A = 1;
		B = 1;
		C0 = 0;
		#200;
		A = 0;
		B = 1;
		C0 = 0;
		#200;
		A = 0;
		B = 1;
		C0 = 1;
		#200;

	end
      
endmodule 