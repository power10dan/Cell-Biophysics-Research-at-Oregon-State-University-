function Intensities_Normalization_Fun(correlation_map)
    
    % normalize the correlation map 
    high_value = max(correlation_map(:));
    low_image = 0.34; % default intensity used to normalize the image
      
    correlation_map(correlation_map < low_image) = 0;
    correlation_map = correlation_map ./ high_value;
    
    Peak_Finding(correlation_map);
end
   