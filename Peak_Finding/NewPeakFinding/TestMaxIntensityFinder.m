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
    
    % at random coordinates in each column of matrix, place noise intensities 
    
    sz_image_test = size(image_test);
 
    for idx = 1: sz_image_test(2)

        rand_positions = randi(120,1,30);     
        col = image_test(:,idx);
        
        for idx2 = 1:numel(rand_positions)
            
           rand_color = randi(255,1,1);
           col(rand_positions(idx2)) = rand_color; 
            
        end
        
        image_test(:,idx) = col;
        
    end
    
    MaxIntensityFinding(image_test,pars);
    
    
    
    
    

end