% function answer = prompt   
% 
% Description:
%       
%   This function prompts the user to enter the name of the destination
%   folder in which the user wants to save his or her files
%
% Fields:None
%
%   
% Initial conditions: None
%     
%
% Final conditions: 
%
%     Returns the name of the destination folder
%

function answer = prompt   

% prompts the user for a folder name 
    prompt = {'Enter the name of your folder you want your image to be saved in  if it is a current folder, type the name of the folder.'};
    dlg_title = 'Input';
    num_lines = 1;
    answer_temp = inputdlg(prompt,dlg_title,num_lines);
    
    if isempty(answer_temp)== 1 % user hit cancel button 
        answer = '';
        return;
        
    end
    
    if isempty(answer_temp{1})
    
        errordlg('You forgot to enter something in your dialog');
        answer = '';
        return;
        
    end
            
    answer = answer_temp;
end
