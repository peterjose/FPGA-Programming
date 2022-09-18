%> @file   global_dimming.m
%> @brief  File implements Global Dimming function
%> @author Peter Jose
%> @date   14/09/2022
% ======================================================================

% test call
% global_dimming_fcn('test_picture.jpg',2.2);


%======================================================================
%> @brief Function to do global dimming
%>
%> 
%>
%> @param i    file path of the image to be processed
%======================================================================
function global_dimming_fcn(i,gamma)
    % Read image
    img = imread(i);
    
    % rescale the image to a range between 0 to 1
    proc_img = double(img(:,:))/255; 
    
    % gamma compensation
    proc_img = proc_img.^gamma;
    
    % find the max value
    max_val = max(max(proc_img(:,:)));

    % process the image to compensate with max value
    proc_img = (proc_img(:,:)/max_val);
    
    %degamma the image
    proc_img = proc_img.^(1/gamma);
    
    % rescale the image back to a range of 0 to 255
    proc_img = uint8(proc_img(:,:)*255);
    
    % display the images
    figure
    imshow(img)
	figure
    imshow(proc_img);
    max_val
    
end

% EOF 