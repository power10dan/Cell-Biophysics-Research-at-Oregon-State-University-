% function corr_res = Analysis(theta,Brange,Sigma)
% Description:
%       
%    The function calls the correlation script and performs the correlation
%    analysis and returns the result 
%
% Fields:
%
%      theta: Angle range for image 
%      Brange: the translational range for the image 
%      Sigma: The correlation factor 
%
% Initial conditions: 
%      Theta and Brange must be numeric integers, no control characters, and are  
%      in the form "<start>:<step>:<end>. Sigma can be a decimal value. 
%
% Final conditions: 
%      Returns the correlation analysis map.
%
%

function corr_res = Analysis(theta,Brange,Sigma)
    
    global image_read;
    
     if isempty(image_read)
    
        errordlg('You did not select an image');
        corr_res = 0;
        return;
    
    end
    
    I = rgb2gray(image_read);
    image = single(I);
    
    thet = [theta(1),theta(2),theta(3)];
    Brang = [Brange(1),Brange(2),Brange(3)];
   
    corr = correlation_line(image, thet, Brang, Sigma);
    disp('Processing image complete');
    corr_res = corr; 
end