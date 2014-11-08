% function [image_file_name, image_file_path] = GetAndSetImageFile
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

function [image_file_name, image_file_path] = GetAndSetImageFile(handles)

    % Construct a questdlg with three options
    choice = questdlg('Would you like to upload a single file or an entire directory?', ...
                      'File Upload', 'Single File', 'Directory','Cancel', 'Cancel'); % syntax for questdlg: button = questdlg('qstring','title',default), 
                                                                                     % default for this questdlg is single file                                                                  
                                                                                     
    curr_listbox_files = get(handles.listbox1,'string');                                                                               
    
    switch choice
        
        case 'Directory'
            
            directory_path = uigetdir;
            
             if directory_path == 0
                
                image_file_name = '';
                image_file_path = '';
                return
                
            end
   
            
            files_and_folders_in_directory = dir(directory_path);
            
            % remove folders
            ind = [files_and_folders_in_directory(:).isdir];
            nodir = find(~ind);
            file_names = files_and_folders_in_directory(nodir);
            
            path_array = cell(1,numel(file_names));
                       
            for idx = 1:numel(file_names)
                
                path_array{idx} = strcat(directory_path, filesep, file_names(idx).name);
                                
            end
            
            if isempty(get(handles.listbox1,'string')) 
               
                % vectorized index to get all of the names of the file
                idx = 1:numel(file_names);
                set(handles.listbox1,'String',{file_names(idx).name});
                     
            else 
                
                idx2 = 1:numel(file_names);              
                new_file_name = transpose({file_names(idx2).name}); % set file_names's dimension equal to curr_listbox_files
                new_listbox_files = vertcat(curr_listbox_files, new_file_name);               
                set(handles.listbox1, 'String', new_listbox_files);
      
            end
            
            image_file_name = file_names;
            image_file_path = path_array;
          
      
        case 'Single File'
            
            [file_name, path_name] = uigetfile;
            
             if file_name == 0
                
                image_file_name = '';
                image_file_path = '';
                return
                
            end
  
            set(handles.listbox1,'String',{file_name});
            
            if isempty(get(handles.listbox1,'string')) 
               
                set(handles.listbox1,'String',{file_name});
                            
            else 
        
                new_file_name = transpose({file_name}); % set file_names's dimension equal to curr_listbox_files
                new_listbox_files = vertcat(curr_listbox_files, new_file_name);               
                set(handles.listbox1, 'String', new_listbox_files);
                    
            end
            
            image_file_name = strcat(path_name, file_name);
            image_file_path = path_name;
        
            
       
        case 'Cancel'
            
            image_file_name = '';
            image_file_path = '';
            
            
        otherwise
            
            image_file_name = '';
            image_file_path = '';
          
    end
                                                                  
 
end

