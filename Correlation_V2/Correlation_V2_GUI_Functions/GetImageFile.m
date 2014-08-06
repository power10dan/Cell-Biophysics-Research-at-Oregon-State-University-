% function [image_file_name, image_file_path] = GetImageFile
%
% Description:
%
%    This function allows users to upload either a list of files or a single file
%    onto the image bay
%
% Fields: none
%  
% Initial conditions: none
%    
%
% Final conditions:
%   Outputs a list of image file names and their respective
%   paths or a single file with its path.
%    

function [image_file_name, image_file_path] = GetImageFile

    % Construct a questdlg with three options
    choice = questdlg('Would you like to upload a single file or an entire directory?', ...
                      'File Upload', 'Single File', 'Directory','Cancel', 'Cancel'); % syntax for questdlg: button = questdlg('qstring','title',default), 
                                                                       % default for this questdlg is single file                                                                  
    switch choice
        
        case 'Directory'
            
            directory_path = uigetdir;
            files_and_folders_in_directory = dir(directory_path);
            
            % remove all '.' and '..' instances from the folder
            ind = [files_and_folders_in_directory(:).isdir];
            nodir = find(~ind);
            file_names = files_and_folders_in_directory(nodir);
            
            path_array = cell(1,numel(file_names));
                       
            for idx = 1:numel(file_names)
                
                path_array{idx} = strcat(directory_path, filesep, file_names(idx).name);
                                
            end
                     
            image_file_name = file_names;
            image_file_path = path_array;
            return
      
        case 'Single File'
            
            [file_name, path_name] = uigetfile;
            
            image_file_name = file_name;
            image_file_path = path_name;
            
            return;
       
        case 'Cancel'
            
            image_file_name = '';
            image_file_path = '';
            
            return
          
    end
                                                                  
 
end

