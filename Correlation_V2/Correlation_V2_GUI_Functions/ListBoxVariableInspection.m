% [image_name_sanitized, image_name_sanitized_pos_value] = ListBoxVariableInspection(list_box_handle)
%
% Description:
%
%    This function checks whether the filename in the list box is an valid
%    image file. 
%
% Fields:
%    list_box_handle
%
% Initial conditions:
%    list_box_handle must be a valid list box GUI handle
%
% Final conditions:
%    List of checked image names and their position values 

function [image_name_sanitized, image_name_sanitized_pos_value] = ListBoxVariableInspection(list_box_handle)
    
           
    image_name_list = get(list_box_handle.listbox1, 'string');
    image_name_pos = get(list_box_handle.listbox1, 'value');
    
    
    status = CheckFileName(image_name_list, image_name_pos);
   
    if status == 0 % if there is something wrong inside the image_name_list
        
        return;
    
    end

    if status == 1 % if there is nothing wrong
        
        image_name_sanitized = image_name_list;
        image_name_sanitized_pos_value = image_name_pos;
        return
        
    end
    
 
end

