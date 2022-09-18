# LME Saarland University
Micro Electronics Lab - course work 2022

Implemented few basic Matlab and FPGA modules for Image processing

FPGA modules are implemented based on two boards:
* Basys2
* Artix7

## Example codes:
* Matlab
  * Colour Graying: 3 channel image to a single channel image; [colour_graying.m](Matlab-ImageProcessing/colour_graying.m)
  * Histogram Stretching: Histogram stretching of a grayscale image; [histogram_stretching.m](Matlab-ImageProcessing/histogram_stretching.m)
  * Histogram Equalisation: Histogram Equalisation of a grayscale image; [histogram_equalisation.m](Matlab-ImageProcessing/histogram_equalisation.m)
  * Global dimming: Applies the global dimming algorithm on a grayscale image; [global_dimming.m](Matlab-ImageProcessing/global_dimming.m)
  * Gamma Coe: File to generate gamma and inverse gamma (degamma) values into a .coe file for FPGA; [gamma_coe.m](Matlab-ImageProcessing/gamma_coe.m)
  * Test image for Gamma Measurement: File to generate test image set for gamma measurement; [test_image_generator](Matlab-ImageProcessing/test_image_generator)
