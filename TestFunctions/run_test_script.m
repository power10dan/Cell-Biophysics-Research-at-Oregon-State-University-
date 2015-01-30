num_v_lines = 9;
num_h_lines = 1;

xsize = 100;
ysize = 100;
num_image = 4;
mkdir('Test_Image_Folder');
%generate 2000 images
for idx = 1:num_image
    img = Line_Gen(xsize,ysize, num_h_lines, num_v_lines);
    image_name = sprintf('line_img_%d.png', idx);
    cd Test_Image_Folder\
    imwrite(img, image_name);
    cd ..
end

close all;