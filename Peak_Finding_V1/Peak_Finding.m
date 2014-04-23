% function Peak_Finding(correlation_map)  
% 
% Description:
%        
% This function performs peak finding on the correlation map.    
% First, the function normalizes the correlation map's intensity to be 
% between 0 to 1. Then, the map is fed into Peak_Contour for peak
% identification purposes
%
% Fields: correlation_map 
%   
% Initial conditions: 
%
% correlation_map must be a matrix generated by correlation function
%     
%
% Final conditions: None 
%
%    
%

function Peak_Finding(correlation_map)

    % normalize the correlation map 
    high_value = max(correlation_map(:));
    low = 0.34; % intensity is user specified and must be between 0 < x <= 1 
      
    correlation_map(correlation_map < low) = 0;
    correlation_map = correlation_map ./ high_value;

    Peak_Contour(correlation_map);



end