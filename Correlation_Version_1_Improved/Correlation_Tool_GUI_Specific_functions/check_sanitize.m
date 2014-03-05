% function status = check_sanitize(string)
% Description:
%       
%    This function checks if the selected image is of the appropriate
%    format
%
% Fields:
%
%     string_input: input string to be checked 
%
% Initial conditions: 
%     string_input must be a of a string value 
%
% Final conditions: 
%
%     Returns 1 if the input passes the test, 0 if not
%

function status = check_sanitize(imagename, image_position)
  
    % File name can be anything, but format must be jpg, tif, tiff, or png
    
   
    exp = '[a-z|0-9|@#$%^&*(){}[];\_\s/\\|A-Z]+\.[jpg|tif|tiff|png]';
   
    match = regexp(imagename, exp, 'match'); % matches the image file name with the regular expression
        
    % the cell array match's index corresponds to the file index of the image
    % bay. For example, the first position of match corresponds to the first 
    % file on the image bay. If the file is an invalid file format, match
    % will return empty for that file index. 
    
    if isempty(match{image_position}) 
     
        %errordlg('Your selected image file is not supported. Supported image files formats are jpg, tiff, tif, or png');
        status = 0;
        
    else
       
        status = 1;
    
    end
end
          