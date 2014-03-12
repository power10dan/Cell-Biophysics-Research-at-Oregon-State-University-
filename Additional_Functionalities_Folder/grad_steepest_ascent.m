function grad_steepest_ascent(correlation_map)

    % normalize the correlation map 
    high_value = max(correlation_map(:));
    low = 0.75; % intensity is user specified and must be between 0 < x <= 1 
      
    correlation_map(correlation_map < low) = 0;
    correlation_map = correlation_map ./ high_value;
 
    % plot plane that defines the region where the user want to slice 
    [ysize, xsize] = size(correlation_map);
    
    %length and width of the plane and starting height of the plane 
        
    meshc(correlation_map);
    hold on
    patch([0,1,1,1], [1,0,0,1], [0,0,0,1], 'g');
    view(3);
    
    
    
    
    

end