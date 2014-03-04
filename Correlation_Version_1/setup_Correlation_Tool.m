% function setup_Correlation_Tool
%
% Description:
%       
%   This is a set up function to add two folders to your search path. The
%   two folders are Correlation_Tool_Core_Functions and
%   Correlation_Tool_GUI_Specific_functions. These are two core folders
%   that makes the GUI function. It also opens guide for your convenience
%   to launch the GUI.
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

    addpath('Correlation_Tool_Core_Functions','Correlation_Tool_GUI_Specific_functions', 'Correlation_Test_Suit');
    guide
  
end