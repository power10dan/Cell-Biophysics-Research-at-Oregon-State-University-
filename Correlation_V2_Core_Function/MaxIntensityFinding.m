% function MaxIntensityFinding (correlation_map)
% 
% Modifications of program other than Dan Lin: 
% Bo Sun, 7/25/14
%
% Description: 
% This function finds the maximum values inside a Correlation
% Map and generate an intensity map with markers plotted on the map to
% locate  the maximums on the correlation map. 
%
% Fields: correlation_map 
%
% Pre-Condition: correlation_map must be a intensity map generated by the
% correlation function 
%
% Post-Condition: an intensity map showing where the maximums are on the
% correlation map. 

function [label_map] = MaxIntensityFinding (correlation_map,dist_input) 
    if(nargin == 2)      
        distance_threshold = dist_input;   
    else    
        distance_threshold = 10;  % default value if user didn't input anything for dist_input   
    end    
    
    size_corr = size(correlation_map); 
    label_map = zeros(size_corr);   
    [xgrid,ygrid] = meshgrid(1:size_corr(2),1:size_corr(1));   
    for indx = 1:size_corr(2)       
        for indy = 1:size_corr(1)           
            dist = sqrt((xgrid-indx).^2 + (ygrid-indy).^2);
            pixuseful = dist < distance_threshold;                
            if (correlation_map(indy,indx) >= max(correlation_map(pixuseful)))
                label_map(indy,indx) = 1;            
            end  

        end     
    end  
	%filter out false peaks
    label_map(correlation_map == 0) = 0;
end

