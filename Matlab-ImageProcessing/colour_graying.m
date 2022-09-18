%> @file   colour_graying.m
%> @brief  Function implements colour graying functions
%> @author Peter Jose
%> @date   02/09/2022
% ======================================================================

% test call
% colour_graying('test_picture.jpg',3);

%======================================================================
%> @brief Function to do colour grading
%>
%>    Possible functionalities that are supported
%>    m = 1 : one channel method for green
%>    m = 2 : maximum value method
%>    m = 3 : mean value method
%>    m = 4 : mean square method
%>    m = 5 : channel weighting method
%>
%> @param i  file path of the image to be processed
%> @param m  method to be used
%======================================================================
function colour_graying(i,m)
    % read image for processing to img
    img = imread(i);

    % RGB values used for better code readability
    red = 1;
    green = 2;
    blue = 3;

    % switch case to choose the functionality based on the m value
    % supplied to the function
    switch m
        case 1
            % one channel method for green        
            proc_img = img(:,:,green);
        
        case 2
            % maximum value method
            proc_img = max(max(img(:,:,red), ...
                                    img(:,:,green),"omitnan"), ...
                                    img(:,:,blue),"omitnan");
        
        case 3
            % mean value method
            proc_img = uint8((double(img(:,:,red))  + ...
                                    double(img(:,:,green)) + ...
                                    double(img(:,:,blue)))/3);
        
        case 4
            % channel weighting method
            proc_img = uint8(sqrt( ...
                                    double( ...
                                        (((double(img(:,:,red))).^2) + ...
                                        ((double(img(:,:,green))).^2) + ...
                                        ((double(img(:,:,blue))).^2))/3 ...
                                        )));

        case 5
            % channel weighting method
            proc_img = ((0.2989*img(:,:,red)) + ...
                            (0.5870*img(:,:,green)) + ...
                            (0.1140*img(:,:,blue)));
    end
    % @endswitch

    % grey value of image can have values only between 0 and 255
    % values greater than 255 are rounded to 255
    % values lesser than 0 are rounded to 0
    proc_img = max(min(proc_img, 255),0);
    % displaying the image
    figure
    imshow(proc_img);

    % get the filepath and name to create a the new file name 
    [fpath,fname] = fileparts(i);

    % save the image in jpg format
    imwrite(proc_img, strcat(fpath, fname,'processed_m',m,'.jpg'),'jpg');
    
end
% @endfunction

% EOF 