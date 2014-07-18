% function [folder_name, status] = makefolder(folder_name)   
%
% Description:
%       
%    This function checks if the folder existed. If not, it creates the
%    folder and returns a status.
%
%
% Fields:
%
%     folder_name: the name of the folder the user wants 
%
% Initial conditions: 
%     folder_name must be a string 
%     folder_name must not be an existing Matlab function name (breaks
%     exists function) 
%
% Final conditions: 
%
%     Checks whether the folder exists. If not, the function creates the
%     folder and set status to 1. If yes, then the function returns the
%     folder name or display error dialog if the name is an exisitng Matlab
%     function. The status is set to 0. 
%                    
function [folder_name, status] = makefolder(folder_name)      
    
    % if the name is an existing Matlab function 
    if exist(folder_name) == 5 

        errordlg('Invalid file name, please pick one that does not coincide with a built-in Matlab Function');
        status = 1;
        return;
    
    end   
    
    if ~exist(folder_name)
    
        mkdir(folder_name);          
    
    end
    
    folder_name = folder_name; 
    status = 0;
end