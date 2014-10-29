function [origrid,absgrid,corr,nematicgraph,colsubimgs]=fiberorientation(imagenow,anglerange_input, transrange_input, sigma_input, pars)
%% outputs
% origrid, complex nematic order
% absgrid, absolute value of origrid
% corr, correlation map from line detection, imagesc this
% nematicgraph, a graphic representation of the nematic map,same size as
% origrid and absgrid imagesc this..... more intense the line, more intense
% value of color hsv map. Color of huespace determines what angle
% colsubimgs, the subimages used by line detection in each subwindow

%% Set the parameters
% ---------------------------------------------------------
%these parameters for line detection
if(isempty(sigma_input) == 0) %line width
    sigma = sigma_input;
else
    sigma = 1;
end

if(isempty(anglerange_input) == 0) %line orientation
    anglerange = anglerange_input;
else
    anglerange = [0,1,179];
end

if(isempty(transrange_input) == 0) %line translation
    transrange = transrange_input;
else
    transrange = [-2,1,2];
end

if(isempty(pars.subwdsz) == 0) %subwindow size
    subwdsz = pars.subwdsz;
    imagesz = size(imagenow);
    end1 = floor(imagesz(1)/subwdsz(1))*subwdsz(1);
    end2 = floor(imagesz(2)/subwdsz(2))*subwdsz(2);
    imagenow = imagenow(1:end1,1:end2);
else
    subwdsz = [8,8];
    imagesz = size(imagenow);
    end1 = floor(imagesz(1)/subwdsz(1))*subwdsz(1);
    end2 = floor(imagesz(2)/subwdsz(2))*subwdsz(2);
    imagenow = imagenow(1:end1,1:end2);
end

%these parameters for removing noise from correlation maps resulted from
%line detection

%if>1, this is the relative threshold in the correlation map
if(~isempty(pars.iflocalcutoff)) %subwindow size
    iflocalcutoff  = pars.iflocalcutoff;
else
   iflocalcutoff   = 1.1;
end


%if>1, this is the relative threshold in the nematic map
if(~isempty(pars.ifglobalcutoff)) %subwindow size
    ifglobalcutoff  = pars.ifglobalcutoff;
else
    ifglobalcutoff  = 5;
end

% if set to be one, the nematic map will be normalized to magnitude of 1
if(isempty(pars.ifnormalize)) %subwindow size
   ifnormalize   = pars.ifnormalize;
else
   ifnormalize   = 0;
end

h = waitbar(0.25, 'Variable initialized');
%% correlation based line detection
% ------------------------------------------------
imgnow = double(imagenow);
[corrnorm,spcorr,angles,trans,refline,colsubimgs] = ...
correlation_line_sw(ones(size(imgnow)),subwdsz,anglerange,transrange,sigma);
[corr,spcorr,angles,trans,refline,colsubimgs] = ...
correlation_line_sw(imgnow,subwdsz,anglerange,transrange,sigma);

corr = corr./corrnorm;

szcorr = size(corr);

% the 2-D nematic order of each subwindow
origrid = zeros(szcorr(3),szcorr(4));
absgrid = zeros(szcorr(3),szcorr(4));
[tgrid,agrid] = meshgrid(transrange(1):transrange(2):transrange(3),...
    anglerange(1):anglerange(2):anglerange(3));
nemafac = exp((2*sqrt(-1)*pi/180.0)*agrid);

waitbar(0.45, h, 'Please wait');
for xind = 1:szcorr(3)
    for yind = 1:szcorr(4)
        temp1 = squeeze(corr(:,:,xind,yind));
        
       if(iflocalcutoff>1)
           %this is a bit arbitrary and needs test case by case
           cutoffmagni = max(temp1(:))/iflocalcutoff;
           temp1(temp1<cutoffmagni) = 0;
       end        
               
        origrid(xind,yind) = mean2(nemafac.*temp1);
        absgrid(xind,yind) = abs(origrid(xind,yind));
        waitbar(1/(szcorr(3)), h);       
    end
end

if(ifglobalcutoff>1)    
   cutoffmagni = max(absgrid(:))/ifglobalcutoff;
   origrid(absgrid<cutoffmagni) = 0;
   absgrid = abs(origrid);
end

if(ifnormalize)
    origrid=origrid./abs(origrid);
    origrid(isnan(origrid)) = 0;
    absgrid = abs(origrid);    
end
%% generating nematicgraph
%now generate the graphic representation of nematic map,make a smooth for
%better visualization
%-------------------------------------------------------------------
anglesmap = mod(angle(origrid)*180/pi+360,360)/2;
absmap = abs(origrid)/max(abs(origrid(:)));
%angle is represented by hue and magnitude is represented by brightness
nematicgraph = zeros(szcorr(3),szcorr(4),3);
huechannel = zeros(szcorr(3),szcorr(4));
valuechannel = zeros(szcorr(3),szcorr(4));
huechannel = anglesmap/360;
valuechannel = absmap;
nematicgraph(:,:,1) = huechannel;
nematicgraph(:,:,2) = 0.8;
nematicgraph(:,:,3) = valuechannel;
nematicgraph = hsv2rgb(nematicgraph);
close(h);

end


