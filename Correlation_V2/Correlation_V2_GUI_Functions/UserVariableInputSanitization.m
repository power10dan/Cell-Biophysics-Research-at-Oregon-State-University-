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
    theta_user_input_begin = str2num(get(handles.edit11, 'String'));
    theta_user_input_step  = str2num(get(handles.edit12, 'String'));
    theta_user_input_range = str2num(get(handles.edit13, 'String'));
    
    % get brange inputs
    brange_user_input_begin = str2num(get(handles.edit1, 'String'));
    brange_user_input_step  = str2num(get(handles.edit9, 'String'));
    brange_user_input_range = str2num(get(handles.edit10, 'String'));
    
    % get sigma 
    sigma_user_input = get(handles.edit2, 'Value');

    
    if theta_user_input_begin > theta_user_input_range
        

        errordlg('Your origin in theta cannot be bigger than your range ');
        theta_value = '';
        brange      = '';
        sigma       = '';
        return
  
    end
    
    
    if brange_user_input_begin  >  brange_user_input_range
        
        errordlg('Your origin for B Eange cannot be bigger than your range');
        theta_value = '';
        brange      = '';
        sigma       = '';
        return
  
    end

    theta_check = (sign(theta_user_input_begin) == 1 && (mod(theta_user_input_begin, 1) == 0) ...
                  && (sign(theta_user_input_step) == 1 &&  (mod(theta_user_input_step, 1)== 0 )) ...
                  && (sign(theta_user_input_range) == 1 && (mod(theta_user_input_range, 1) == 0)));
              
    brange_check = sign( brange_user_input_begin ) == 1 && (mod( brange_user_input_begin , 1) == 0) ...
                   && (sign(brange_user_input_step) == 1 &&  (mod(brange_user_input_step, 1)== 0 )) ...
                   && (sign( brange_user_input_range) == 1 && (mod( brange_user_input_range, 1) == 0));
               
    sigma_check = sign(sigma_user_input) == 1;
    
    if theta_check == 1 && brange_check == 1 && sigma_check == 1
        
        theta_value = [ theta_user_input_begin theta_user_input_step theta_user_input_range ];
        brange      = [ brange_user_input_begin  brange_user_input_step brange_user_input_range ];
        sigma       = sigma_user_input;
        return;
          
        
    else
        
        errordlg('Your inputs for theta, brange, or sigma is wrong or empty. Please check your inputs. Inputs for theta and brange must be positive integers and sigma must be positive integer or decimal value');
       
        theta_value = '';
        brange      = '';
        sigma       = '';
        
    end
  
end

