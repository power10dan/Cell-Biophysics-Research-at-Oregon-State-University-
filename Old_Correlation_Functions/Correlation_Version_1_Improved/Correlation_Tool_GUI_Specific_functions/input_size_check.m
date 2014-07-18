% function value = input_size_check(match1, match2)
%
% Description:
%
%    This function checks the user input, parse the input using the
%    semi-colon as the delimiter, and returns the values the user inputs
%    using a regular expression. 
%   
% Fields:
%
%    match1: Array 1 that contains the forbidden characters for string input
%    1
%    match2:  Array 2 that contains the forbidden characters for string
%    input 2 
%
%    string_new1: Array that has the values of the user input for string
%    input 1
%    string_new2: Array that has the values of the user input for stirng
%    input 2
%
% Initial conditions: 
%    
%   All fields must be of string input
%   
%
% Final conditions: 
%   Returns 1 if the errorchecking passes or 0 if fails. Displays the error
%   message if fails. 
%    
function value = input_size_check(match1, match2)

    
    if (numel(match1) > 2 && numel(match2) > 2) || (numel(match1) < 2 && numel(match2) < 2)
       
        errordlg('Both Theta Range and Brange have wrong inputs, please input them like the following: <start>:<step>:<end> with no spaces between');
        value = 0;
        return;
        
    end
    
    % if there are more than 2 values extracted  for theta 
    if numel(match1) > 2 || numel(match1) < 2
        
        errordlg('You have the wrong input for Theta, please input like the following: <start>:<step>:<end> with no spaces between');
        value = 0;
        return;
        
    end
    % if there are more than 2 values extracted  for Brange
    if  numel(match2) > 2 || numel(match2) < 2
        
        errordlg('You have wrong input for Brange, please input like the following: <start>:<step>:<end> with no spaces between');
        value = 0;
        return;
        
    end
    value = 1;
end