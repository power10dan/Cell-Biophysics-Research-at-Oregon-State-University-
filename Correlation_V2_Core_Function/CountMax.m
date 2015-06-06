% function CountMax(handles)
%    
% Description:
%       
%    This function counts the number of maximums on the peak finding map. 
%
% Fields:
%    handles, peak_finding_map
%     
% Initial conditions: 
%    handles must be a valid GUI handle generated from guide, peak_finding_map
%    must be generated from peak finding algorithm 
%
% Final conditions: 
%     none

function number_lines_detected = CountMax(handles, peak_finding_map)
    num_peaks_corr_thresh = sum(peak_finding_map(:));
    set(handles.edit8, 'String', num_peaks_corr_thresh);
end