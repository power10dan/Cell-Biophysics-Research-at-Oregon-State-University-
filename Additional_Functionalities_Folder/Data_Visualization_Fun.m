function Data_Visualization_Fun(correlation_map)

    % normalize the correlation map 
    high_value = max(correlation_map(:));
    low = 0.34; % intensity is user specified and must be between 0 < x <= 1 
      
    correlation_map(correlation_map < low) = 0;
    correlation_map = correlation_map ./ high_value;
 
    % plot plane that defines the region where the user want to slice 
    [ysize, xsize] = size(correlation_map);
    
    % construct a plane 
    
    % four corner points of the plane
    coordinate_0 = [0,0,low];
    coordinate_1 = [xsize, 0, low];
    coordinate_2 = [0,ysize,low];
           
    % find vector passing the points 
    u = abs(coordinate_0 - coordinate_1);
    v = abs(coordinate_0 - coordinate_2);
        
    
    vec = cross(u,v);

    [X,Y] = meshgrid(0:2:xsize,0:2:ysize);
    
    Dlow = low;
    Dhigh = 1;
    
    % equations for the slice planes
    Zlow = (Dlow - vec(1)*(X) - vec(2)*(Y));
    Zhigh = (Dhigh - vec(1)*(X) - vec(2)*(Y));

    meshc(correlation_map);

    hold on;
    
    h1 = surf(X,Y,Zlow);
    h2 = surf(X,Y,Zhigh);
    
    hold off;
    
    % Set color and opacity of plane 
    shading flat
    set(h1,'FaceColor',[1 0 0]);
    set(h2,'FaceColor',[1 0 0]);
    alpha(h1, 0.75);
    alpha(h2, 0.75);
  
    view(3)
   
 
end