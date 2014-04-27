function [testimage,corr] = test_randlines(testimage, nhlines, nvlines,...
                                           nplines, outputfolder)
sigma  = 1.1;
angrange = [0,1,179];
imgsize = size(testimage);
xsize = imgsize(2);
ysize = imgsize(1);
halfdiaglen = floor(sqrt(xsize^2+ysize^2)/2);

transrange = [-halfdiaglen,1,halfdiaglen];

imgsize = size(testimage);
xsize = imgsize(2);
ysize = imgsize(1);
mkdir(outputfolder);
lineind = 1;

for i=1:nhlines
    xp1 = 1;
    yp1 = randi([1,ysize-1]);
    xp2 = xsize;
    yp2 = ysize-yp1;
    testimage = bresenhamLine(testimage,[yp1,xp1],[yp2,xp2],200);
    lineind = lineind+1;
end

for i=1:nvlines
    yp1 = 1;
    xp1 = randi([1,xsize-1]);
    yp2 = ysize;
    xp2 = xsize-xp1;
    testimage = bresenhamLine(testimage,[yp1,xp1],[yp2,xp2],200);
    lineind = lineind+1;
end

for i=1:nplines
    yp1 = 1;
    xp1 = randi([1,xsize-1]);
    yp2 = ysize;
    xp2 = xp1;
    testimage = bresenhamLine(testimage,[yp1,xp1],[yp2,xp2],200);
    lineind = lineind+1;

end
total_lines = nplines+nvlines+nhlines;

sprintf('Total number of lines: %d', total_lines)

testimage = imnoise(testimage, 'speckle', 0.15);

corr = correlation_line(testimage,angrange,transrange,sigma);
Intensities_Normalization_Fun(corr);
figure, imagesc(testimage);
title('Raw Image with Speckle Artificial Noise with Variance of 0.15','FontSize', 14, 'FontWeight', 'bold');

label_string_x = 'Translation (pixels)';
label_string_y = 'Angle (Degrees)';

xlabel(label_string_x, 'FontSize', 12, 'FontWeight', 'bold');
ylabel(label_string_y,'FontSize', 12, 'FontWeight', 'bold');

end     