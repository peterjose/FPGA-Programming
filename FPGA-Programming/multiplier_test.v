`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 		UdS
// Engineer:		Peter Jose
//
// Create Date:   	11:11:28 09/08/2022
// Design Name:   	multiplier
// Module Name:   	multiplier_test.v
// Project Name:  	multiplier
// Target Device:  	Basys2
// Tool versions:  	ISE P.68d
// Description: 	Test bench for multiplication
//
// Verilog Test Fixture created by ISE for module: multiplier
//
// Dependencies:	multiplier
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module multiplier_test;

	// Inputs
	reg clk;
	reg [2:0] multiplier;
	reg [3:0] multiplicand;
	reg en;

	// Outputs
	wire done;
	wire [6:0] product;

	// Instantiate the Unit Under Test (UUT)
	multiplier uut (
		.clk(clk), 
		.multiplier(multiplier), 
		.multiplicand(multiplicand), 
		.en(en), 
		.done(done), 
		.product(product)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		multiplier = 0;
		multiplicand = 0;
		en = 0;

		// Wait 100 ns for global reset to finish
		#100;
		en = 1;
		multiplier = 3'b1;
		multiplicand = 4'b1111;   
		#20;
		en = 0;
		#20;
		en = 1;
		multiplier = 3'b111;
		multiplicand = 4'b1111;  
		// Add stimulus here
		
	end

	always
	begin
		clk =~clk;
		#10;
	end
      
      
endmodule

