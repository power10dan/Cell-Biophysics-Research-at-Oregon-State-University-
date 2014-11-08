function PeakFindingWrapper(mode_op, corr_data, handles, absgrid)
    if strcmp(mode_op, 'Regular-Corr-Analysis') == 1
        dist_threshold_user_input = str2num(get(handles.edit7, 'String'));
        new_peak_map = MaxIntensityFinding(corr_data, dist_threshold_user_input);
        CountMax(handles,new_peak_map);
        axes(handles.axes10);
        xLimits = get(gca,'XLim'); % Get the range of the x axis
        yLimits = get(gca,'YLim'); % Get the range of the y axis
        axes(handles.axes11);
        b_min = str2num(get(handles.edit1, 'String'));
        b_max = str2num(get(handles.edit10, 'String'));
        b_step = str2num(get(handles.edit9, 'String'));
        theta_min = str2num(get(handles.edit11, 'String'));
        theta_max = str2num(get(handles.edit13, 'String'));
        theta_step = str2num(get(handles.edit12, 'String'));
        imagesc(b_min:b_step:b_max,theta_min:theta_step:theta_max,new_peak_map);
        PlotPeakOnImage(handles);
    else
        h = waitbar(0.1, 'Performing Peak Finding For Nematic Graph');
        corr_res = zeros(size(absgrid));
        for i = 1:length(corr_res(:,1))
            for j = 1:length(corr_res(1,:))
                corrsubwd =squeeze(corr_data(i,j));
                temp1 = MaxIntensityFinding(corrsubwd, 3);
                corr_res(i,j) = sum(temp1(:));
            end
            waitbar(i/length(corr_res(:,1)), h);
        end
        CountMax(handles, corr_res);
        waitbar(1,h,'Analysis Complete');
        close(h);
        axes(handles.axes10);
        xLimits = get(gca,'XLim');  %# Get the range of the x axis
        yLimits = get(gca,'YLim');  %# Get the range of the y axis
        axes(handles.axes11);
        imagesc(xLimits, yLimits,corr_res);
    end
end