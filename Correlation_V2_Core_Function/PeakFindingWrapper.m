function PeakFindingWrapper(mode_op, corr_data, handles, absgrid)

    dist_threshold_user_input = str2num(get(handles.edit7, 'String'));

    if strcmp(mode_op, 'Regular-Corr-Analysis') == 1
        
        new_peak_map = MaxIntensityFinding(corr_data, dist_threshold_user_input);
        Export_Data(new_peak_map, 'Peak-Map-Regular', 'Regular-Corr-Analysis');
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
%         figure, imagesc(b_min:b_step:b_max,theta_min:theta_step:theta_max,new_peak_map);
        imagesc(b_min:b_step:b_max,theta_min:theta_step:theta_max,new_peak_map);
        xlabel('Translation');
        ylabel('Theta');  
        PlotPeakOnImage(handles);
        
    else 
        
        h = waitbar(0.1, 'Performing Peak Finding For Nematic Graph');
        nematic_graph_peak_map = zeros(size(absgrid));
        if(length(size(corr_data))>2)
             corr_data = rgb2gray(corr_data);          
        end
        
        for i =  1:length(nematic_graph_peak_map(:,1))
            for j = 1:length(nematic_graph_peak_map(1,:))
                corrsubwd =squeeze(corr_data(i,j));
                temp1 = MaxIntensityFinding(corrsubwd, dist_threshold_user_input);
                nematic_graph_peak_map(i,j) = sum(temp1(:));
            end
            waitbar(i/length(nematic_graph_peak_map(:,1)), h);
        end     
        Export_Data(nematic_graph_peak_map, 'Nematic-Peak-Map', ... 
                    'Regular-Correlation-Analysis');
        waitbar(1,h,'Analysis Complete');
        close(h);
        axes(handles.axes10);
        xLimits = get(gca,'XLim');  % Get the range of the x axis
        yLimits = get(gca,'YLim');  % Get the range of the y axis
        axes(handles.axes11);
        imagesc(xLimits, yLimits,nematic_graph_peak_map);
    end
end