function test_noise_graph(noise_type, num_files)

    fprintf('Current Noise Type: %s\n', noise_type);
    
    path_1 = 'C:\Users\Sungroup\Documents\MATLAB\Dan\Program_working\Software Package\Correlation_V2\Correlation_V2_Core_Function\test_4000_10_lines\';
    path_2 = 'C:\Users\Sungroup\Documents\MATLAB\Dan\Program_working\Software Package\Correlation_V2\Correlation_V2_Core_Function\test_4000_20_lines\';
    path_3 = 'C:\Users\Sungroup\Documents\MATLAB\Dan\Program_working\Software Package\Correlation_V2\Correlation_V2_Core_Function\test_30_lines\';
    path_4 = 'C:\Users\Sungroup\Documents\MATLAB\Dan\Program_working\Software Package\Correlation_V2\Correlation_V2_Core_Function\test_40_lines\';
    path_5 = 'C:\Users\Sungroup\Documents\MATLAB\Dan\Program_working\Software Package\Correlation_V2\Correlation_V2_Core_Function\test_50_lines\';
    
    %read in line files
    files_10_lines = dir(path_1);
    files_20_lines = dir(path_2);
    files_30_lines = dir(path_3);
    files_40_lines = dir(path_4);
    files_50_lines = dir(path_5);

    perform_test(files_10_lines, num_files, path_1, noise_type);
%     perform_test(files_20_lines, num_files, path_2, noise_type);
%     perform_test(files_30_lines, num_files, path_3, noise_type);
%     perform_test(files_40_lines, num_files, path_4, noise_type); 
%    
    
end

function perform_test(file_struct, num_files, path, noise_type)

    %adjust noise max boundaries here
    noise_max = 0.5;
    optimal_corr_thresh = 1.4;
    
    %init data arrays
    data = zeros(num_files, length(0:0.05:noise_max));
    file_struct(1:2) = [];

    for idx = 1:num_files
       idx3 = 1;
       for idx2 = 0:0.05:noise_max
           idx2
           line_img = strcat(path, file_struct(idx).name)
           I = imread(line_img);
           
           if strcmp(noise_type, 'gaussian') == 1
                I= imnoise(I, noise_type, idx2);
                %figure, imagesc(I);
           end
           
           if strcmp(noise_type, 'salt & pepper') == 1
               I = imnoise(I, noise_type, idx2);
               %imagesc(I);
           end
           
           if strcmp(noise_type, 'speckle') == 1
               I = imnoise(I, noise_type, idx2);
               %imagesc(I);
           end
                     
           corr_map = correlation_line(single(I), [0 1 179], [-45 1 45], 1);
           corr_map(corr_map < (max(corr_map(:)) / optimal_corr_thresh)) = 0;
           
           new_peak_map = MaxIntensityFinding(corr_map, 2);
           num_peaks_corr_thresh = sum(new_peak_map(:));
           
           data(idx, idx3) = num_peaks_corr_thresh
           idx3 = idx3 + 1
       end
  
    end
        
    average = mean(data, 1)
    stderror_1 = std(average, 1)*ones(1,length(0:0.05:noise_max))
    figure, errorbar(0:0.05:noise_max, average, stderror_1);
    title(noise_type)
end