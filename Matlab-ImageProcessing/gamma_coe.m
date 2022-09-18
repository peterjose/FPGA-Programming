%> @file   gamma_coe.m
%> @brief  File to generate coe file from gamma for FPGA
%> @author Peter Jose
%> @date   14/09/2022
% ======================================================================

GAMMA = 2.2;
MAX_GRAYVALUE_ADDR = 256;
MAX_GAMMA_ADDR = 1024;

% ======================================================================
% Gamma correction
% ======================================================================

gamma_curve = 0:MAX_GRAYVALUE_ADDR-1;
gamma_curve = gamma_curve/(MAX_GRAYVALUE_ADDR-1);
gamma_applied = gamma_curve.^GAMMA;
gamma_applied_bit  = uint16(gamma_applied * (MAX_GAMMA_ADDR-1));
gamma_applied_bit_bin = dec2bin(gamma_applied_bit,log2(MAX_GAMMA_ADDR));
fileID = fopen('/gamma.coe','w');
for i= 1:size(gamma_applied_bit_bin)
    fprintf(fileID,'%s\n',gamma_applied_bit_bin(i,:));
end
fclose(fileID);

% ======================================================================
% Inverse gamma correction
% ======================================================================

inverse_gamma_curve = 0:MAX_GAMMA_ADDR-1;
inverse_gamma_applied = (double(inverse_gamma_curve))/(MAX_GAMMA_ADDR-1);
inverse_gamma_applied = inverse_gamma_applied.^(1/GAMMA);
inverse_gamma_applied = uint8(inverse_gamma_applied * (MAX_GRAYVALUE_ADDR-1));
inverse_gamma_applied_bin = dec2bin(inverse_gamma_applied,log2(MAX_GRAYVALUE_ADDR));
fileID = fopen('/inverse_gamma.coe','w');
for i= 1:size(inverse_gamma_applied_bin)
    fprintf(fileID,'%s\n',inverse_gamma_applied_bin(i,:));
end
fclose(fileID);

% EOF 