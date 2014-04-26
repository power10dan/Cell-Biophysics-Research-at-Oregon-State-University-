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
    sprintf('processing line number: %d',lineind)
    

    testimage = imnoise(testimage, 'salt & pepper', 0.03);
    corr = correlation_line(testimage,angrange,transrange,sigma);
    Intensities_Normalization_Fun(corr);
    
    filename = [sprintf('testline_%04d',lineind),'.png'];
    figure,100;
    subplot(2,1,1);
    imagesc(testimage);
    subplot(2,1,2);
    imcontour([-halfdiaglen,halfdiaglen],[0,179],corr);
    set(gcf,'Position',[100,100,600,900]);
    export_fig([outputfolder,filesep,filename],'-png');
    close,100;
    lineind = lineind+1;
end
 

for i=1:nvlines
    yp1 = 1;
    xp1 = randi([1,xsize-1]);
    yp2 = ysize;
    xp2 = xsize-xp1;
    testimage = bresenhamLine(testimage,[yp1,xp1],[yp2,xp2],200);
    sprintf('processing line number: %d',lineind)
  
    testimage = imnoise(testimage, 'salt & pepper', 0.03);
    corr = correlation_line(testimage,angrange,transrange,sigma);
    Intensities_Normalization_Fun(corr);
    
    filename = [sprintf('testline_%04d',lineind),'.png'];
    figure,100;
    subplot(2,1,1);
    imagesc(testimage);
    subplot(2,1,2);
    imcontour([-halfdiaglen,halfdiaglen],[0,179],corr);
    imagesc(corr);
    set(gcf,'Position',[100,100,600,900]);

    export_fig([outputfolder,filesep,filename],'-png');
    close,100;
    lineind = lineind+1;
end

for i=1:nplines
    yp1 = 1;
    xp1 = randi([1,xsize-1]);
    yp2 = ysize;
    xp2 = xp1;
    testimage = bresenhamLine(testimage,[yp1,xp1],[yp2,xp2],200);
    sprintf('processing line number: %d',lineind)

    testimage = imnoise(testimage, 'salt & pepper',0.03);
    corr = correlation_line(testimage,angrange,transrange,sigma);
    Intensities_Normalization_Fun(corr);
    
    filename = [sprintf('testline_%04d',lineind),'.png'];
    figure,100;
    subplot(2,1,1);
    imagesc(testimage);
    subplot(2,1,2);
    imcontour([-halfdiaglen,halfdiaglen],[0,179],corr);
    imagesc(corr);
    set(gcf,'Position',[100,100,600,900]);

    export_fig([outputfolder,filesep,filename],'-png');
    close,100;
    lineind = lineind+1;

end
    

end     