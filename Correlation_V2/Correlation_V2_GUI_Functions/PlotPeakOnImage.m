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
    % change peak map matrix indices to Cartesian coordinates
    [xcord,ycord] = ind2sub(size(peak_image), find(peak_image == 1));
    % plot the peaks onto the original image
	axes(handles.axes10);
	for idx = 1:numel([xcord,ycord])
		plot(xcord,ycord,'r+');   
    end     
 end

