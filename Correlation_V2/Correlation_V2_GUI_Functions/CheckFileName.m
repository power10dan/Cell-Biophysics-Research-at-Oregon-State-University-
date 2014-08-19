% function status = CheckFileName(imagename, image_position)
% Description:
%   
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

function [sanitized_image_name, sanitized_image_pos] = CheckFileName(list_box_handle)

    list_of_image_name = get(list_box_handle.listbox1, 'String');
    image_name_pos = get(list_box_handle.listbox1, 'Value');
    
    % get file extension 
    [path_str, name, ext] = fileparts(list_of_image_name{image_name_pos});
    
    % File name can be anything, but format must be jpg, tif, tiff, or png 
    valid_image_extensions = {'.jpg', '.png', '.tif', '.tiff'};
      
    for idx = 1:numel(valid_image_extensions)
       
        if idx == numel(valid_image_extensions)
            
            errordlg('Your selected image file is not supported. Supported image files formats are jpg, tiff, tif, or png');
            sanitized_image_name = '';
            sanitized_image_pos = '';
            break
        end
        
        if strcmp(ext, valid_image_extensions{idx}) == 1
            
            sanitized_image_name = list_of_image_name{image_name_pos};
            sanitized_image_pos = image_name_pos;
            return
            
        end
    
    end
   
   
end
          
