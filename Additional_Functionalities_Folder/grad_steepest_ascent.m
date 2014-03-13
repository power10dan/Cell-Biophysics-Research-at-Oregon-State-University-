function grad_steepest_ascent(correlation_map)

    % normalize the correlation map 
    high_value = max(correlation_map(:));
    low = 0.75; % intensity is user specified and must be between 0 < x <= 1 
      
    correlation_map(correlation_map < low) = 0;
    correlation_map = correlation_map ./ high_value;
    high_value_after_norm = max(correlation_map(:));
 
    % plot plane that defines the region where the user want to slice 
    [ysize, xsize] = size(correlation_map);
    
    % construct a plane 
    
    % four corner points of the plane
    coordinate_0 = [0,0,low];
    coordinate_1 = [xsize, 0, low];
    coordinate_2 = [0,ysize,low];
    coordinate_3 = [xsize,ysize, low];
 
    
    u = abs(coordinate_0 - coordinate_1);
    v = abs(coordinate_0 - coordinate_2);
        
    
    vec = cross(u,v);

    [X,Y] = meshgrid(0:1:xsize,0:1:ysize);
    
    Dlow = low;
    Dhigh = high_value_after_norm;

    Zlow = (Dlow - vec(1)*(X) - vec(2)*(Y));
    Zhigh = (Dhigh - vec(1)*(X) - vec(2)*(Y));
  
    meshc(correlation_map);
   
    hold on;
   
    fill3(X,Y,Zlow, 'r');
    fill3(X,Y,Zhigh, 'r');
  
    hold off;
 
    view(3)
   
 
end