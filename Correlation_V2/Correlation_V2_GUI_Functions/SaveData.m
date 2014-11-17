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

function SaveData (experiment_name, handles)   
    folder_name = 'Experiment Data';  
    if ~exist( folder_name)       
        mkdir(folder_name);       
    end    
    cur_dir = pwd; 
    output_folder = strcat(cur_dir, filesep, folder_name);
    cd(output_folder);
    % name experimental figures
    name_original_image = sprintf('%s.png', experiment_name);
    name_corr = sprintf('%s_corr_map.png', experiment_name);
    name_peak = sprintf('%s_peak_map.png', experiment_name);
    % get expeirmental images and save them in .fig file
%     org_img = getimage(handles.axes10);
    Save_Fig(handles.axes10);

%     Save_Fig(handles.axes6);
%     Save_Fig(handles.axes11);

    cd ..
    
end

function Save_Fig(axe)
    axes(axe);
    Fig2 = figure;
    AxesH = axe;
    copyobj(AxesH, Fig2);
    var_path = strcat('C:\Users\Sungroup\Documents\MATLAB\Dan\Program_working\Software Package\Correlation_V2\Correlation_V2_Core_Function\Experiment Data\saveddata.tif');
    export_fig(var_path,'-tif');
    set(gcf,'color','w');
end