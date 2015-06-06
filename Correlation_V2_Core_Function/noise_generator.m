function noiseimage = noise_generator(imagename, noiselevel,noise_amp)
%     imagename
%     I = imread(imagename);
    temp = rand(size(imagename));
    noise = single((temp > noiselevel))*noise_amp;
    noiseimage = single(imagename)+noise;
end