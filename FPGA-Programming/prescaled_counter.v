`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 	   UdS
// Engineer: 	   Peter Jose
// 
// Create Date:    08:49:02 09/08/2022 
// Design Name:    Prescale counter
// Module Name:    prescaled_counter 
// Project Name:   Counter
// Target Devices: Basys2
// Tool versions:  ISE P.68d
// Description:    Prescaled counter outputed on the on board LEDs
//
// Dependencies:   counter  
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module prescaled_counter(
	input clk,
	input en,
	input reset,
	output [7:0] LED);
	 
reg [24:0] prescaler = 0;
reg init = 0;
wire [11:0] counter_out;
assign LED = counter_out[7:0];

always @(posedge clk)
begin
	if (en == 1)
		prescaler <= prescaler+1;
	if (reset == 1)
	begin
		prescaler <=0;
		init <= 1;
	end
	else
		init <= 0;		
end

// Instantiate counter for prescaler
counter prescale_counter(
	.clk(clk),
	.init(init),
	.enable(!prescaler),
	.downCounter(0),
	.out(counter_out)
	 );
	 
endmodule 