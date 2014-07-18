function BenchMarkTesting(image_to_test)
  
    % make Test Folder
    if exist('TestFolder', 'dir') == 0
        
        mkdir('TestFolder');
     
    end

    cd TestFolder
    
    % Read in image 
    I = imread(image_to_test);
    image_to_be_tested_processed = im2single(I); 
    
    %test functions
    CorrelationaAndPeakFinding(image_to_be_tested_processed);
    
    
end

function CorrelationaAndPeakFinding(image_to_be_tested)
     
    %get size of image
    sz_image = size(image_to_be_tested);
    width = sz_image(2);
    height = sz_image(1);

    % initialization of variables
    image_crop_x = 100;
    image_crop_y = 100;

    for testcount = 1:20

        % create folders for each tests
        test_folder_name = sprintf('TestTrial_%d',testcount);
        mkdir(test_folder_name);

        random_height_start_loc = randi(height,1,1);
        random_width_start_loc  = randi(width,1,1);

        image_to_test_cropped = imcrop(image_to_be_tested,[random_height_start_loc, random_width_start_loc, ...
            image_crop_x,image_crop_y]);

        sz_cropped_image = size(image_to_test_cropped);
        width_cropped_image = sz_cropped_image(2);
        height_cropped_image = sz_cropped_image(1);

        halfdiaglen = floor(sqrt(width_cropped_image^2+height_cropped_image^2)/2);
        transrange  = [-halfdiaglen,1,halfdiaglen];
        ang = [0,1,179];
        sig = 1.1;
       
        corr = correlation_line(image_to_test_cropped, ang, transrange,sig);

       
        %cluster peaks algorithm? smarter way to do this? 
        % smartly determine threshold of image?
        % Learning algorithm?



        % my peak finding
        [Outlier_array, group_intense_array] = Intensities_Normalization_Fun(corr);

        processed_image_file_name = sprintf('Test_Corr_Trial%d', testcount);
        Export_Fig(corr,test_folder_name, processed_image_file_name);
        GenerateLineAndPrintResult(group_intense_array, Outlier_array, test_folder_name);

    end

end    
 
function GenerateLineAndPrintResult(array_1, array_2, test_folder_name)
    
    % make refline image big enough to accomdate big trans and angle
    % ranges
    wid_line_image = 600;
    height_line_image = 600;
    sig = 1.1;

    sz = size(array_1);

    for idx = 1:sz(2)

        array_content = array_1(:,idx);
        non_empty_array_content =  find(~cellfun(@isempty,array_content));

        if numel(non_empty_array_content) == 1

            theta_value = array_content{non_empty_array_content(1)}.average_coordinate_x;
            trans_value = array_content{non_empty_array_content(1)}.average_coordinate_y;

        else

            theta_value = array_content{non_empty_array_content(end)}.average_coordinate_x;
            trans_value = array_content{non_empty_array_content(end)}.average_coordinate_y;

        end

        refline = fuzzyline_gen(wid_line_image, height_line_image, theta_value,trans_value, sig);
        imagesc(refline);
        processed_image_detected_lines = sprintf('Test_line_detected_%d', idx);
        Export_Fig(refline,test_folder_name, processed_image_detected_lines);

    end

    for idx2 = 1:numel(array_2)

        outlier_theta  = array_2(idx2).average_coordinate_x;
        outlier_trans  = array_2(idx2).average_coordinate_y;
        refline_outlier = fuzzyline_gen(wid_line_image, height_line_image, outlier_theta ,outlier_trans, sig);
        imagesc(refline_outlier);
        processed_image_outlier_detected_lines = sprintf('Test_outlier_line_detected_%d', idx2);
        Export_Fig(refline,test_folder_name, processed_image_outlier_detected_lines);

    end
        
      
end

function Export_Fig(ref_line_image,testfoldername, processed_image_save_file_name)
    
    cur_dir = pwd;  
    output_folder = strcat(cur_dir, filesep, testfoldername);
    full_image_path_name = strcat(output_folder, filesep, processed_image_save_file_name);  
    
    %export file
    if ~exist(full_image_path_name)
        
        export_fig([output_folder,filesep,processed_image_save_file_name], '-png');
        
    end
 
end





