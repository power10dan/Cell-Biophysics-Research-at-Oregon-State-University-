% function RealImageTest
% 
% Description: 
% 
% Test function of the peak finding algorithm on real image called
% 1000-point-speckle.jpg
%
% Fields: none
%
% Pre-Condition: none
%
% Post-Condition: none
%

function RealImageTest
   
    imgtoshow = imread('C:\Users\Sungroup\Downloads\1000-point-speckle.jpg');
    imagesc(imgtoshow(:,:,1));
    
    % inverting image so light becomes dark and dark becomes light
    data = 255-squeeze((imgtoshow(:,:,1)));
    
    imagesc(data)
    [label_map] = MaxIntensityFinding (data,5);
    imagesc(label_map)
    figure,imagesc(data)
    
  

end