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
    [angle, trans_range] = ind2sub(size(peak_image), find(peak_image == 1));
    % convert image to grayscale for better visualization of plotted line 
    axes(handles.axes10);
    % use angle and trans_range to generate line and plot on the original
    % image    
    for idx = 1:numel(angle) 
        line_img = fuzzyline_gen(sz_original_img(1), sz_original_img(2),...
                                 angle(idx), trans_range(idx), ...
                                 str2num(get(handles.edit2, 'String')));       
        origin_image_fused = imfuse(line_img, original_image);
        imagesc(origin_image_fused);
    end
 end

 