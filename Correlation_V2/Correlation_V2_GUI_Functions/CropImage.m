% function CropImage(src, evnt,image,handles)
%
% Description:
%
%    This function crops the image to the user's specified dimensions and
%    outputs the cropped image onto the GUI.
%
% Fields:
%    src:  The handle of the object generating the callback (the source of the event)
%    evnt: The event data structure (can be empty for some callbacks)
%    image: the image read
%    handles: the GUI figure handle
%
% Initial conditions:
%    image must be a pre-read image using imread, handles
%    must be a valid GUI handle
%
% Final conditions:
%    Outputs the cropped image and displays it on the GUI
%    image console.

function CropImage(src, evnt,image,handles)
    
    prompt = { 'Please enter your center for x', ...
               'Please enter your center for y,'...
               'Please enter your height of sub-image'...
               'Please enter your width of sub-image'};
   
    answer = inputdlg(prompt);

    if isempty(answer)

        return;
    
    end
    
    if isempty(answer{1}) || isempty(answer{2})...
            || isempty(answer{3}) || isempty(answer{4})
        
        errordlg('One or all of your fields is blank, please try again');
        return;
        
    end 
    
    xcenter = str2num(answer{2,:});
    ycenter = str2num(answer{1,:});
    height = str2num(answer{3,:});
    width = str2num(answer{4,:});
    
    [xsize, ysize] = size(image);
    
    if xcenter+width > xsize 
        
        errordlg('Your x dimension exceeds image dimension');
        return;
        
    end
    
    if xcenter-width < 0
        
        errordlg('Cannot have negative dimensions');
        return;
        
    end
    
    
    if ycenter + height > ysize
        errordlg('Your y dimension exceeds image dimension');
        return;
    end
    
    if ycenter - height < 0
        
        errordlg('Cannot have negative dimensions');
        return;
        
    end
    
    
    if mod(height,2) == 1
        if mod(width,2) == 1
            
            errordlg('One of your dimensions is not a factor of 2');
            return;
        end
    end
      
    % crop image
    new_image = imcrop(image,[xcenter,ycenter,width,height]);
    
    % select axes one and display cropped image
    axes(handles.axes3);
    new_image_display_handle = imagesc(new_image);
    
    % make new image as button for user to click on if the user want to
    % crop the image again
    set(new_image_display_handle, 'ButtonDownFcn',{@CropImage,image,handles}); 
end