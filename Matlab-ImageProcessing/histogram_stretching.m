%> @file   histogram_stretching.m
%> @brief  File implements histogram stretching function
%> @author Peter Jose
%> @date   02/09/2022
% ======================================================================

% test call
% stretching('test_picture.jpg',6,2);


%======================================================================
%> @brief Function to do histogram stretching
%>
%> 
%>
%> @param i    file path of the image to be processed
%> @param c_1  brightness setting
%> @param c_2  contrast setting
%>
%> @retval proc_img  return processed image
%> @retval orig_hist_plt  return histogram of original image
%> @retval proc_hist_plt return histogram of processed image
%======================================================================
function [proc_img, orig_hist_plt, proc_hist_plt] = stretching(i,c_1,c_2)
    % create counting bin to store count of 0 to 255 grey values
    % to store histogram values of original image
    original_hist =  zeros(1,256); 
    % to store histogram values of processed image
    proc_hist = zeros(1,256);
    
    % read the image to img
    img = imread(i);

    % process the histogram stretching
    proc_img = max(min(((img + c_1)*c_2), 255),0);

    % looping through all the possible values of grey values to create
    % histogram for the original and processed image
    for index = 1:length(original_hist)
        original_hist(index) = sum(img(:) == index-1);
        proc_hist(index) = sum(proc_img(:) == index-1);
    end
    % @endfor
    
    % Image and histogram creation
    figure
    imshow(proc_img);
    figure
    orig_hist_plt = area(0:255,original_hist);
    figure
    proc_hist_plt = area(0:255,proc_hist);
    
    % get the filepath and name to create a the new file name 
    [fpath,fname] = fileparts(i);
        [fpath,fname] = fileparts(i);

    % save the image in jpg format
    imwrite(proc_img, ...
        strcat(fpath,'/', fname,'_processed_c1_',num2str(c_1,'%d'),'_c2_',num2str(c_2,'%d'),'.jpg'),'jpg');
    saveas(orig_hist_plt, ...
        strcat(fpath,'/', fname,'_original_hist_c1_',num2str(c_1,'%d'),'_c2_',num2str(c_2,'%d'),'.jpg'),'jpg')
    saveas(proc_hist_plt, ...
        strcat(fpath,'/', fname,'_processed_hist_c1_',num2str(c_1,'%d'),'_c2_',num2str(c_2,'%d'),'.jpg'),'jpg');
    
end
% @endfunction

% EOF 