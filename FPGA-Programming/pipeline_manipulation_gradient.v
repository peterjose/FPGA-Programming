`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:		   UdS
// Engineer: 	   Peter Jose
// 
// Create Date:    11:44:45 09/15/2022 
// Design Name:    RGB channel filtering using FPGA with Black light brigtness control
// Module Name:    pipeline_manipulation_gradient 
// Project Name:   Displays
// Target Devices: Artix7
// Tool versions:  ISE
// Description:    The screen displays patches of gradient of from 0 to 255    
//				   Based on the switch input the filtering of RGB is controlled
//				   SW 0 RED 
//				   SW 1 GREEN
//				   SW 2 BLUE
//
//  			   Back light PWM is controlled using the switch setting given via SW7 to SW3
//
// Dependencies:   HDMI_IO_Interface, pwm_generator
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module pipeline_manipulation_gradient(
    input refclkin_100, // 100 MHz
    output reg hdmi_rx_txen = 1'b1,
    output reg hdmi_hpd = 1'b1,
    output [7:0]led,
    input reset, // reset DVI decoder
    input [7:0] sw,
    input BTN_U, // reset PLL/MMCM (sysclock)
    
    // HDMI in
    input TMDS_IN_clk_p,
    input TMDS_IN_clk_n,
    input [2:0] TMDS_IN_data_n,
    input [2:0] TMDS_IN_data_p,
	 inout edid_sda_io,
	 input edid_scl_in,
	
    //	HDMI out
    output TMDS_OUT_clk_p,
    output TMDS_OUT_clk_n,
    output [2:0] TMDS_OUT_data_p,
    output [2:0] TMDS_OUT_data_n,
	 
	 // PWM
	 input reset_PWM,
	 input sync_signal,
	 output pwm_signal,
	 
);

// Registers to store the RGB decoder values
// Maintained to avoid the combinatory logic in assign 
reg [7:0] r_from_decoder_out,g_from_decoder_out,b_from_decoder_out;
reg de_from_decoder_out;
reg [7:0] counter;

// internal signals
wire [7:0] r_from_decoder,g_from_decoder,b_from_decoder;
wire de_from_decoder,vsync_from_decoder,hsync_from_decoder;
wire p_clock_from_decoder;
wire MMCM_refclk_locked;
wire p_clock_from_decoder_locked;

// connect input to output of IO-Blackbox 
wire [7:0] r_to_encoder = r_from_decoder_out;
wire [7:0] g_to_encoder = g_from_decoder_out; 
wire [7:0] b_to_encoder = b_from_decoder_out;
wire de_to_encoder = de_from_decoder_out;
wire vsync_to_encoder = vsync_from_decoder;
wire hsync_to_encoder = hsync_from_decoder; 


// debug LEDs
assign led[0] = MMCM_refclk_locked;
assign led[1] = de_from_decoder;
assign led[2] = vsync_from_decoder;
assign led[3] = hsync_from_decoder;
assign led[4] = p_clock_from_decoder_locked;
assign led[5] = r_from_decoder > 1 ? 1 : 0;
assign led[6] = g_from_decoder > 1 ? 1 : 0;
assign led[7] = b_from_decoder > 1 ? 1 : 0;

// for pwm
reg [11:0] t_lsb = 12'd407;				// 12'd1629 for 60 Hz, 12'd407 for 240 Hz
reg [9:0] pwm_value = ~0;

// using combinatory logic on PWM will be like
// wire [9:0] pwm_value;
// assign pwm_value[9:6] = sw[7:4];

// Initial begin block
initial begin
	counter = 0;
end

// always block
always @(posedge p_clock_from_decoder)
begin
	if (sync_signal)
		pwm_value[9:6] <= sw[7:4];
	
	// output is controlled based on the signal
	// SW0 - RED
	// SW1 - GREEN
	// SW2 - BLUE
	// when Data enable is active

	// rest the counter when a hsync is received
	if(hsync_from_decoder == 1)
		counter <= 0;
	else if(de_from_decoder)
	begin
		counter <= counter+1;
		// store the counter to RGB
		r_from_decoder_out <= (sw[0] == 1) ? counter : 0;
		g_from_decoder_out <= (sw[1] == 1) ? counter : 0;
		b_from_decoder_out <= (sw[2] == 1) ? counter : 0;
	end
	else
	begin
		// bypass the blanking signals
		r_from_decoder_out <= (sw[0] == 1) ? r_from_decoder: 0;
		g_from_decoder_out <= (sw[1] == 1) ? g_from_decoder: 0;
		b_from_decoder_out <= (sw[2] == 1) ? b_from_decoder: 0;
	end
	de_from_decoder_out <= de_from_decoder;
end


// PWM generator module
pwm_generator pwm_gen (
	.clk(refclkin_100), 
	.reset(reset_PWM), 
	.sync_signal(sync_signal), 
	.pwm_value(pwm_value), 
	.t_lsb(t_lsb), 
	.pwm_signal(pwm_signal)
);

// HDMI input output
HDMI_IO_Interface HDMI_IO_Interface_internal (
    .refclk(refclkin_100), 
    .TMDS_IN_data_p_n({TMDS_IN_data_p,TMDS_IN_data_n}), 
    .TMDS_IN_clk_p_n({TMDS_IN_clk_p,TMDS_IN_clk_n}), 
    .edid_sda_io(edid_sda_io), 
    .edid_scl_in(edid_scl_in), 
	 
    .TMDS_OUT_clk_p_n({TMDS_OUT_clk_p,TMDS_OUT_clk_n}), 
    .TMDS_OUT_data_p_n({TMDS_OUT_data_p,TMDS_OUT_data_n}), 
    .reset_pll(BTN_U), 
    .reset_encoder_decoder(reset), 
	 
    .sync_signals_from_decoder({de_from_decoder,vsync_from_decoder,hsync_from_decoder}), 
    .RGB_from_decoder({r_from_decoder,g_from_decoder,b_from_decoder}), 
    .sync_signals_to_encoder({de_to_encoder,vsync_to_encoder,hsync_to_encoder}), 
    .RGB_to_encoder({r_to_encoder,g_to_encoder,b_to_encoder}), 
	 .p_clock_from_decoder(p_clock_from_decoder),
	 
    .refclock_locked(MMCM_refclk_locked), 
    .pclock_locked(p_clock_from_decoder_locked)
    );

endmodule