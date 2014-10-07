% function corr_res = Analysis(theta_range,brange,sigma, image_path)
%    
% Description:
%       
%    This function 
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
function mode = CheckStructMode(mode_struct)
    if mode_struct.Correlation_Analysis == 1
        mode = 'Regular-Corr-Analysis';
    else
        mode = 'Sub-window-Analysis';
    end
end

