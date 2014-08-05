% function setup_Correlation_Tool
%
% Description:
%       
%   This is a set up function to adds two folders to your search path. The
%   two folders are Correlation_V2_GUI_Functions and
%   Correlation_V2_Core_Function. 
%
% Fields: None
%
%   
% Initial conditions: None
%     
%
% Final conditions: 
%
%     Add the two folders to the Matlab search path. 
%

function setup_Correlation_Tool

    addpath('Correlation_V2_GUI_Functions','Correlation_V2_Core_Function');
  	disp('Setup Completed');
  
end