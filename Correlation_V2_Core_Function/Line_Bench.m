
function Line_Bench(file, theta, brange, num_lines, num_file_calc)
    disp('Test has begun for line bench');
    dir_list = dir(file);
    num_file = num_file_calc;
    disp('Directory read. Reading Files');
%     distthreshold = 2:1:10;
    distthreshold = 2;
%     corrthreshold = 1:0.1:2;
    corrthreshold = 1.1;     
    noise_threshold = 0.1:0.1:0.999;
     sigma = 0.9;
    % init arrays
    num_lines_detected = zeros(length(corrthreshold), length(noise_threshold));   
    disp('Begin Correlation Whole Image Analysis')
    for nf  = 1:num_file
        [dir_name_path, name_file, extension] = fileparts(file);
        image_name = [dir_name_path,filesep,dir_list(nf).name];
        im = imread(image_name);
        disp('Performing Correlation Whole Image Analysis')
        for idx = 1: length(corrthreshold)
            for idx2 = 1:length(noise_threshold)
                noise_threshold(idx2)
                image_name = noise_generator(im,0.7, 200);
                fprintf('We are at threshold at index %d\n', idx2);
                [time_corr, corr_map] = Correlation_Analysis(theta, brange, ...
                sigma, image_name);        
                fprintf('Time for correlation: %d\n', time_corr);
                time_corr_array{nf} = time_corr;
                disp('Calculating Corr Map Threshold Vs Number of lines detected')
                corr_map(corr_map < (max(corr_map(:)) / corrthreshold(idx))) = 0;
                peak_map = MaxIntensityFinding(corr_map, distthreshold);
                num_peaks_corr_thresh = sum(peak_map(:));
                nf 
                idx2
                num_lines_detected(nf,idx2) = num_peaks_corr_thresh
            end
        end
    end

    for ncorrthresh = 1:length(noise_threshold)
        hold on
        nlinesdetected = squeeze(num_lines_detected(:,ncorrthresh))
        meanlines = mean(nlinesdetected,1)
        errorlines = std(nlinesdetected,[],1);
        meanlines
        figure, plot(noise_threshold, meanlines, 'ro-');
        %errorbar(distthreshold,meanlines,errorlines,'ro'); 
        title(sprintf('corrthreshold is %0.3f',noise_threshold(ncorrthresh)));
        xlabel('Corrrelation Threshold');
        ylabel('Distance Threshold');
        zlabel('Number of Lines Detected');
    end
   
 end
    

function [time_result, corr_map] = Correlation_Analysis(theta, brange, sigma, image)
    image_to_be_analyzed = image;
    testimage = single(image_to_be_analyzed);
    % corr analysis and time performance
    tic;
    corr = correlation_line(testimage, theta, brange, sigma);
    %imagesc(corr)
    t2 = toc;
    time_result = t2;
    corr_map = corr;
end