`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 	   UdS
// Engineer: 	   Peter Jose
// 
// Create Date:    18:17:14 09/12/2022 
// Design Name:    BCD counter
// Module Name:    counter_7segment_display 
// Project Name:   Counter
// Target Devices: Basys2
// Tool versions:  ISE P.68d
// Description:    Counter with BCD algorithm implemented to count from a initial
//                 value set from the switch and have an option to reset using switch 
// 					 
//
// Dependencies:   seven_segment
//
// Revision:       
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module counter_7segment_display(
	input clk,							// clock
	input reset,						// reset pin
	input [7:0] SW,						// input from switch
	output [6:0] seg,					// seven segment map
	output [3:0] an						// anode selector
   );

	// Registers
	reg [1:0] an_selected = 0; 			// select the anode of the 7 segment display
	reg [13:0] count = 0;				//	counter
	reg [30:0] base = 0;				// base to shift the count to find BCD
	reg [3:0] digit = 0;				// 7 segment display digit
	reg [3:0] digit_1_out = 0; 			// ones place output
	reg [3:0] digit_10_out = 0; 		// tens place output
	reg [3:0] digit_100_out = 0; 		// hunderds place output
	reg [3:0] digit_1000_out = 0; 		// thousands place output
	reg [14:0] prescaler = 1;			// prescaler for refreshing the 7 segment output
	reg [23:0] prescaler_counter = 1;	// prescaler for counter
	reg [3:0] shift_index = 0; 			// index for bit counting
	reg flag = 0;						// flag for adding

	// Initial block
	initial begin
		count[7:0] = SW;
	end

	// always block work on positive clock
	always @(posedge clk)
	begin
		// if reset is not set
		if(reset != 1)
		begin
			// counter prescaler
			if (prescaler_counter == 0)
			begin
				// to avoid overflow on the display
				if (count == 15'd9999)
					count <= 0;
				else
					count <= 1+count; // increment the counter
				
				// reset the shift_index 
				shift_index <= 0;
				base[30:14] <= 17'b0;
				base[13:0] <= count;
			end
			// BCD algorihm
			else if(shift_index < 14)
			begin
				if(flag)
				begin
					// add + 3 if value is greater than or equal to 5
					base[17:14] <= base[17:14] + {2{base[17:14] >= 4'b0101}};
					base[21:18] <= base[21:18] + {2{base[21:18] >= 4'b0101}};
					base[25:22] <= base[25:22] + {2{base[25:22] >= 4'b0101}};
					base[29:26] <= base[29:26] + {2{base[29:26] >= 4'b0101}};
				end
				else
				begin
					// increment the shift_index and shift the base register
					shift_index <= shift_index +1;
					base <= base << 1;
				end
				flag <= ~flag;
			end
			// load values to the output registers
			else if (shift_index == 14)
			begin
				digit_1_out <= base[17:14]; 		// ones place
				digit_10_out <= base[21:18]; 		// tens place
				digit_100_out <= base[25:22];		// hunderds place
				digit_1000_out <= base[29:26]; 	    // thousands place
			end

			// based on the an selected choose the digit
			case (an_selected)
				0: digit <= digit_1_out;		// when anode corresponding to unit place
				1: digit <= digit_10_out;		// when anode corresponding to tens place
				2: digit <= digit_100_out;		// when anode corresponding to hundreds place
				3: digit <= digit_1000_out;     // when anode corresponding to thousands place
			endcase

			// choose next an
			if (prescaler == 0)
				an_selected <= 1+an_selected;
			// increment the prescalers
			prescaler <= prescaler + 1;
			prescaler_counter <= prescaler_counter + 1;
		end
		else
		begin
			count <= SW;
			an_selected <= 0;
			prescaler <= 0;
			prescaler_counter <= 0;
		end
	end

	// submodule call
	seven_segment segment(
		.clk(clk),
		.number(digit),
		.anode_selector(an_selected),
		.seg(seg),
		.an(an)		
		);

endmodule
