function BenchMarkTesting_New_Peak_Finding
  
    % make Test Folder
    if exist('TestFolder', 'dir') == 0
        
        mkdir('TestFolder');
     
    end

    for idx = 1:50
       
        I = GenerateTestImage;
        label_map = MaxIntensityFinding(I)
        
        PlotMapOnImage(label_map);
        
        processed_image_file_name = sprintf('Test_Corr_Trial%d', testcount);
        Export_Fig(corr,test_folder_name, processed_image_file_name);
  
    end
    
    
    
end

function GenerateTestImage

    






end


function PlotMapOnImage(map)









end




function Export_Fig(testfoldername, processed_image_save_file_name)
    
    cur_dir = pwd;  
    output_folder = strcat(cur_dir, filesep, testfoldername);
    full_image_path_name = strcat(output_folder, filesep, processed_image_save_file_name);  
    
    %export file
    if ~exist(full_image_path_name)
        
        export_fig([output_folder,filesep,processed_image_save_file_name], '-png');
        
    end
 
end





