% function SaveData(image_name)  
%
% Description:
%       
%    This function saves program data
%
% Fields:
%
%     experiment: data to be saved 
%     
%
% Initial conditions: 
%     
%     experiment must be an image data type
%
% Final conditions:  none
%     

function SaveData (experiment)
    
    folder_name = 'Experiment Data';
   
    if ~exist( folder_name)
        
        mkdir(folder_name);
        
    end
    
    cur_dir = pwd;
       
    % generate file name 
    processed_image_save_file_name = sprintf('Test_with_%s', experiment);
    output_folder = strcat(cur_dir, filesep, folder_name);
    full_image_path_name = strcat(output_folder, filesep, processed_image_save_file_name);  
    
    %export file
    if ~exist(full_image_path_name)
        
        export_fig([output_folder,filesep,processed_image_save_file_name], '-png');
        
    end
end