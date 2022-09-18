%> @file   histogram_equalisation.m
%> @brief  File implements Histogram equalisation function
%> @author Peter Jose
%> @date   02/09/2022
% ======================================================================

% test call
% histequal('test_picture.jpg');


%======================================================================
%> @brief Function to do histogram equalisation
%>
%> 
%>
%> @param i    file path of the image to be processed
%======================================================================
function histequal(i)
    % create counting bin to store count of 0 to 255 grey values
    % to store histogram values of original image
    original_hist = zeros(1,256); 
    processed_hist = zeros(1,256); 
    substitution_matrix = zeros(1,256); 
    
    % read the image to img
    img = imread(i);
    
    % saving the value of gray value 0 separately to 
    % accomadate the for loop design 
    substitution_matrix(1) = sum(img(:) == 0);
    original_hist(1) = sum(img(:) == 0);
    % looping through all the possible values of grey values to create
    % cumulative histogram and histogram for the original image
    for index = 2:length(substitution_matrix)
        substitution_matrix(index) = (sum(img(:) == index-1) + ...
                                    substitution_matrix (index-1));
        original_hist(index) = sum(img(:) == index-1);
    end
    % @endfor

    % to find relavtive histogram find total and new subsitution matrix
    total_count = sum(img(:)>=0);
    substitution_matrix = uint8( ...
                        round((substitution_matrix/total_count)*255));
                    
  
    % store the original to the process image variable 
    % to start further processing
    proc_img = img;
    
    % do the subsitution method wrt to new subsitution matrix
    for index = 1:length(substitution_matrix)
        proc_img(img==(index-1)) = substitution_matrix(index);
    end
    % @endfor

    for index = 1:length(substitution_matrix)
        processed_hist(index) = sum(proc_img(:) == index-1);
    end
    % @endfor
    
    cum_matrix = zeros(1,256); 
    cum_matrix(1) = sum(proc_img(:) == 0);

    % looping through all the possible values of grey values to create
    % cumulative histogram and histogram for the original image
    for index = 2:length(cum_matrix)
        cum_matrix(index) = (sum(proc_img(:) == index-1) + ...
                                    cum_matrix (index-1));
    end

    subplot(2,2,1);
    % plot figure
    %figure
    imshow(proc_img)
    subplot(2,2,2);
    %figure
    area(0:255,cum_matrix);
    subplot(2,2,3);
    %figure
    original_hist_plot = area(0:255,original_hist);
    %figure
    subplot(2,2,4);
    proc_hist_plot = area(0:255,processed_hist);
    
    % get the filepath and name to create a the new file name 
    [fpath,fname] = fileparts(i);

    % save the image in jpg format
    imwrite(proc_img, ...
        strcat(fpath, '/',fname,'_processed.jpg'),'jpg');
    saveas(original_hist_plot, ...
        strcat(fpath, '/',fname,'_original_hist.jpg'),'jpg')
    saveas(proc_hist_plot, ...
        strcat(fpath, '/',fname,'_processed_hist.jpg'),'jpg');
end
% @endfunction

% EOF 