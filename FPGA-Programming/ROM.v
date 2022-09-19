`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 		UdS
// Engineer: 		LME
// 
// Create Date:     15:50:47 09/15/2022 
// Design Name: 	
// Module Name:    	ROM 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module ROM #(
	parameter ROM_PATH = " PATH_TO_COE " ,
	parameter DATA_WIDTH = 10 ,
	parameter ADDR_WIDTH = 8 ,
	parameter LAST_ADDR = 255)
	(
		input clk ,
		input [ ADDR_WIDTH - 1:0] addr ,
		output reg [ DATA_WIDTH - 1:0] dout
	);
	
	reg [ DATA_WIDTH - 1:0] rom [0 : LAST_ADDR ];

	initial begin
		$readmemb ( ROM_PATH , rom , 0 , LAST_ADDR ) ;
	end
	
	always @ ( posedge clk )
	begin
		dout <= rom [ addr ];
	end
	
endmodule 