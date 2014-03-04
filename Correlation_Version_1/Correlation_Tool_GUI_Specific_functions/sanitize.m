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

function [sanitized1, sanitized2] = sanitize(string_input1, string_input2)
    
    % Regular expression to check for forbidden inputs
    exp2 = '[a-zA-Z!@#$%^&*(){}[][^''];:\/\\+\s.,]';
   
    % Extract forbidden inputs 
    match = regexp(string_input1, exp2, 'match');
    match2 = regexp(string_input2, exp2, 'match');  
    
    % Regular expression to extract user input
    exp = '\:';
    
    % Extract user input base on semi-colon delimiter and output the result
    % to a variable. 
    string_new1 = regexp(string_input1, exp, 'split');
    string_new2 = regexp(string_input2,exp,'split');    
    
    % Check if there are forbidden characters or if the user input is not
    % sufficient. 
        
    value = errorchecking(match, match2);
   
    if value == 0
       
        sanitized1 = '';
        sanitized2 = '';
        return;
    
    end 
    
    % Get user input, change them to numeric values
    first = str2num(string_new1{1});
    second = str2num(string_new1{2});
    third = str2num(string_new1{3});
    final = [first,second,third];
    
    first2 = str2num(string_new2{1});
    second2 = str2num(string_new2{2});
    third2 = str2num(string_new2{3});
    
    final2 = [first2,second2,third2];
    
    check_sign_theta = sign(final);
    check_sign_brange = sign(final2);
    
    if numel(check_sign_theta(check_sign_theta < 0)) > 0 
        errordlg('Your theta inputs may not be negative');
        sanitized1 = '';
        sanitized2 = '';
        return;
    
    end
    
    if numel(check_sign_brange(check_sign_brange < 0)) > 0
        errordlg('Your brange inputs may not be negative');
        sanitized1 = '';
        sanitized2 = '';
        return;
    end   
    
    if ~isnumeric(final2) 
       
        errordlg('Your inputs must be numbers');
        sanitized1 = '';
        sanitized2 = '';
        return;
        
    end
  
    sanitized1 = final;
    sanitized2 = final2;
end