`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 		UdS
// Engineer: 		Peter Jose
// 
// Create Date:    	09:35:46 09/08/2022 
// Design Name: 	multiplication
// Module Name:    	multiplier 
// Project Name: 	multiplication
// Target Devices:  Basys2
// Tool versions: 	ISE P.68d
// Description: 	Multiplies two numbers
//
// Dependencies: 	
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module multiplier#(parameter M = 3,
				parameter N = 4)(
	input clk,						// clock
	input [M-1:0] multiplier,		// multiplier with M as width
	input [N-1:0] multiplicand,		// multiplicand with N as width
	input en,						// enable to start
	output reg done,				// done flag
	output reg [M+N-1:0] product	// product output
    );
	
	reg[N:0] index;
	reg[M+N-1:0] product_out;

	initial
	begin
		product <= 0;
		done <= 0;
		index <= 0;
		product_out <= 0;
	end
	
	always @ (posedge clk)
	begin
		if (en == 1)
			if (done == 0)
				if(index < N) 
				begin
					if(multiplicand[index] ==1'b1)
						product_out = product_out +  (multiplier << index);
					index <= index+1;
				end
				else
				begin
					done <=1;
					index <= 0;
					product <= product_out;
				end
		else
		begin
			done <= 0;
			index <= 0;
			product <= 0;
		end
	end

// One clock cycle
//	always @ (posedge clk)
//	begin
//		if (en == 1)
//		begin
//			if (done == 0)
//			begin
//				for ( index = 0; index < 4 ; index = index +1) begin
//					if(multiplicand[index] ==1'b1)
//					begin
//						product = product +  (multiplier << index);
//					end
//				end
//				done <=1;
//			end
//		end
//		else
//		begin
//			product <= 0;
//			done <= 0;
//		end
//	end	

endmodule
