% function corr_res = Analysis(theta_range,brange,sigma, image_path)
%
% Description:
%
%    This is a wrapper function for the correlation_line and
%    correlation_line_sw programs
%
% Fields:
%      theta_range: Angle range for image
%      brange: the translational range for the image
%      sigma: The correlation factor
%      image_path: path to the image to be analyzed
%      mode: mode command for choosing which program to use
%
% Initial conditions:
%      theta_range and brange must be of type integer and are
%      in the form "<start>:<step>:<end>". sigma can be integer or decimal values.
%      image_path must be a string type variable.
%      mode is a type string
%
% Final conditions:
%      Returns a correlation analysis map
%
function [corr_res, nematic_graph, absgrid_return] = Analysis(mode,theta_range,brange,sigma, ...
                                                 image, pars_mode, handles)
    [image_input, theta_input, b_range_input] = ImageAnaylsisHelper(image, ...
                                                      theta_range, brange);
    if isempty(fieldnames(pars_mode))
        errordlg('Please Set Your Additional Parameters');
        corr_res = '';
        nematic_graph = '';
        return
    end
    %TODO: HOUGH COLOR SCHEME FOR PLOTTING LINES OF VARIOUS ANGLE  
    % default sub-image-size, subject to change   
    if strcmp(mode, 'Regular-Corr-Analysis') == 1
        if isempty(pars_mode.Threshold) == 0        
            if str2num(pars_mode.Threshold) < 1 
                errordlg('Your threshold values must be bigger than 1');
                corr_res = '';
                nematic_graph = '';
                return;
            end
        end
        h = waitbar(0.1, 'Image loaded, performing correlation and peak finding now');
        corr = correlation_line(image_input, theta_input, b_range_input, sigma); 
        waitbar(0.25,h,'analysis complete, patching up data for display');
        if isempty(pars_mode.Threshold) == 1
            corr_res = corr;
            nematic_graph = '';
            absgrid_return = '';
        else
            corr(corr < (max(max(corr)) / str2num(pars_mode.Threshold))) = 0;
            corr_res = corr;
            nematic_graph = '';
            absgrid_return = '';
        end
    else
        h = waitbar(0.1, 'Image loaded, performing correlation sub-window analysis');        
       [origrid,absgrid, corr,nematicgraph,colsubimgs]= fiberorientation(image_input, ...
                                                            theta_range, ...
                                                            brange,  ...
                                                            sigma, pars_mode);
        corr_res = corr;
        nematic_graph = nematicgraph;
        absgrid_return = absgrid;
    end
    waitbar(1,h,'Analysis operation Complete ');
    pause(0.3); % let the user see the analysis complete message
    close(h);
end

function [image_output, theta_input, b_range_input] = ImageAnaylsisHelper( ...
                                                      image_to_be_analyzed, ...
                                                      theta, brange)
    image_output = single(image_to_be_analyzed);
    image_output = rgb2gray(image_output);
    theta_input = [theta(1),theta(2),theta(3)];
    b_range_input = [brange(1),brange(2),brange(3)];
end
