% function [folder_name, status] = makefolder(folder_name)   
%
% Description:
%       
%    This function calls an external script called export_fig to save the
%    correlation result
%
% Fields:
%
%     image_name: name of the image to be saved
%     folder_name: name of the target folder for the image to be saved
%
% Initial conditions: 
%     image_name must be a string value 
%     folder_name must be a string value
%
% Final conditions: 
%     Saves the image file to the specified folder 

function save_file(image_name, folder_name)
    
    cur_dir = pwd;
       
    % generate file name 
    processed_image_save_file_name = sprintf('corr_%s', image_name);
    output_folder = strcat(cur_dir, filesep, folder_name);
    full_image_path_name = strcat(output_folder, filesep, processed_image_save_file_name);  
    
    %export file
    if ~exist(full_image_path_name)
        
        export_fig([output_folder,filesep,processed_image_save_file_name], '-png');
        
    end
end