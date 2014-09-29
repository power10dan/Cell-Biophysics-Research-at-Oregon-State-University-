% function PlotPeakOnImage(handles)
%
% Description:
%
%   This function finds the coordinates of local maximum on peak finding
%   map and plots them onto the real image
%
% Fields: handles
%  
% Initial conditions: handles must be a valid GUI Guide handle.
%
% Final conditions:   none 
%   
function PlotPeakOnImage(handles)
    peak_image = getimage(handles.axes11);
    original_image = getimage(handles.axes10);
    sz_original_img = size(original_image);
    % change peak map matrix indices to Cartesian coordinates
    [trans_range,angle] = ind2sub(size(peak_image), find(peak_image == 1));
    % init cell array
    image_array = cell(1,numel(angle));
    % convert image to grayscale for better visualization of plotted line 
    axes(handles.axes10);
    % use angle and trans_range to generate line and plot on the original
    % image    
    for idx = 1:numel(angle) 
        line_img = fuzzyline_gen(sz_original_img(2), sz_original_img(1),...
                                 angle(idx), trans_range(idx), ...
                                 str2num(get(handles.edit2, 'String')));       
        new_image = imfuse(original_image, line_img);
        % save image in cell
        image_array{idx} = new_image;              
    end
    hold off;  
    % fuse all of the line images to create a final line image which is the
    % superposition of the lines detected. Theoretically, the superposition
    % of the lines detected should create a dominant line detected on the
    % image
    for idx2 = 1:numel(image_array)
        new_big_image = imadd(original_image, image_array{idx2});       
    end       
    figure, imagesc(new_big_image);
 end

 