function [origrid,absgrid,corr,nematicgraph,colsubimgs]=fiberorientation(imagenow,pars)
%% outputs
% origrid, complex nematic order
% absgrid, absolute value of origrid
% corr, correlation map from line detection
% nematicgraph, a graphic representation of the nematic map,same size as
% origrid and absgrid
% colsubimgs, the subimages used by line detection in each subwindow

%% Set the parameters
% ---------------------------------------------------------
%these parameters for line detection
if(isfield(pars,'sigma')) %line width
    sigma = pars.sigma;
else
    sigma = 1;
end

if(isfield(pars,'anglerange')) %line orientation
    anglerange = pars.anglerange;
else
    anglerange = [0,1,179];
end

if(isfield(pars,'transrange')) %line translation
    transrange = pars.transrange;
else
    transrange = [-2,1,2];
end

if(isfield(pars,'subwdsz')) %subwindow size
    subwdsz = pars.subwdsz;
else
    subwdsz = [8,8];
end


%these parameters for removing noise from correlation maps resulted from
%line detection

%if>1, this is the relative threshold in the correlation map
if(isfield(pars,'iflocalcutoff')) %subwindow size
    iflocalcutoff  = pars.iflocalcutoff;
else
   iflocalcutoff   = 1.1;
end


%if>1, this is the relative threshold in the nematic map
if(isfield(pars,'ifglobalcutoff')) %subwindow size
    ifglobalcutoff  = pars.ifglobalcutoff;
else
    ifglobalcutoff  = 5;
end

% if set to be one, the nematic map will be normalized to magnitude of 1
if(isfield(pars,'ifnormalize ')) %subwindow size
   ifnormalize   = pars.ifnormalize;
else
   ifnormalize   = 0;
end
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

for xind = 1:szcorr(3)
    for yind = 1:szcorr(4)
        temp1 = squeeze(corr(:,:,xind,yind));
        %temp1 = temp1/median(temp1(:));
        
       if(iflocalcutoff>1)
           %this is a bit arbitrary and needs test case by case
           cutoffmagni = max(temp1(:))/iflocalcutoff;
           temp1(temp1<cutoffmagni) = 0;
       end        
               
        origrid(xind,yind) = mean2(nemafac.*temp1);
        absgrid(xind,yind) = abs(origrid(xind,yind));
               
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

end


