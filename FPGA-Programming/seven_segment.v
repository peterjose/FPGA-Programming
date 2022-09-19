`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 		UdS
// Engineer: 		Peter Jose
// 
// Create Date:    	15:02:17 09/14/2022 
// Design Name: 	Seven segment display
// Module Name:    	seven_segment 
// Project Name: 	Displays
// Target Devices:  Artix7
// Tool versions: 	ISE P.68d
// Description: 	Custom made seven segment display, pin numbers are mentioned in 
//					nexys_hdmi.ucf	
//
// Dependencies: 	nexys_hdmi.ucf
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module seven_segment(
		input clk,						// clock input
		input [3:0] number,				// number to be displayed
		input [1:0] anode_selector,		// anode to be selected
		output reg [6:0] seg,			// seven segment display output register
		output reg [3:0] an				// anode output register
    );
	 
	// always block working on positive clock
	always @ (posedge clk)
	begin
		// anode selector logic
		an <= ~(4'b1 << anode_selector);
		// display number to seven segment display mapping
		case(number)
			0 : seg <= 7'b0111111;
			1 : seg <= 7'b0000110;
			2 : seg <= 7'b1011011;
			3 : seg <= 7'b1001111;
			4 : seg <= 7'b1100110;
			5 : seg <= 7'b1101101;
			6 : seg <= 7'b1111101;
			7 : seg <= 7'b0000111;
			8 : seg <= 7'b1111111;
			9 : seg <= 7'b1101111;
			default: seg <= 7'b0000000;
		endcase
	end

endmodule 