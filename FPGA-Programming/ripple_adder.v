`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 	   UdS
// Engineer:       Peter Jose
// 
// Create Date:    13:53:49 09/06/2022 
// Design Name:    Ripple Adder
// Module Name:    ripple_adder 
// Project Name:   Adder
// Target Devices: Basys2
// Tool versions:  ISE P.68d
// Description:    Ripple Carry adder with 
//
// Dependencies:   full_adder
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

// Default adder binary size is set to 40 bits
module ripple_adder #(parameter ADDER_WIDTH = 40)(
	input [ADDER_WIDTH-1:0]A,
	input [ADDER_WIDTH-1:0]B,
	input C_in,
	output [ADDER_WIDTH-1:0]S,
	output C_out
    );

// carry bit that is maintained internally
wire [ADDER_WIDTH:0] C_internal;
assign C_internal[0] = C_in;
assign C_out = C_internal[ADDER_WIDTH];

genvar index ;
generate
	for ( index = 0; index < ADDER_WIDTH; index = index +1)
		begin : gen_code_label
			full_adder adder(
				.A (A[index]) ,
				.B (B[index]) ,
				.C0(C_internal[index]) ,
				.S (S[index]),
				.C1(C_internal[index+1])
			);
		end
endgenerate

endmodule 
