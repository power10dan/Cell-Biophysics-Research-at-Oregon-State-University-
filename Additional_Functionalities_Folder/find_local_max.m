function  max_found = find_local_max(correlation_map)
 
    low = 0.5;
    high = 1.0;
   
    C = contour(correlation_map);

    % find the indices of peaks within this region 
    peak_region_idx = find(C > low & C < high); 
 
    % extract peaks and their x and y coordinates
    peaks_and_coord = C(peak_region_idx(1):end);

    % interpolate data for best point possible 
    points = Parse_Contour_Data(peaks_and_coord, C);
  
end


function best_point_interp = Parse_Contour_Data(peak_coord, contour_matrix)
    
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
    groups = Find_Max_Fun(intensity_data);
    count_intensity(groups);
    return;
    refine_contour = contour_refine(groups, intensity_data, contour_matrix);
    

end

function grouped_array = Find_Max_Fun(intensity_struct_data)
    
    min_intensity = min([intensity_struct_data(:).region_intensity]);
    min_intensity_location = find([intensity_struct_data(:).region_intensity]...
                                                         == min_intensity); 
                                                     
    intensity_struct_data(:).region_intensity 
  
    peak_diff_tolerance = 2;
    
  
    min_intensity_group = cell(numel(intensity_struct_data), numel(min_intensity_location));
 
    [min_intensity_group, new_intensity_struct_data] = Group_calc(min_intensity_group, min_intensity_location, ...
                                                                  intensity_struct_data, peak_diff_tolerance);
   
    if numel(new_intensity_struct_data) > 1
        
        disp('This is extra data');
        sz = size(min_intensity_group);
         
        additional_array = cell(sz(1),1); % keep dimension consistant for concatination 
        
        for idx = 1:numel(new_intensity_struct_data)
            
            additiona_array{idx,1} = new_intensity_struct_data(idx);
            
            
            
        end
   
        
        min_intensity_group = [min_intensity_group additional_array];     
       
  
    end 
    
    min_intensity_group(all(cellfun(@isempty,min_intensity_group),2), : ) = []
    count_intensity(min_intensity_group);
  
  
end

function [min_intensity_data, new_intensity_struct_data] = Group_calc(min_intensity_group_array, ...
                                                                      min_intensity_location_array, ...
                                                                      intensity_data_struct, peak_diff)
    num_max_intensity_struct = numel(intensity_data_struct);
    
    for idx = 1:numel(min_intensity_location_array)
   
        min_intensity_group_array{1,idx} = intensity_data_struct(min_intensity_location_array(idx));

        for idx_2 = num_max_intensity_struct : -1: numel(min_intensity_location_array)+1

            peak_threshold_min_x = min_intensity_group_array{1,idx}.average_coordinate_x(1);
            peak_threshold_min_y = min_intensity_group_array{1,idx}.average_coordinate_y(1);

            if (abs(intensity_data_struct(idx_2).average_coordinate_x(1) - peak_threshold_min_x)) ...
                    < peak_diff

                if (abs(intensity_data_struct(idx_2).average_coordinate_y(1) - peak_threshold_min_y)) ...
                        < peak_diff
                    emptyCells = cellfun(@isempty,min_intensity_group_array(:,idx));

                    empty_cell_idx = find(emptyCells == 1);

                    min_intensity_group_array{empty_cell_idx(end),idx} = intensity_data_struct(idx_2);

                    intensity_data_struct(idx_2) = [];
                    num_max_intensity_struct = num_max_intensity_struct - 1;


                else

                    continue;

                end

            end

        end

    end
    
    intensity_data_struct(min_intensity_location_array) = [];
    new_intensity_struct_data = intensity_data_struct
    
    min_intensity_data = min_intensity_group_array;
    
end
  


function count_intensity(intensity_array)

     intensity_array{:}
     sz_intensity_array = size(intensity_array);
     
     num_peaks = sz_intensity_array(2)
          
     



end




% function refine_contour = contour_refine(grouped_intensity_array, intensity_cord_and_data,contour_matrix)
%  
%     intensity_values = zeros(numel(intensity_cord_and_data),1);
%     refine_contour = 0;
%     counter_peak = 0;
%   
%     idx_extract_intensity = 1:numel(intensity_cord_and_data);
%         
%     intensity_values(idx_extract_intensity) = intensity_cord_and_data(idx_extract_intensity).region_intensity;
%     
%     origin = intensity_values(1);
% 
%     for idx = 1:numel(intensity_values)
%      
%         if (abs(intensity_values(idx)- origin) == 0.1)
%         
%             refine_contour = contour(contour_matrix,...
%                                             [origin+0.01:0.01:intensity_values(idx)]);
%       
%         else 
%            
%             counter_peak = counter_peak + 1;                         
%                                  
%         end
%    
%     end
%     
%    
%     peaks_found = 0;
% 
% 
% end
% 


