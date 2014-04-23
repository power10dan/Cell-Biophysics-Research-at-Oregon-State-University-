function test_randlines_test_fun(testimage)

    % generate sample line images
    sigma  = 1.1;
    angrange = [0,1,179];
    imgsize = size(testimage);
    xsize = imgsize(2);
    ysize = imgsize(1);
    halfdiaglen = floor(sqrt(xsize^2+ysize^2)/2);

   
    for idx = 1:10
        transrange = [-halfdiaglen,1,halfdiaglen];

        imgsize = size(testimage);
        xsize = imgsize(2);
        ysize = imgsize(1);
        imagesc(testimage)

        xp1 = 1;
        yp1 = randi([1,ysize-1]);
        xp2 = xsize;
        yp2 = ysize-yp1;
        testimage = bresenhamLine(testimage,[yp1,xp1],[yp2,xp2],200);
        
        % put some noises on image
        testimage = imnoise(testimage, 'salt & pepper');

        corr = correlation_line(testimage,angrange,transrange,sigma);
   
    end
    
    figure,imagesc(testimage)
    
    Data_Visualization_Fun(corr);

end
   