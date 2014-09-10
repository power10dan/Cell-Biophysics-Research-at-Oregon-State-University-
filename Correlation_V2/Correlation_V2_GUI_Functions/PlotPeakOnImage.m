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
function PlotPeakOnImage(handles, num_peaks)

    peak_image = getimage(handles.axes11);
    original_image = getimage(handles.axes10);
    
    CountMax()
    

    








end

