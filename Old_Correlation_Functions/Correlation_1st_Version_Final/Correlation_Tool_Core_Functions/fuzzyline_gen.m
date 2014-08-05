% function result = fuzzyline_gen(xsize, ysize, angle_d, b,sigma)
% 
% Description:
%     
%     This function generates a meshgerid with the user's specified dimension 
%     and find the distance from the origin to the line of interest in order
%     to determine the line's angle and translation.
%     
% Fields:
%     
%     %xsize, ysize determines the size of the line image
%     %angle_d, b are the line parameters, angle_d in degrees
%     %sigma determines how fuzzy the line is.
%     
% Initial Conditions:
% 
%     xsize and ysize must be positive, angle_d must be in degrees, and sigma
%     must be a positive integer.
%     
% Final: returns the exp^(distance)
%     

function result = fuzzyline_gen(xsize, ysize, angle_d, b,sigma)
    
    
    % generate mesh grid with the user specificed size
    [Xmesh, Ymesh] = meshgrid(1:xsize, 1:ysize);
    Xmesh = Xmesh - single(xsize)/2;
    Ymesh = Ymesh - single(ysize)/2;
    
    % convert angle to radian for sin and cos function parameter
    angle = (angle_d * pi) / 180;
    
    % find the distance 
    dist = single(b - (Xmesh*sin(angle)) - (Ymesh*cos(angle)));
    distance = single(((dist).^2)/ (sigma^2));
     
    result = exp(-distance);
 
    
end
