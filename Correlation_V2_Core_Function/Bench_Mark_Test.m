% Script that performs automated testing and graph generation. 
% The script generates three types of graphs: number of lines detected vs. 
% number of lines generated, number of lines detected vs. distance
% threshold input, and finding the case where the higher the input
% threshold actually yields more lines. It reads in from selected image
% folders and performs automated testing and plotting of data. Timing is
% also performed on the functions to be tested. The functions to be tested
% are MaxIntensityFinding.m, correlation_line.m, and correlation_line_sw.m. 

function Bench_Mark_Test(file_name, thet_range, b_range, sigma)
    disp('Test has begun');
    dir_list = dir(file_name);
    num_file = numel(dir_list);
    disp('Directory read. Reading Files');
    % init variables
    result_array = cell(1,4000);
    time_corr_array = cell(1,4000);
    time_peak_find_array = cell(1,4000);
    dist_array = cell(1,4000);
%     
%     for idx = 3:5 % ignore . and .., which are directories
%        image_to_be_analyzed = imread(dir_list(idx).name);
%        testimage = single(image_to_be_analyzed);
%        sz_img = size(testimage);
%        % perform correlation analysis via user input
%        disp('Performing Correlation Whole Image Analysis');
%        tic;
%        corr = correlation_line(testimage, thet_range, b_range, sigma);
%        figure, imagesc(corr)
%        t2 = toc;
%        fprintf('Time for correlation: %d\n', t2);
%        time_corr_array{idx} = t2;
%        
%        % peak finding
%        disp('Performing Peak Finding to find max line threshold')
%        % increase idx3 until count_peak returns 1.
%        idx3 = 2;% value at 1 gives funny results. 1 is not supported by the GUI too
%        corr_thresh_idx = 1;
%  
%        while (idx3 < sz_img(1))
%            tic;
%            peak_map = MaxIntensityFinding(corr, idx3);
%            tpeak = toc;
%            time_peak_find_array{idx} = tpeak;
%            indices_max_label_map = find(peak_map == 1);
%            if numel(indices_max_label_map) ~= 0
%                number_lines_detected = numel(indices_max_label_map);
%                dist_array{idx3} = number_lines_detected;            
%                if number_lines_detected == 1
%                    Plot_Dist(dist_array);
%                    break
%                end
%            end
%            idx3 = idx3 + 1; 
%        end 
%        
%        while (idx3 < sz_img(1))
%            tic;
%            corr_thresh_idx
%            corr(corr < (max(corr(:)) / corr_thresh_idx)) = 0;
%            figure, imagesc(corr)
%            peak_map = MaxIntensityFinding(corr, idx3);
%            tpeak = toc;
%            time_peak_find_array{idx} = tpeak;
%            indices_max_label_map = find(peak_map == 1);
%            if numel(indices_max_label_map) ~= 0
%                number_lines_detected = numel(indices_max_label_map);
%                dist_array{idx3} = number_lines_detected;            
%                if number_lines_detected == 1
%                    Plot_Dist(dist_array);
%                    break
%                end
%            end
%            idx3 = idx3 + 1;
%            corr_thresh_idx = corr_thresh_idx + 0.1;
% 
%        end 
%     end    
% %     Plot_Line_Detected(result_array, num_lines);
% %     Plot_Time_Graph(time_array, num_file);
% end
% 
% function Plot_Dist(threshold_array)
%     sz_dist = size(cell2mat(threshold_array));
%     sz_array = 1:1:sz_dist(2);
%     % setup canvas 
%     figure('Units', 'pixels', 'Position', [100 100 500 375]);
%     hold on;   
%     dist_plot = line( sz_array, cell2mat(threshold_array));  
%     find(cell2mat(threshold_array) == 20)
%     set(dist_plot, ...
%         'LineWidth'       , 1 , ...
%         'Marker'          , 'o', ...
%         'MarkerSize'      , 6, ...
%         'MarkerEdgeColor' , [.2 .2 .2], ...
%         'MarkerFaceColor' , [.7 .7 .7]);

end
 
% function Plot_Line_Detected(result_array, num_lines)
%     % average the result
%     dim = ndims(result_array{1}); %# Get the number of dimensions for your arrays
%     M = cat(dim+1,result_array{:}); %# Convert to a (dim+1)-dimensional matrix
%     meanArray = mean(M,dim+1);  %# Get the mean across arrays   
%     % setup canvas 
%     figure('Units', 'pixels', ...
%     'Position', [100 100 500 375]);
%     hold on
%     % plot result
%     plot(meanArray, num_lines, ... 
%         'Marker', 'o' , ...
%         'MarkerSize', 5, ...
%         'MarkerEdgeColor' , 'none', ...
%         'MarkerFaceColor' , [.75 .75 1] );
% end
% 
% function Plot_Time_Graph(time_array, num_file)
%     % average the result
%     dim = ndims(result_array{1}); %# Get the number of dimensions for your arrays
%     M = cat(dim+1,result_array{:}); %# Convert to a (dim+1)-dimensional matrix
%     meanArray = mean(M,dim+1);  %# Get the mean across arrays   
%     % setup canvas 
%     figure('Units', 'pixels', 'Position', [100 100 500 375]);
%     hold on
%     plot(meanArray, num_file);
% end
% 
% 



