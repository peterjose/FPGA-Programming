# LME Saarland University
Micro Electronics Lab - course work 2022

Implemented few basic Matlab and FPGA modules for Image processing

FPGA modules are implemented based on two boards:
* Basys2
* Artix7

Display used for the test procedures is having a resolution of 1024*600. More technical details can be found at [link](https://www.elecrow.com/download/7inch_1024x600_Specifications.pdf)

## Example codes:
* Matlab
  * Colour Graying: 3 channel image to a single channel image; [colour_graying.m](Matlab-ImageProcessing/colour_graying.m)
  * Histogram Stretching: Histogram stretching of a grayscale image; [histogram_stretching.m](Matlab-ImageProcessing/histogram_stretching.m)
  * Histogram Equalisation: Histogram Equalisation of a grayscale image; [histogram_equalisation.m](Matlab-ImageProcessing/histogram_equalisation.m)
  * Global dimming: Applies the global dimming algorithm on a grayscale image; [global_dimming.m](Matlab-ImageProcessing/global_dimming.m)
  * Gamma Coe: File to generate gamma and inverse gamma (degamma) values into a .coe file for FPGA; [gamma_coe.m](Matlab-ImageProcessing/gamma_coe.m)
  * Test image for Gamma Measurement: File to generate test image set for gamma measurement; [test_image_generator](Matlab-ImageProcessing/test_image_generator)
 
* FPGA
  * Basic control: Switch based LED control; [switch_led_control.v](FPGA-Programming/switch_led_control.v)
  * Adder: Full adder; [full_adder.v](FPGA-Programming/full_adder.v)
  * Adder: Ripple adder; [ripple_adder.v](FPGA-Programming/ripple_adder.v)
  * Mutliplication: Multiplier; [multiplier.v](FPGA-Programming/multiplier.v)
  * Counter: Up down counter; [counter.v](FPGA-Programming/counter.v)
  * Counter: Prescaled counter; [prescaled_counter.v](FPGA-Programming/prescaled_counter.v)
  * Counter: Counter on 7 segment display; [counter_7segment_display.v](FPGA-Programming/counter_7segment_display.v)
  * Seven Segment display: Seven segment display module; [seven_segment_display.v](FPGA-Programming/seven_segment_display.v)
  * PWM: PWM generator; [pwm_generator.v](FPGA-Programming/pwm_generator.v)
  * PWM: PWM top modlue; [PWM_topModule.v](FPGA-Programming/PWM_topModule.v)
  * Pipeline manipulation: Pipeline manipulation by selecting the channel and to replace with max value if configured; [pipeline_manipulation.v](FPGA-Programming/pipeline_manipulation.v)
  * Pipeline manipulation: Pipeline manipulation by replacing pixels to demonstrate gradient; [pipeline_manipulation_gradient.v](FPGA-Programming/pipeline_manipulation_gradient.v)
  * Pipeline manipulation: Pipeline manipulation by show max frame pixels value; [frame_maximum_gray_value.v](FPGA-Programming/frame_maximum_gray_value.v)
  * Pipeline manipulation: Pipeline manipulation by gamma correction; [pipeline_manipulation_gamma_correction.v](FPGA-Programming/pipeline_manipulation_gamma_correction.v)
  * Pipeline manipulation: Pipeline manipulation by gamma correction with back light; [pipeline_manip_gamma_correction_with_bklight_ctrl.v](FPGA-Programming/pipeline_manip_gamma_correction_with_bklight_ctrl.v)
  * Pipeline manipulation: Pipeline manipulation by gamma correction with back light and pixel compensation; [pipeline_manip_gamma_correction_with_bklight_ctrl_px_comp.v](FPGA-Programming/pipeline_manip_gamma_correction_with_bklight_ctrl_px_comp.v)
