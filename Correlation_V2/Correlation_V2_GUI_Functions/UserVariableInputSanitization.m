% function [theta_value, brange, sigma] = UserVariableInputSanitization(handles)
%
% Description:
%
%    This function allows users to upload either a list of files or a single file
%    onto the image bay
%
% Fields: handles
%  
% Initial conditions: none
%    
%
% Final conditions:
%   Outputs checked and sanitized theta, brange, and sigma values.    
%
%    

function [theta_value, brange, sigma] = UserVariableInputSanitization(handles)

    theat_user_input = get(handles.edit3, 'Value');
    brange_user_input = get(handles.edit1, 'Value');
    sigma_user_input = get(handles.edit2, 'Value');
    
    
    
    

    



































end

