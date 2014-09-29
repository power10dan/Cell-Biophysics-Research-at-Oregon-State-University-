% function corr_res = Analysis(theta_range,brange,sigma, image_path)
%    
% Description:
%       
%    The function performs Correlation analysis  
%
% Fields:
%
%      theta_range: Angle range for image 
%      brange: the translational range for the image 
%      sigma: The correlation factor 
%      image_path: path to the image to be analyzed
%
% Initial conditions: 
%      theta_range and brange must be of type integer and are  
%      in the form "<start>:<step>:<end>". sigma can be integer or decimal values. 
%      image_path must be a string type variable. 
%
%
% Final conditions: 
%      Returns a correlation analysis map
%
%

function corr_res = Analysis(theta_range,brange,sigma, image)

    image_input = single(image);
    theta_input = [theta_range(1),theta_range(2),theta_range(3)];
    b_range_input = [brange(1),brange(2),brange(3)];
    
    h = waitbar(0.5, 'Image loaded, performing correlation and peak finding now');
    corr = correlation_line(image_input, theta_input, b_range_input, sigma);
    corr_res = corr;
    waitbar(1,h,'Analysis Complete');
    pause(0.3); % let the user see the analysis complete message
    close(h);
  
end