function img = Line_Gen(xsize, ysize, num_lines_hor, num_lines_vert)
% short: less than 20% of diagnal length
line_img = zeros(xsize,ysize);
hold on;

for idx = 1:num_lines_hor
    x1 = 1;
    y1 = randi([1,ysize]);
    x2 = xsize;
    y2 = randi([1,ysize]);
    line_img = bresenhamLine(line_img,[y1,x1],[y2,x2],10);
end

for idx = 1:num_lines_vert
    y1 = 1;
    x1 = randi([1,xsize-1]);
    y2 = ysize;
    x2 = randi([1,xsize]);
    line_img = bresenhamLine(line_img,[y1,x1],[y2,x2],10);
end
hold off;
imagesc(line_img);
img = line_img;
end


