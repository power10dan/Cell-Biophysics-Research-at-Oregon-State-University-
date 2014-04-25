function Intensities_Normalization_Fun(correlation_map)

    % normalize the correlation map 
    high_value = max(correlation_map(:));
    low = 0.34; % intensity is user specified and must be between 0 < x <= 1 
      
    correlation_map(correlation_map < low) = 0;
    correlation_map = correlation_map ./ high_value;
    
    Peak_Finding(correlation_map);
end
   