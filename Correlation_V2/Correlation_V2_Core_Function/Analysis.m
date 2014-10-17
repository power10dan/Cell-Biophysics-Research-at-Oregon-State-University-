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
function [corr_res, nematic_graph] = Analysis(mode,theta_range,brange,sigma, image, pars_mode, handles)
    pars_mode
    [image_input, theta_input, b_range_input] = ImageAnaylsisHelper(image, theta_range, brange);
    if isempty(pars_mode)
        errordlg('Please Set Your Additional Parameters');
        corr_res = '';
        nematic_graph = '';
        return
    end
    %TODO: HOUGH COLOR SCHEME FOR PLOTTING LINES OF VARIOUS ANGLES
    % default sub-image-size, subject to change
    if strcmp(mode, 'Regular-Corr-Analysis') == 1
        h = waitbar(0.1, 'Image loaded, performing correlation and peak finding now');
        corr = correlation_line(image_input, theta_input, b_range_input, sigma); 
        waitbar(0.25,h,'analysis complete, patching up data for display');
        if isempty(pars_mode.Threshold) == 0
            % set map value under threshold value to zero
             corr(corr < (0.8*str2num(pars_mode.Threshold))) = 0;
             corr_res = corr;
             nematic_graph = '';             
        else
            corr_res = corr;
            nematic_graph = '';
        end
    else
        h = waitbar(0.1, 'Image loaded, performing correlation sub-window analysis');
        subwdsz = pars_mode.subwdsz;
        imagesz = size(image_input);
        end1 = floor(imagesz(1)/subwdsz(1))*subwdsz(1);
        end2 = floor(imagesz(2)/subwdsz(2))*subwdsz(2);
        image_input = image_input(1:end1,1:end2);
        
       [origrid,absgrid,corr,nematicgraph,colsubimgs]= fiberorientation(image_input,theta_range, brange, sigma,pars_mode);
        waitbar(0.25,h,'Analysis complete, plotting data');
        corr_res = zeros(size(absgrid));
        for i = 1:length(corr_res(:,1))
            for j = 1:length(corr_res(1,:))
                corrsubwd =squeeze(corr(:,:,i,j));
                temp1 = MaxIntensityFinding(corrsubwd, 3);
                corr_res(i,j) = sum(temp1(:));  
            end
        end
        nematic_graph = nematicgraph;
    end
    waitbar(1,h,'Analysis operation Complete ');
    pause(0.3); % let the user see the analysis complete message
    close(h);
end

function [image_output, theta_input, b_range_input] = ImageAnaylsisHelper(image_to_be_analyzed, theta, brange)
    image_output = single(image_to_be_analyzed);
    image_output = rgb2gray(image_output);
    theta_input = [theta(1),theta(2),theta(3)];
    b_range_input = [brange(1),brange(2),brange(3)];
end
