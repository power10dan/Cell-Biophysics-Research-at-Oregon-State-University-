function Export_Data(saved_data, type, mode)

    % if statements to test which mode the user choose
    % and what type of data is being saved i.e. is it a correlation matrix?
    if strcmp(mode, 'Sub-window-Analysis') == 1
        if strcmp(type, 'Input Arguments') == 1
            save ('Input_Arguments_Subwindow','saved_data');
        elseif strcmp(type, 'Nematic-Peak-Map') == 1
            save('Peak-Map-Subwindow-Analysis', 'saved_data');
        elseif strcmp(type, 'Nematic-Graph') == 1
            save('Nematic_Graph', 'saved_data');
        else
            save('Additional_Parameters_Subwindow', 'saved_data');
        end
    else
        if strcmp(type, 'Input Arguments') == 1
            save('Input_Arguments_Regular_Corr', 'saved_data');
        elseif strcmp(type, 'Regular-Corr-Map') == 1
            save('Regular-Correlation-Map', 'saved_data');
        elseif strcmp(type, 'Regular-Peak-Map') == 1
            save('Regular-Corr-Peak-Map', 'saved_data');
        else
            save('Additional_Parameters_Regular_Corr', 'saved_data');
        end
    end    
end

