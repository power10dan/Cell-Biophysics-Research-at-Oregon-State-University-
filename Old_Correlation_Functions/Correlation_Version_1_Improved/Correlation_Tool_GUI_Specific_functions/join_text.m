% function [mystring,name] = join_text(newitem, handles) 
%
% Description:
%   
%   This function joins the name of the files into one single continuous
%   string so displaying on the Image Bay would be easier. 
%    
%   
% Fields:
%
%   newitem: The string to be joined with the old string
%   handles: The GUI handle for Image Bay 
%
% Initial conditions: new item must be either a struct or cell array
%
% Final conditions:  mystring, the joined, continuous single string, and
% name, the new files the user decides to add to the image box

 function [mystring, name_of_file_to_be_joined] = join_text(new_input_filename, handles) 
     
    file_on_image_bay = get(handles, 'string');
            
    if isempty(file_on_image_bay)

        if ~isstruct(new_input_filename)
          
            mystring = {new_input_filename};
            name_of_file_to_be_joined = {new_input_filename};
            return;

        else
           
            mystring = {new_input_filename(:).name};
            name_of_file_to_be_joined = {new_input_filename(:).name};
            return;

        end

    end

    if ~isstruct(new_input_filename)
       
        mystring = vertcat(file_on_image_bay, new_input_filename);
        name_of_file_to_be_joined = {new_input_filename};
        return;

    end   
    
    new_file_name_to_be_joined = {new_input_filename(:).name};
    name_of_file_to_be_joined = new_file_name_to_be_joined;
    new_file_name_to_be_joined_size_adjusted = transpose(new_file_name_to_be_joined); % make dimension of matrix agree   
    mystring = vertcat(file_on_image_bay,new_file_name_to_be_joined_size_adjusted);
 end