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

    % get theta inputs
    theat_user_input_begin = get(handles.edit11, 'Value');
    theta_user_input_step  = get(handles.edit12, 'Value');
    theta_user_input_range = get(handles.edit13, 'Value');
    
    % get brange inputs
    brange_user_input_begin = get(handles.edit1, 'Value');
    brange_user_input_step  = get(handles.edit9, 'Value');
    brange_user_input_range = get(handles.edit10, 'Value');
    
    % get sigma 
    sigma_user_input = get(handles.edit2, 'Value');
    
    % check if user inputs for theta and brange are positive integers
    if (sign(theat_user_input_begin) == 1 && mod(theat_user_input_begin, 1) == 0) ...
        && (sign(theta_user_input_step) == 1 &&  mod(theat_user_input_step, 1)== 0 ) ...
        && (sign(theta_user_input_range) == 1 && mod(theat_user_input_range, 1) == 0)
    
        if (sign( brange_user_input_begin ) == 1 && mod( brange_user_input_begin , 1) == 0) ...
            && (sign(brange_user_input_step) == 1 &&  mod(brange_user_input_step, 1)== 0 ) ...
            && (sign( brange_user_input_range) == 1 && mod( brange_user_input_range, 1) == 0)
        
            if sign(sigma_user_input) == 1 % check if user input for sigma is positive 
        
                theta_value = [ theat_user_input_begin theta_user_input_step  theta_user_input_range ];
                brange      = [ brange_user_input_begin  brange_user_input_step brange_user_input_range ];
                sigma       = sigma_user_input;
                return;
    
    
            end
     
        end
        
    else
        
        errordlg('Your inputs for theta, brange, or sigma is wrong. Inputs for theta and brange must be positive integers and sigma must be positive integer or decimal value');
       
        theta_value = '';
        brange      = '';
        sigma       = '';
        
    end
  
end

