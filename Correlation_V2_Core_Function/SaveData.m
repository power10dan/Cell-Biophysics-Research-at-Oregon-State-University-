% function SaveData(image_name)  
% Description:      
%    This function saves program data
%
% Fields:
%     experiment: data to be saved 
%     
% Initial conditions:     
%     experiment must be an image data type
%
% Final conditions:  none
%     

function SaveData (experiment_name, handles, figure)   
    
    folder_name = 'Experiment Data';  
    
    if ~exist( folder_name)       
        mkdir(folder_name);       
    end
    
    cur_dir = pwd;
    output_folder = strcat(cur_dir, filesep, folder_name);
    cd(output_folder);
    % name experimental figures
    name_original_image = sprintf('%s.fig', experiment_name);
    name_corr = sprintf('%s_corr_map.fig', experiment_name);
    name_peak = sprintf('%s_peak_map.fig', experiment_name);
    % get expeirmental images and save them in .fig file
    Save_Fig(handles.axes10, name_original_image);
    Save_Fig(handles.axes6, name_corr);
    Save_Fig(handles.axes11, name_peak);
    cd ..
    
end

function Save_Fig(axe, name_data)
    axes(axe);
    Fig2 = figure;
    AxesH = axe;
    copyobj(AxesH, Fig2);
    set(gca,'Unit','normalized','Position',[0 0 1 1])
    set(gcf,'Position',[100,100,500,500]);
    set(gcf,'color','w');
    cwd = pwd;
    var_path = strcat(pwd, name_data);
    %export_fig(var_path,'-fig');
    saveas(Fig2,  name_data, 'fig');
    close(Fig2); 
end