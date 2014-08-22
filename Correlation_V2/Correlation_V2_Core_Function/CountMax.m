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
%
% Final conditions: 
%     none
%
%

function CountMax(handles, peak_finding_map)

    indices_max_label_map = find(peak_finding_map == 1)    
    number_lines_detected = numel(indices_max_label_map);
    set(handles.edit8, 'String', number_lines_detected);
 
end