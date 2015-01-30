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
    alllines = zeros(sz_original_img(1:2));
    for idx = 1:numel(angle) 
        angle_init = str2num(get(handles.edit11, 'String'));
        angle_step = str2num(get(handles.edit12, 'String'));
        trans_init = str2num(get(handles.edit1, 'String'));
        trans_step = str2num(get(handles.edit9, 'String'));
        true_angle = angle_init+(angle(idx)*angle_step);
        true_range = trans_init + (trans_range(idx)*trans_step);
        line_img = fuzzyline_gen(sz_original_img(2), sz_original_img(1),...
                                 true_angle, true_range, ...
                                 str2num(get(handles.edit2, 'String')));  
        alllines = alllines+line_img;        
    end
    %convert to gray if original image is RGB
    if(length(sz_original_img)>2)
        grayimage = rgb2gray(original_image);
    else
        grayimage = original_image;
    end
    %convert alllines to grayscale intensity image
    alllines = uint8(round(alllines/max(alllines(:))*255));
    figure,imagesc(alllines);
    % fuse all of the line images to create a final line image which is the
    %new_big_image = imfuse(grayimage,alllines,'blend');
    new_big_image = uint8(zeros([size(grayimage),3]));
    new_big_image(:,:,1) = grayimage;
    new_big_image(:,:,2) = alllines;
    
    figure, imagesc(new_big_image);

 end