% function [sanitized1, sanitized2] = sanitize(string_input1, string_input2)
%
% Description:
%
%    This function checks the user input, parse the input using the
%    semi-colon as the delimiter, and returns the values the user inputs
%    using a regular expression. 
%   
% Fields:
%
%    string_input1: string input 1 to be checked  
%    string_input2: string input 2 to be checked 
%
% Initial conditions: 
%    Both fields must be of string value
%
% Final conditions: 
%    Returns the values of the user input. 
% 

function [sanitized_theta, sanitized_brange] = sanitize(theta_input, brange_input2)
    
    % Regular expression to check for forbidden inputs
    exp2 = '[a-zA-Z!@#$%^&*(){}[][^''];:\/\\+\s.,]';
   
    % Extract forbidden inputs 
    forbidden_extraction_matrix_theta = regexp(theta_input, exp2, 'match');
    forbidden_extraction_matrix_brange = regexp(brange_input2, exp2, 'match');  
    
    % Regular expression to extract user input
    exp = '\:';
    
    % Extract user input base on semi-colon delimiter and output the result
    % to a variable. 
    theta_extraction = regexp(theta_input, exp, 'split');
    brange_extraction = regexp(brange_input2,exp,'split');    
    
    % Check if there are forbidden characters or if the user input is not
    % sufficient. 
        
    is_pass_test = input_size_check(forbidden_extraction_matrix_theta, forbidden_extraction_matrix_brange);
   
    if is_pass_test == 0
       
        sanitized_theta = '';
        sanitized_brange = '';
        return;
    
    end 
    
    % Get user input, change them to numeric values
    first = str2num(theta_extraction{1});
    second = str2num(theta_extraction{2});
    third = str2num(theta_extraction{3});
    final = [first,second,third];
    
    first2 = str2num(brange_extraction{1});
    second2 = str2num(brange_extraction{2});
    third2 = str2num(brange_extraction{3});
    
    final2 = [first2,second2,third2];
    
    check_sign_theta = sign(final);
    check_sign_brange = sign(final2);
    
    if numel(check_sign_theta(check_sign_theta < 0)) > 0 
        errordlg('Your theta inputs may not be negative');
        sanitized_theta = '';
        sanitized_brange = '';
        return;
    
    end
    
    if numel(check_sign_brange(check_sign_brange < 0)) > 0
        errordlg('Your brange inputs may not be negative');
        sanitized_theta = '';
        sanitized_brange = '';
        return;
    end   
    
    if ~isnumeric(final2) 
       
        errordlg('Your inputs must be numbers');
        sanitized_theta = '';
        sanitized_brange = '';
        return;
        
    end
  
    sanitized_theta = final;
    sanitized_brange = final2;
end