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
    [trans_range, angle] = ind2sub(size(peak_image), find(peak_image == 1))
    % convert image to grayscale for better visualization of plotted line 
    axes(handles.axes6);
    % use angle and trans_range to generate line and plot on the original
    % image    
    for idx = 1:numel([angle, trans_range]) 
% 		% set origin of the line to be zero 
%         x_cord = trans_range(idx) * cosd(angle(idx));
%         y_cord = trans_range(idx) * sind(angle(idx));	
		% plot the peaks onto the original image
		hold on;
		plot(angle,trans_range,'r+','markers',12,'LineWidth',2,'MarkerEdgeColor','k');   
	    hold off;   
    end
 end

 