function Export_Data(saved_data, type, mode)

    if strcmp(mode, 'Sub-window-Analysis') == 1
        if strcmp(type, 'Input Arguments') == 1
            save ('Input_Arguments_Subwindow','saved_data');
        else
            save('Additional_Parameters_Subwindow', 'saved_data');
        end
    else
        if strcmp(type, 'Input Arguments') == 1
            save('Input_Arguments_Regular_Corr', 'saved_data');
        else
            save('Additional_Parameters_Regular_Corr', 'saved_data');
        end
    end    
end

