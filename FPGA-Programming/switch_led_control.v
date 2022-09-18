`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:50:24 09/06/2022 
// Design Name:    Switch LED control
// Module Name:    switch_led_control 
// Project Name:   Basic control
// Target Devices: Basys2
// Tool versions:  ISE P.68d
// Description:    Control on board LEDs using on board Switches
//
// Dependencies:   basys_loc.ucf
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module switch_led_control(
    output reg [7:0] LED = 8'd255,
    input [7:0] SW
    );

// always block activated based on switch input
always @(SW)
begin
	LED <= SW;
end

endmodule
