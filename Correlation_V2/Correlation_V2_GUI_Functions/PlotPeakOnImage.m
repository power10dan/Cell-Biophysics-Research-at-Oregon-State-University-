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
    [angle,trans_range] = ind2sub(size(peak_image), find(peak_image == 1));
    % use angle and trans_range to generate line and plot on the original
    % image
    for idx = 1:numel([angle, trans_range])       
        [x0, y0] = DetermineOrigin;
        x1 = x0 +  trans_range(idx) * cos(angle(idx));
        y1 = y0 +  trans_range(idx) * sin(angle(idx));
        
        
    
    
    end
    
 
    
%     % plot the peaks onto the original image
% 	axes(handles.axes10);
% 	hold on;
% 	for idx = 1:numel([xcord,ycord])
% 		plot(xcord,ycord,'r+','markers',12,'LineWidth',2,'MarkerEdgeColor','k');   
%     end  
%     hold off;
 end

 function [xorigin,yorigin] = DetermineOrigin
 
    
 
    
 
 
 
 
 
 
 
 
 end