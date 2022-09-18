%> @file   test_image_generator.m
%> @brief  file to generate test images with different gray value for 
%>         evaluating gamma correction using spectorometer 
%> @author Peter Jose
%> @date   14/09/2022
% ======================================================================

img = uint8(zeros(600,1024,3));
for val = 0:32
    img(:,:,:) = (val*8)-1;
    imwrite(img,strcat('image_1024x600_grayvalue_',num2str((val*8)-1,'%d'),'.png'),'png')
end

% EOF 