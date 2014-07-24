% function MaxIntensityFinding (correlation_map)
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
%

function MaxIntensityFinding (correlation_map)
    
    figure, imagesc(correlation_map);
    correlation_map(364.
    
    distance_threshold = 10;  % dummy value, subject to change
        
    size_corr = size(correlation_map);
    
    % create an intensity map grid plot
    intensity_map = zeros(size_corr(1), size_corr(2));
    figure, imagesc(intensity_map);  
         
    for idx = 1:10:size_corr(2)

        if idx + distance_threshold < size_corr(2)
            % parse out 1st 10 rows of matrix
            initial_comparison_matrix = correlation_map(:,idx:idx+distance_threshold);
      
            % find maximum values in every single column of the initial matrix
            local_max_values = max(initial_comparison_matrix);
            maximum_pixel = max(local_max_values)
            
            % index of maximum pixel
            index_ref_pixel = find(correlation_map == maximum_pixel)
            [xcord, ycord] = ind2sub(size(correlation_map), index_ref_pixel)
            
            hold on;
            plot(xcord, ycord,'x', 'MarkerSize', 10, 'MarkerFaceColor', 'k');
            hold off;
        
        end 
            
    end
 
end

