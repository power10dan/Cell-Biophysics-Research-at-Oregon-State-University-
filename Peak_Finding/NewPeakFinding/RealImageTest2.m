% function RealImageTest2
% 
% Description: 
% 
% Test function of the peak finding algorithm on real images called
% dama-de-noce-tile.jpg
%
% Fields: none
%
% Pre-Condition: none
%
% Post-Condition: none
%

function  RealImageTest2

    imgtoshow2 = imread('C:\Users\Sungroup\Downloads\dama-de-noce-tile.jpg');

    imgtoshow2_cropped = imcrop(imgtoshow2, [50,50,318 320]);
    
    [label_map] = MaxIntensityFinding(imgtoshow2_cropped,5);
    imagesc(label_map)
    figure, imagesc(imgtoshow2_cropped);


end

