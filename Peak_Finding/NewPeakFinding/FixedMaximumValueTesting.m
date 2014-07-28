% function TestMaxIntensityFinder
% 
% Description: 
% Testing function for MaxIntensityFinding.m
%
% Fields: none
%
% Pre-Condition: none
%
% Post-Condition: none
%

function TestMaxIntensityFinder

    image_test = zeros(120,100);
    
    % At random coordinates in each column of matrix, place noise intensities 
    
    sz_image_test = size(image_test);
 
    for idx = 1: sz_image_test(2)

        rand_positions = randi(120,1,20);     
        col = image_test(:,idx);
        
        for idx2 = 1:numel(rand_positions)
            
           max_pixel_value = 255;
           col(rand_positions(idx2)) = max_pixel_value; 
            
        end
        
        image_test(:,idx) = col;
        
    end
    
    % Put result image into function
    label_map = MaxIntensityFinding(image_test);
    
    % find all the indices where there is a pixel value that equals 255 and
    % compare it with index inside image_test 
    
    indices_max_label_map = find(label_map == 1);
    indices_max_image_test = find(image_test == max_pixel_value);
    
    if isequal(indices_max_image_test, indices_max_label_map)
        
        disp('Test pass');
        
        
    else
        
        disp('Something went wrong; test no pass');
        
        
    end
        
 
end