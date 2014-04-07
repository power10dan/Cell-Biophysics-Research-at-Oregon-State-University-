function  max_found = find_local_max(correlation_map)
 
    low = 0.5;
    high = 1.0;
   
    C = contour(correlation_map);
   
    % find the indices of peaks within this region 
    peak_region_idx = find(C > low & C < high); 
 
    % extract peaks and their x and y coordinates
    peaks_and_coord = C(peak_region_idx(1):end);

    % interpolate data for best point possible 
    points = parse_contour_data(peaks_and_coord, C);
  
end


function best_point_interp = parse_contour_data(peak_coord, contour_matrix)
    
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
     
        %average the sum
        ave_x = sum(x_cord) / numel(x_cord);
        ave_y = sum(y_cord) / numel(y_cord);
        
        %store inside struct
        intensity_data(struct_idx).region_intensity = peak_intensity;
        intensity_data(struct_idx).average_coordinate_x = ave_x;
        intensity_data(struct_idx).average_coordinate_y = ave_y;
        intensity_data(struct_idx).x_coord = x_cord;
        intensity_data(struct_idx).y_coord = y_cord;
      
        struct_idx = struct_idx + 1;
        peak_intensity_idx = (2*peak_init_height)+idx + 1;
        idx = (2*peak_init_height)+idx + 2;
    
    end
   
    %find minimum
    groups = grouping_fun(intensity_data);
    
    refine_contour = contour_refine(groups, intensity_data, contour_matrix);
    

end

function grouped_array = grouping_fun(intensity_struct_data)
  
    min_intensity  = min([intensity_struct_data(:).region_intensity]);
    min_intense_idx = find([intensity_struct_data.region_intensity]...
                                    == min_intensity);
    
    min_intensity_information = cell(numel(intensity_struct_data),numel(min_intense_idx));                        
                 
    for idx = 1:numel(min_intense_idx)
        
        min_intensity_information{1,idx} = intensity_struct_data(min_intense_idx(idx));
                           
    end 
    
    for idx_2 = 
        
        % to be updated
        
        
        
        
        
        
        
    end     
    
    
    
    grouped_array = min_intensity_information;
  
end

function refine_contour = contour_refine(grouped_intensity_array, intensity_cord_and_data,contour_matrix)
 
    intensity_values = zeros(numel(intensity_cord_and_data),1);
    refine_contour = 0;
    counter_peak = 0;
  
    idx_extract_intensity = 1:numel(intensity_cord_and_data);
        
    intensity_values(idx_extract_intensity) = intensity_cord_and_data(idx_extract_intensity).region_intensity;
    
    origin = intensity_values(1);

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



