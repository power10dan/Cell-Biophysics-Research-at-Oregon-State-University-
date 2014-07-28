function TestMaxIntensityFinder

    image_test = zeros(120,100);
    
    % at random coordinates in each column of matrix, place noise intensities 
    
    sz_image_blank = size(image_test);
 
    for idx = 1: sz_image_blank(2)
        
        rand_position = randi(120,1,30);
        col = image_test(:,idx);
        
        
        for idx2 = 1:numel(rand_position)
            
           rand_color = randi(255,1,1);
           rand_position
           rand_position(idx2)
           return;
           col(rand_position(idx2)) = rand_color;                          
          
        end
 
    end

    imagesc(image_test);






end