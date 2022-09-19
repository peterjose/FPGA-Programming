`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 		UdS
// Engineer: 		Peter Jose
// 
// Create Date:    	15:01:42 09/14/2022 
// Design Name: 	BCD seven segment display
// Module Name:    	seven_segment_display 
// Project Name: 	Displays
// Target Devices: 	Artix7
// Tool versions: 	ISE P.68d
// Description: 	Converts the number to BCD and display on 4 seven segment display
//
// Dependencies: 	seven_segment
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module seven_segment_display(
	input clk,							// clock
	input [13:0] number,				// number to be displayed
	output [6:0] seg,					// seven segment map
	output [3:0] an						// anode selector
   );

	// Registers
	reg [1:0] an_selected = 0; 			// select the anode of the 7 segment display
	reg [30:0] base = 0;				// base to shift the count to find BCD
	reg [3:0] digit = 0;				// 7 segment display digit
	reg [3:0] digit_1_out = 0; 			// ones place output
	reg [3:0] digit_10_out = 0; 		// tens place output
	reg [3:0] digit_100_out = 0; 		// hunderds place output
	reg [3:0] digit_1000_out = 0; 		// thousands place output
	reg [14:0] prescaler = 1;			// prescaler for refreshing the 7 segment output
	reg [3:0] shift_index = 0; 			// index for bit counting
	reg shift_flag = 0;					// flag for adding
	reg done_flag = 1;					// done flag		

	// always block work on positive clock
	always @(posedge clk)
	begin
		// BCD algorihm
		if(shift_index < 14)
		begin
			if(shift_flag)
			begin
				// add + 3 if value is greater than or equal to 5
				if (base[17:14] >= 4'b0101)
					base[17:14] <= base[17:14] + 4'b0011;
				if (base[21:18] >= 4'b0101)
					base[21:18] <= base[21:18] + 4'b0011;
				if (base[25:22] >= 4'b0101)
					base[25:22] <= base[25:22] + 4'b0011;
				if (base[29:26] >= 4'b0101)
					base[29:26] <= base[29:26] + 4'b0011;
			end
			else
			begin
				// increment the shift_index and shift the base register
				shift_index <= shift_index +1;
				base <= base << 1;
			end
			shift_flag <= ~shift_flag;
		end
		// load values to the output registers
		if (shift_index == 14)
		begin
			digit_1_out <= base[17:14]; 		// ones place
			digit_10_out <= base[21:18]; 		// tens place
			digit_100_out <= base[25:22];		// hunderds place
			digit_1000_out <= base[29:26]; 		// thousands place
			done_flag <= 1;
		end
		// counter prescaler
		if (done_flag == 1)
		begin
			// reset the shift_index 
			shift_index <= 0;
			base <= 31'b0;
			base[13:0] <= number;
			done_flag <= 0;
		end
		// based on the an selected choose the digit
		case (an_selected)
			3: digit <= digit_1_out;		// when anode corresponding to unit place
			2: digit <= digit_10_out;		// when anode corresponding to tens place
			1: digit <= digit_100_out;		// when anode corresponding to hundreds place
			0: digit <= digit_1000_out;  	// when anode corresponding to thousands place
		endcase
		// choose next an
		if (prescaler == 0)
			an_selected <= 1+an_selected;
		// increment the prescalers
		prescaler <= prescaler + 1;
	end

	// Instantiate submodule
	seven_segment segment(
			.clk(clk),
			.number(digit),
			.anode_selector(an_selected),
			.seg(seg),
			.an(an)		
		 );

endmodule