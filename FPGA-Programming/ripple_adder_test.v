`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 	   UdS
// Engineer: 	   Peter Jose
//
// Create Date:    16:22:10 09/06/2022
// Design Name:    ripple_adder
// Module Name:    ripple_adder_test.v
// Project Name:   PeterJose
// Target Device:  Basys2
// Tool versions:  ISE P.68d
// Description:    Ripple Adder Test bench
//
// Verilog Test Fixture created by ISE for module: ripple_adder
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module ripple_adder_test;

	// Inputs
	reg [39:0] A;
	reg [39:0] B;
	reg C_in;

	// Outputs
	wire [39:0] S;
	wire C_out;

	// Instantiate the Unit Under Test (UUT)
	ripple_adder uut (
		.A(A), 
		.B(B), 
		.C_in(C_in), 
		.S(S), 
		.C_out(C_out)
	);

	initial begin
		// Initialize Inputs
		A = 40'd0011;
		B = 40'd1111;
		C_in = 0;

		// Wait 100 ns for global reset to finish
		#100;
		// Add stimulus here
		A = ~0;
		B = ~0;
		C_in = 1;
		#100;		
		A = ~0;
		B = ~0;
		C_in = 0;
 
	end
      
endmodule

