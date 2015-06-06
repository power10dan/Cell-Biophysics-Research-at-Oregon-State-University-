function Bench(file, theta, brange, sigma, num_file_calc)
    disp('Test has begun');
    dir_list = dir(file);
    num_file = num_file_calc;
    disp('Directory read. Reading Files');
    distthreshold = 2:1:10;
%     distthreshold = 2;
    corrthreshold = 1:0.1:1.5;
%     corrthreshold = 1.4;
    % init arrays
    nlinesdetected = zeros(size(distthreshold));
    errorlines = zeros(size(distthreshold));
    errortime = zeros(size(distthreshold));
    errortime_peak = zeros(size(distthreshold));
    meanlines = zeros(size(distthreshold));
    meantime = zeros(size(distthreshold));
    meantime_peak = zeros(size(distthreshold));
    time_corr_array = cell(size(distthreshold));
    time_peak_find_array = zeros(size(distthreshold));
    corrmapthreshold_array = zeros(num_file,size(distthreshold),length(corrthreshold));
     
    disp('Begin Correlation Whole Image Analysis')
    for nf  = 1:num_file
        [dir_name_path, name_file, extension] = fileparts(file);
        image_name = [dir_name_path,filesep,dir_list(nf).name];
        for noise_level = 0.1:0.1:0.9
            disp('noise level generation')
            im = imread(image_name)
            im = noise_generator(im, noise_level, 200);
            figure, imagesc(im);
            disp('noise gen complete')
            disp('Performing Correlation Whole Image Analysis')
            [time_corr, corr_map] = Correlation_Analysis(theta, brange, ...
                                     sigma, im);  

            fprintf('Time for correlation: %d\n', time_corr);
            time_corr_array{nf} = time_corr;

            disp('Calculating Corr Map Threshold Vs Number of lines detected')
            corr_mapbkg = corr_map;

            for ncorrthresh = 1:length(corrthreshold)
                corr_map = corr_mapbkg;
                corr_map(corr_map < (max(corr_map(:)) / corrthreshold(ncorrthresh))) = 0;
                figure(200)
                imagesc(corr_map);

                for ndisth_adjusted_corr = 1:length(distthreshold)
                    tic
                    peak_map = MaxIntensityFinding(corr_map, distthreshold(ndisth_adjusted_corr));
                    tpeak = toc;
                    time_peak_find_array(ncorrthresh, ndisth_adjusted_corr) = tpeak;
                    fprintf('Time for max computation for each threshold for adjusted corr map: %d\n', tpeak);            
                    num_peaks_corr_thresh = sum(peak_map(:));
                    corrmapthreshold_array(nf, ndisth_adjusted_corr,ncorrthresh) = num_peaks_corr_thresh;
                end

                sprintf('%d threshold done', corrthreshold(ncorrthresh))
            end
        end

        sprintf('%d out of %d images calculated ',nf, num_file)
    end

    for ncorrthresh = 1:length(corrthreshold)
        hold on
        figure(ncorrthresh)
        nlinesdetected = squeeze(corrmapthreshold_array(:,:,ncorrthresh));
        meanlines = mean(nlinesdetected,1);
        errorlines = std(nlinesdetected,[],1);
        plot(distthreshold, meanlines, 'ro');
        %errorbar(distthreshold,meanlines,errorlines,'ro'); 
        title(sprintf('corrthreshold is %0.3f',corrthreshold(ncorrthresh)));
        xlabel('Corrrelation Threshold');
        ylabel('Distance Threshold');
        zlabel('Number of Lines Detected');
    end
    
    % corr calculation average time for n number of files
    mean_corr = mean(cell2mat(time_corr_array));
    fprintf('Average total time for calculating images: %d\n', num_file, mean_corr); 
    % performance of peak finding as pixel increases
    meantime_peak = mean(time_peak_find_array, 1);
    errortime_peak = std(time_peak_find_array, [], 1);
    plot(distthreshold,meantime_peak,errortime_peak,'ro-');
    hold off

end

function [time_result, corr_map] = Correlation_Analysis(theta, brange, sigma, image)
%     image_to_be_analyzed = imread(image);
    testimage = single(image);
    % corr analysis and time performance
    tic;
    corr = correlation_line(testimage, theta, brange, sigma);
    imagesc(corr)
    t2 = toc;
    time_result = t2;
    corr_map = corr;
end


