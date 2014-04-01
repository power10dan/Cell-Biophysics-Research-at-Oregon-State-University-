function  max_found = find_local_max(correlation_map)
 
    low = 0.5;
    high = 1.0;
   
    C = contour(correlation_map);
   
    % find the indices of peaks within this region 
    peak_region_idx = find(C > low & C < high); 
 
    % extract peaks and their x and y coordinates
    peaks_and_coord = C(peak_region_idx(1):end);

    % interpolate data for best point possible 
    points = parse_contour_data(peaks_and_coord);
    
    peaks_found = find_peaks(points,correlation_map);
    
    max_found = peaks_found;
       
    

end


function best_point_interp = parse_contour_data(peak_coord)
    
    % variables
    intensity_data = struct();

    %indices
    idx = 2;
    struct_idx = 1;
    peak_intensity_idx = 1;
    
    while idx < numel(peak_coord)
  
        peak_intensity = peak_coord(1,peak_intensity_idx);
        peak_init_height = peak_coord(1,idx);
        cord_counter = idx+1:2:(2*peak_init_height)+idx;
    
        x_cord = peak_coord(cord_counter);
        y_cord = peak_coord(cord_counter+1);
        % figure out smallest intensity, then take the coordinate of
        % smallest intensity and construct a polygon using inpoly. average
        % other coordinates and check if the other coordinates is within
        % the polygon. Then, they belong to the same contour peak. 
        
        %average the sum
        ave_x = sum(x_cord) / numel(x_cord);
        ave_y = sum(y_cord) / numel(y_cord);
        
        %store inside struct
        intensity_data(struct_idx).region_intensity = peak_intensity;
        intensity_data(struct_idx).average_coordinate_x = ave_x;
        intensity_data(struct_idx).average_coordinate_y = ave_y;
        
        struct_idx = struct_idx + 1;
        peak_intensity_idx = (2*peak_init_height)+idx + 1;
        idx = (2*peak_init_height)+idx + 2;
    
    end
    
    best_point_interp = intensity_data;

end

function peaks_found = find_peaks(intensity_cord_and_data,contour_matrix)
 
    intensity_values = zeros(numel(intensity_cord_and_data),1);
    refine_contour = 0;
    counter_peak = 0;
    
    
    intensity_cord_and_data.region_intensity
    intensity_cord_and_data.average_coordinate_x
    intensity_cord_and_data.average_coordinate_y
    return;
  
    idx_extract_intensity = 1:numel(intensity_cord_and_data);
        
    intensity_values(idx_extract_intensity) = intensity_cord_and_data(idx_extract_intensity).region_intensity;
    
    origin = intensity_values(1);
    
    % loop through struct and draw more refined contours for each of the
    % separate polygon mountains to find a more refined peak
   
    for idx = 1:numel(intensity_values)
     
        if (abs(intensity_values(idx)- origin) == 0.1)
        
            refine_contour = contour(contour_matrix,...
                                            [origin+0.01:0.01:intensity_values(idx)]);
      
        else 
            
            counter_peak = counter_peak + 1;                         
                                        
                                        
        end
   
    end
    
    disp(refine_contour);
    peaks_found = 0;


end



