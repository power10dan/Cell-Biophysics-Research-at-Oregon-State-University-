% function MixedPixelTesting
% 
% Description: 
% Testing function for MaxIntensityFinding.m with random pixel values at
% each column of the image matrix.
%
% Fields: none
%
% Pre-Condition: none
%
% Post-Condition: none
%


function MixedPixelTesting
   
    image_test = zeros(120,100);
    
    % At random coordinates in each column of matrix, place noise intensities 
    
    sz_image_test = size(image_test);
    
    num_random_pos = 20;
    max_values_cell = cell(1,sz_image_test(2));
 
    for idx = 1: sz_image_test(2)

        rand_positions = randi(120,1,num_random_pos);     
        col = image_test(:,idx);
        
        for idx2 = 1:numel(rand_positions)
            
           max_pixel_value = rand(255,1,1);
           col(rand_positions(idx2)) = max_pixel_value; 
            
        end
        
        local_max_values_at_col = max(col);
        max_value = max(local_max_values_at_col);
        max_values_cell{idx} = max_value;
        
        image_test(:,idx) = col;
        
    end
    
    % Put result image into function
    label_map = MaxIntensityFinding(image_test);
    
  

end