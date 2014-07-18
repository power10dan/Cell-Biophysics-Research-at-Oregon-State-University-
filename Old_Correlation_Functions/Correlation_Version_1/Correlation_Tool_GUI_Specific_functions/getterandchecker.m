% function [angle,B,Sig, status] = getterandchecker(handle,status)
%
% Description:
%       
%    This function gets the theta, Brange, and Sigma values from the
%    listbox. Then, it checks whether those values are valid or not. If
%    they are, the program returns them and sets the status to 0. 
%
%
% Fields:
%
%    handle: Graphical Handle 
%    status: status to be returned
%
% Initial conditions: 
%    Handle must be a GUI handle, status must be a type int. 
%
% Final conditions: 
%
%    Returns the sanitized theta, Brange, Sigma for the correlation 
%    analysis and status = 0 on success. If failure, the status is set to 1 
%    and the return parameters are set to empty strings. 
%     
function [angle,B,Sig, status] = getterandchecker(handle,status)
  
    angle_temp = get(handle.edit2,'string');
    B_temp = get(handle.edit3,'string');
    Sig_temp = get(handle.edit4, 'string');
        
    Sig_temp = str2num(Sig_temp);
   
    if isempty(angle_temp) || isempty(Sig_temp) || isempty(B_temp)
  
        errordlg('One of your fields for theta, sigma, brange is empty or you did not select an image');
        angle = '';
        B = '';
        Sig = '';
        status = 1;
        return;
           
    end 
    
    % Check theta and Brange input 
    [thet,Bran] = sanitize(angle_temp,B_temp);
   
    % If the return values for sanitize are empty, something went wrong
    if strcmp(thet,'') == 1|| strcmp(Bran,'') == 1
      
        angle = '';
        B = '';
        Sig = '';
        status = 1;
        return;
        
    end
    
     if isscalar(Sig_temp) == 0
        
        errordlg('Your sigma value is not a number, please re-enter');
        status = 1;
        return;
        
     end
       
    angle = thet;
    B = Bran;        
    Sig = Sig_temp;
    status = 0;
end