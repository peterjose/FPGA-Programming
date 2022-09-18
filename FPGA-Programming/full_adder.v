`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 	   UdS
// Engineer:       Peter Jose
// 
// Create Date:    13:47:46 09/06/2022 
// Design Name:    Full adder implementation
// Module Name:    full_adder 
// Project Name:   Full adder
// Target Devices: Basys2
// Tool versions:  ISE P.68d
// Description:    Binary full adder considering two one bit input and a carry bit
//				   Output is 1 bit with a carry
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module full_adder(
		input A,
		input B,
		input C0,
		output reg S,
		output reg C1
    );

always @(*)
begin
	S <= (~A&~B&C0)|(~A&B&~C0)|(A&~B&~C0)|(A&B&C0);
	C1 <= (~A&B&C0)|(A&~B&C0)|(A&B);
end

endmodule