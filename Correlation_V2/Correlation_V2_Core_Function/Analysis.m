% function corr_res = Analysis(theta_range,brange,sigma, image_path)
%    
% Description:
%       
%    The function performs Correlation analysis  
%
% Fields:
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
% Final conditions: 
%      Returns a correlation analysis map
%
function corr_res = Analysis(mode,theta_range,brange,sigma, image)
    [image_input, theta_input, b_range_input] = ImageAnaylsisHelper(image, theta_range, brange);
    if strcmp(mode, 'Regular-Corr-Analysis') == 0
        h = waitbar(0.5, 'Image loaded, performing correlation and peak finding now');
        corr = correlation_line(image_input, theta_input, b_range_input, sigma);
        corr_res = corr;  
    else
        h = waitbar(0.5, 'Image loaded, performing correlation sub-window analysis');
        corr = correlation_line_sw(image_input, theta_input, b_range_input, sigma);
        corr_res = corr;
    end   
    waitbar(1,h,'Analysis Complete');
    pause(0.3); % let the user see the analysis complete message
    close(h); 
end
   
function [image_output, theta_input, b_range_input] = ImageAnaylsisHelper(image_to_be_analyzed, theta, brange)
        image_output = single(image_to_be_analyzed);
        theta_input = [theta(1),theta(2),theta(3)];
        b_range_input = [brange(1),brange(2),brange(3)];  
end    