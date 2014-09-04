function [corr,spcorr,angles,trans,refline,colsubimgs] = correlation_line_sw(testimage, subimgsz,angrange,...
                                                brange, sigma)

%testimage: a 2-D matrix where the correlation voting will be performed
%subimagesz: [subxz,subyz], the testimage will be divided into subimages, 
%each has size of subimagesz to do the real correlation analysis
%angrange: [minimal angle, angle resolution, maximal angle]
%brange:   [minimal translation, translation resolution, maximal translation]

%corrdinate system:
%returns colsubimgs(:,i,:,j) and corr(:,:,i,j), 
%i increase moves to the bottom, j increase moves to the right


% variables initialization  
imgsize = size(testimage);
%single precision version
sgimgsize = single(imgsize);
sgsubimgsz = single(subimgsz);
sgtestimage = single(testimage);
sigma = single(sigma);


if(length(imgsize)>2)
    testimage = rgb2gray(testimgage);
end

if (rem(imgsize(1),subimgsz(1)) || rem(imgsize(1),subimgsz(1)))
    display('the subimage size does not match the whole image size');
    return
end



angles = angrange(1):angrange(2):angrange(3);
trans  = brange(1):brange(2):brange(3);
      
corr = zeros(length(angles), length(trans),...
    imgsize(1)/subimgsz(1),imgsize(2)/subimgsz(2));
%meshgrid(sx,sy) generates matrix of size [sy,sx], so we need to swap 
%the x and y size. Also making xsize, ysize single will genereate single 
%precision meshgrids;
xsize = sgimgsize(2);
ysize = sgimgsize(1);

%tile the whole image with meshgrid corresponding to subimage size
[Xmesh, Ymesh] = meshgrid(0:(xsize-1), 0:(ysize-1));
Xmesh = mod(Xmesh,subimgsz(2));
Ymesh = mod(Ymesh,subimgsz(1));

Xmesh = Xmesh - sgsubimgsz(2)/2;
Ymesh = Ymesh - sgsubimgsz(1)/2;


for thetaind = 1:length(angles)
                      
    for bind = 1:length(trans)
        
        theta = angles(thetaind);
        b = single(trans(bind));
        angle = single((theta* pi) / 180);
             
        %all operants are single
        dist = b - (Xmesh*sin(angle)) - (Ymesh*cos(angle));             
        distpw = (dist.^2)/ (sigma^2);             
        refline = exp(-distpw);
        
        %correlation multiplication of the whole image               
        temp = refline.*sgtestimage;
        
        %binning
        temp2 = reshape(temp,...
            [subimgsz(1),imgsize(1)/subimgsz(1),...
             subimgsz(2),imgsize(2)/subimgsz(2)]);
        
        temp3 = sum(temp2,1);
        temp4 = squeeze(sum(temp3,3));
        

        corr(thetaind, bind,:,:) = temp4;
            
    end
    
end
%spcorr tiles the correlation matrix in the order of subimages
corrsz = size(corr);
spcorr = reshape(permute(corr,[1,3,2,4]),corrsz(1)*corrsz(3),corrsz(2)*corrsz(4));
colsubimgs = reshape(sgtestimage,...
            [subimgsz(1),imgsize(1)/subimgsz(1),...
             subimgsz(2),imgsize(2)/subimgsz(2)]);

end  


