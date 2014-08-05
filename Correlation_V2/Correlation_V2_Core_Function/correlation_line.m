% function [corr,angles,trans] = correlation_line(testimage, angrange, brange, sigma)
% 
% Description:
%     This function performs line detection and image analysis using 
%     pattern recognition and pixel voting. 
%     
% Fields: 
%     testimage: a 2-D matrix where the correlation voting will be performed
%     angrange: [minimal angle, angle resolution, maximal angle]
%     brange:   [minimal translation, translation resolution, maximal translation]
%     
% Initial:
%     test image must be inverted, angle and brange must be non-negative.
%     
% Final:
%     Outputs a correlation map with the identified lines' angles and translations. 
%    


function [corr,angles,trans] = correlation_line(testimage, angrange,...
                                                brange, sigma)

     % variables initialization  
     imgsize = size(testimage);

     if(length(imgsize)>2)
     
         testimage = rgb2gray(testimage);
     
     end
     
     xsize = imgsize(2);
     ysize = imgsize(1);
    
     subimage = single(testimage);  
     
     %the median intensity of non-background pixels
     medianint = median(testimage(testimage>0));
     angles = angrange(1):angrange(2):angrange(3);
     trans  = brange(1):brange(2):brange(3);

     corr = zeros(length(angles), length(trans));   
     
     for thetaind = 1:length(angles)
                      
         for bind = 1:length(trans)

             theta = angles(thetaind);
             b = trans(bind);
             refline = fuzzyline_gen(xsize,ysize,theta,b,sigma);
             temp = refline.*subimage;
             temp2 = sum(temp(:));
             %normalization for the median intensity             
             temp3 = temp2/medianint;
             corr(thetaind, bind) = temp3;
            
            
         end
               
     end

       
end     