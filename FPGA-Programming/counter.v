`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 	   UdS
// Engineer: 	   Peter Jose
// 
// Create Date:    08:47:58 09/08/2022 
// Design Name:    Up Down counter
// Module Name:    counter 
// Project Name:   12 bit counter
// Target Devices: Basys2
// Tool versions:  ISE P.68d
// Description:    12bit counter module
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module counter(
	input clk,					// clock
	input init,					// To reset to initial value
	input enable,				// enable/disable input 
	input downCounter,			// input to control the direction of the counting
	output reg [11:0] out   	// output
    );

	// Intial block
	initial begin
		out <= 12'b0;
	end

	// always block works on positive clock
	always @(posedge clk)
	begin
		if (init == 1) 			// if init is given reset to the initial value
			out <= 12'b0 ;
		else if (enable == 1)   // if enabled start counting
			out <= (downCounter == 1) ? (out - 1) : (out + 1);
		// over flow is automatically taken care
		// if needed can include the explicit code for over flow and underflows
	end
endmodule