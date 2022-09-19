// Instantiation template for the provided netlist of HDMI connection
// Black box implementation provided by the lab
// code can be exposed
// Basic idea is HDMI input to FPGA is deserialised to RGB and sync signals
// and then serialise it back to HDMI output

module HDMI_IO_Interface(
    input refclk,
    input [5:0] TMDS_IN_data_p_n,
    input [1:0] TMDS_IN_clk_p_n,
    inout edid_sda_io,
    input edid_scl_in,
    output [1:0] TMDS_OUT_clk_p_n,
    output [5:0] TMDS_OUT_data_p_n,
    input reset_pll,
    input reset_encoder_decoder,
	 
    output [2:0] sync_signals_from_decoder,
    output [23:0] RGB_from_decoder,
    input [2:0] sync_signals_to_encoder,
    input [23:0] RGB_to_encoder,
	 
	 output p_clock_from_decoder,
	 
    output refclock_locked,
    output pclock_locked
    );
endmodule
