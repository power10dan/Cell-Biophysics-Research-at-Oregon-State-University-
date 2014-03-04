% function [mystring,name] = join_text(newitem, handles) 
%
% Description:
%   
%   This function joins the name of the files into one single continuous
%   string so displaying on the Image Bay would be easier. 
%    
%   
% Fields:
%
%   newitem: The string to be joined with the old string
%   handles: The GUI handle for Image Bay 
%
% Initial conditions: new item must be either a struct or cell array
%
% Final conditions:  mystring, the joined, continuous single string, and
% name, the new files the user decides to add to the image box

 function [mystring, name] = join_text(newitem, handles) 
     
    oldstring = get(handles, 'string');
            
    if isempty(oldstring)

        if ~isstruct(newitem)
          
            mystring = {newitem};
            name = {newitem};
            return;

        else
           
            mystring = {newitem(:).name};
            name = {newitem(:).name};
            return;

        end

    end

    if ~isstruct(newitem)
       
        mystring = vertcat(oldstring, newitem);
        name = {newitem};
        return;

    end   
    
    new = {newitem(:).name};
    name = new;
    new_size_adj = transpose(new); % make dimension of matrix agree   
    mystring = vertcat(oldstring,new_size_adj);
 end