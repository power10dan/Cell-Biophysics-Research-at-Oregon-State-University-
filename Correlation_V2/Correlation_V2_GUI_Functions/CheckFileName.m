% function status = CheckFileName(imagename, image_position)
% Description:
%   This function checks whether the file selected by the user is a valid
%   image file  
%
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

function status = CheckFileName(imagename, image_position)
  
    % File name can be anything, but format must be jpg, tif, tiff, or png
    
    [path_str, name, ext] = fileparts(imagename{image_position});
     
    valid_image_extensions = {'.jpg', '.png', '.tif', '.tiff'};
  
    
    for idx = 1:numel(valid_image_extensions)
       
        if idx == numel(valid_image_extensions)
            
            errordlg('Your selected image file is not supported. Supported image files formats are jpg, tiff, tif, or png');
            status = 0;
            
        end
        
        if strcmp(ext, valid_image_extensions{idx}) == 0
            
            status = 1;
            break;
            
        end
    
    end
   
end
          
