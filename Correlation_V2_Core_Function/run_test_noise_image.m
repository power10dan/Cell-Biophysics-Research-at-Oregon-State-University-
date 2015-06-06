function run_test_noise_image(num_file)
    disp('Noise: Gaussian')
%     test_noise_graph('gaussian', num_file)
    disp('Noise: Speckle')
    test_noise_graph('speckle', num_file)
    disp('Noise: Salt & Pepper');
%     test_noise_graph('salt & pepper', num_file)
    
end