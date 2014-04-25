% function Peak_Contour(correlation_map)  
% 
% Description:
%        
% This function generates a contour map of the correlation map 
%
% Fields: correlation_map, low_threshold, high_threshold 
%   
% Initial conditions:
% 
% correlation_map must be generated from the
% correlation_line function, low and high threshold must be either decimal
% or integer values between 0 and 1. 
%   
%
% Final conditions: None 

function Peak_Finding(correlation_map)
 
    low = 0.5;
    high = 1.0;
   
    C = contour(correlation_map);

    % find the indices of peaks within this region 
    peak_region_idx = find(C > low & C < high); 
 
    % extract peaks and their x and y coordinates
    peaks_and_coord = C(peak_region_idx(1):end);

    % interpolate data for best point possible 
    Parse_Contour_Data(peaks_and_coord);
  
end
% function Peak_Contour_Data(peak_coord, contour_matrix)
% 
% Description:     
%  
%   This function extracts contour intensities and coordinates from the
%   contour matrix. 
% 
%
% Fields: peak_coord
%   
% Initial conditions: 
%  
% peak_coord must be a coordinate-intensity matrix generated by the contour
% function   
%
% Final conditions: None 
%

function Parse_Contour_Data(peak_coord)
    
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
    Find_Max_Fun(intensity_data);    

end
% function Peak_Finding(correlation_map)  
% 
% Description:
% 
% This function locates all of the local maximum intensities between the
% user's desired threshhold intensity. 
%   
% Fields: intensity_struct_data
%   
% Initial conditions: 
%
% intensity_struct_data must be a matrix of intensity values generated by
% the contour matrix
%
% Final conditions: None 
function Find_Max_Fun(intensity_struct_data)
    
    size_struct_data = numel(intensity_struct_data);
    [min_intensity_group, new_intensity_struct_data] = Group_calc(intensity_struct_data, size_struct_data)
    
    out_lier_data = 0;   
        
    if numel(new_intensity_struct_data) > 0
         
        [intensity_group_additional, new_intensity_struct_data] = Group_calc(new_intensity_struct_data, size_struct_data);
          
        min_intensity_group = [min_intensity_group intensity_group_additional];
        
        if numel(new_intensity_struct_data) > 0
            disp('Outliers')
            new_intensity_struct_data(:).region_intensity
            out_lier_data = numel(new_intensity_struct_data);
            
     
        end        
        
    end
        
    min_intensity_group(all(cellfun(@isempty,min_intensity_group),2), : ) = [];
    min_intensity_group{:}
    count_intensity(out_lier_data, min_intensity_group);
  
  
end
% function [min_intensity_data, new_intensity_struct_data] = Group_calc(intensity_data_struct, size_struct_data)
% 
% Description:
% 
% Groups like intensities with average x and y coordinates differences
% smaller than 3. 
% 
% Fields: intensity_data_struct, size_struct_data
%   
% Initial conditions: 
%
% intensity_data_struct must be a struct with pre-parsed intensity data.
% size_struct_data must be an integer that represents the size of the
% intensity_data_struct
%     
% Final conditions: 
%
%  returns min_intensity_data, which represents the grouped intensities
%  and new_intensity_struct_data, which represents outlier data that does
%  not belong to any groups.     
%

function [min_intensity_data, new_intensity_struct_data] = Group_calc(intensity_data_struct, size_struct_data)
                                                                  
    min_intensity = min([intensity_data_struct(:).region_intensity]);
    min_intensity_location_array = find([intensity_data_struct(:).region_intensity]...
                                                         == min_intensity); 

    peak_diff= 3;
  
    min_intensity_group_array = cell(size_struct_data, numel(min_intensity_location_array));                                                              
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
    new_intensity_struct_data = intensity_data_struct;
    
    min_intensity_data = min_intensity_group_array;
    
end

% function count_intensity(out_lier_data, intensity_array)
% 
% Description:
%        
% This function counts the number of intensities found. 
%
% Fields: out_lier_data, intensity_array
%   
% Initial conditions: 
%
% out_lier_data must be an integer, and intensity_array must be an array of
% integers that represents the grouped intensities.
%     
% Final conditions: None  


function count_intensity(out_lier,intensity_array)

     sz_intensity_array = size(intensity_array);
 
     num_peaks = sz_intensity_array(2)- out_lier;

     fprintf('There are %d peaks between your 0.6 and 1\n', num_peaks);
  
end

