function varargout = Correlation_Tool(varargin)
% GUI Code for the Correlation Analysis Program 
%
% Program creation time: 1/06/14    
% Last Modified by Daniel Lin using GUIDE v2.5  on 19-Feb-2014 04:05:14 
%
% Description: 
%
%   The code below was written by Daniel Lin with the help of Dr. Bo Sun
%   from the Department of Physics at Oregon State University. This code 
%   generates a GUI wrapper for the Correlation Analysis Program that
%   allow users to perform correlation analysis on the selected image with ease. 
%
%   All variable initilizations for the GUI, functions for the callbacks 
%   for each of the figures on the GUI, and the generation of the GUI were
%   generated using GUIDE, the built-in Matlab GUI generation program. For
%   more information on GUIDE, see GUIDE, GUIDATA, and GUIHANDLES. 
%
% Usage of Code: 
%   
%   In order to use this code, the user must type GUIDE via the command
%   console on the Matlab IDE. Then, select Correlation_Tool.fig and open
%   it via GUIDE. Finally, press play button on GUIDE to initialize the GUI.
%   Failure to follow this will result in the GUI not performing its
%   promised functionalities
%
%
% Licence: 
%
%   This program is owned by the Daniel Lin and Dr. Bo Sun at Oregon
%   State University. The user may freely modify this code. However,
%   distribution and usage of code must include citation to the authors 
%
% Begin GUI initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Correlation_Tool_OpeningFcn, ...
                   'gui_OutputFcn',  @Correlation_Tool_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT

% function Correlation_Tool_OpeningFcn(hObject, eventdata, handles, varargin)
%
% Description:
%
%   This function initializes the Correlation_Tool GUI upon the user
%   opening the GUI tool. The function also executes commands the user
%   specifies when the GUI is opened. DO NOT REMOVE THIS FUNCTION OR THE
%   GUI WILL NOT INITIALIZE!
%
% Fields: 
%   hObject    handle to figure
%   eventdata  reserved - to be defined in a future version of MATLAB
%   handles    structure with handles and user data (see GUIDATA)
%   varargin   command line arguments to Correlation_Tool (see VARARGIN) 
%
% Initial conditions: None 
% 
% Final conditions: None 

function Correlation_Tool_OpeningFcn(hObject, eventdata, handles, varargin)

% Choose default command line output for Correlation_Tool
handles.output = hObject;
clearvars -global path_storage; 
clearvars -global image_read;

% Update handles structure
guidata(hObject, handles);

% function varargout = Correlation_Tool_OutputFcn(hObject, eventdata, handles)
%
% Description: 
%   This function outputs results that the user specifices onto the Matlab
%   commandline console. 
%
% Fields: 
%   varargout  cell array for returning output args (see VARARGOUT);
%   hObject    handle to figure
%   eventdata  reserved - to be defined in a future version of MATLAB
%   handles    structure with handles and user data (see GUIDATA)
%
% Initial conditions: None 
% 
% Final conditions: None 

function varargout = Correlation_Tool_OutputFcn(hObject, eventdata, handles) 

% Get default command line output from handles structure
varargout{1} = handles.output;

% function listbox1_Callback(hObject, eventdata, handles)
%
% Description:
%
%   This function handles the functionalities of listbox1, also known as
%   Image Bay on the GUI. The function allows the user to select an image
%   on the Image Bay, check if the selected image is a valid file format,
%   and displays the image on the GUI.
%
% Fields:
%    hObject    handle to listbox1, or Image Bay (see GCBO)
%    eventdata  reserved - to be defined in a future version of MATLAB
%    handles    structure with handles and user data (see GUIDATA)
%
% Initial conditions: 
%  
%   The image read must be an inverted image; e.g. all black background with
%   bright lines on top of the black background. 
%
% Final conditions: None

function listbox1_Callback(hObject, eventdata, handles)
    
    %global path; % global that is set when pushbutton1_Callback is executed
    global image_read; % global variable that is set when listbox1_Callback is executed  
    global path_storage;
   
    if isempty(get(handles.listbox1,'string')) 
       
        return;
   
    end   
        
    imagenamelist = get(handles.listbox1, 'string');
    image_name_pos = get(handles.listbox1, 'value');
    
    
    status = check_sanitize(imagenamelist, image_name_pos);
   
    if status == 0
        return;
    
    end
  
    image_read = imread(path_storage{image_name_pos});
    
    axes(handles.axes1);
    im = imagesc(image_read);
    h = @crop_fun;
    set(im, 'ButtonDownFcn',{h,image_read,handles});
   
    guidata(hObject,handles); 
   
% function listbox1_CreateFcn(hObject, eventdata, handles)
%
% Description:
%
%    This function defines the functionalities of listbox when list box is
%    first opened
%
% Fields:
%   hObject    handle to listbox1 (see GCBO)
%   eventdata  reserved - to be defined in a future version of MATLAB
%   handles    empty - handles not created until after all CreateFcns called
%
% Initial conditions: None 
%
% Final conditions: None 
%

function listbox1_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
       
% function listbox1_CreateFcn(hObject, eventdata, handles)
%
% Description:
%
%    This handles the Upload button functionalities on the GUI. The Upload
%    button allows the user to upload a folder or a single file. The file
%    name is displayed on the Image Bay. The Upload button CANNOT upload a
%    directory within a directory. This means that the user must upload
%    directories manually. 
%   
% Fields:
%
%   hObject    handle to pushbutton1 (see GCBO)
%   eventdata  reserved - to be defined in a future version of MATLAB
%   handles    empty - handles not created until after all CreateFcns called
%
% Initial conditions: None 
%
% Final conditions: None 

function pushbutton1_Callback(hObject, eventdata, handles)

    global path;
    global path_storage;
  
    % do not allow repetition of file elements 
    user_response = questdlg('Press Folder Input if you are uploading a folder of images or  File Input for just a single file of images.',...
                             'Question Dialog','Folder Input', 'File Input', 'Cancel', 'Cancel');
    
    switch(user_response)
 
        case 'Folder Input'
        
            directory_choice = inputdlg('Please specify the path to your desired directory, or leave the field empty and press ok to manually find your directory', 'Dialog', [1 100]);
            
            if isempty(directory_choice)
                
               return;
                
            end 
            
            user_selected_dir = directory_choice{:};                       
            path = uigetdir(user_selected_dir);
            
            if path == 0
 
                return;

            end
            
            folders_cur_directory = dir(path); % get everything from current directory 
            ind = [folders_cur_directory(:).isdir]; % find all directories
            nointernaldir = find(~ind); % find the indices of non-directories
           
            newFolder = folders_cur_directory(nointernaldir);% store the non-directories into a new variable
            [new_data_joined,added_new_name] = join_text(newFolder, handles.listbox1);
           
            full_name_list = new_data_joined;
            name_list_added_element = added_new_name;
            
           
            if isempty(path_storage)
               
                path_storage = cell(1, numel(full_name_list));
                file_full_path_storage = cell(1,numel(full_name_list));
                file_full_path_in_string_format = cell(1, numel(full_name_list));
                
            end
           
            for idx = 1:numel(name_list_added_element)
              
                file_full_path_storage{idx} = strcat(path, filesep, name_list_added_element{idx});
                
                file_full_path_in_string_format{idx}= file_full_path_storage{idx};
              
            end
     
            empty_cell_index = cellfun(@isempty, path_storage);
            
            empty_cells = find(empty_cell_index);
          
            if numel(empty_cells) > 0
           
                for idx = 1:numel(empty_cells)
                
                    path_storage{empty_cells(idx)} = file_full_path_in_string_format{idx};
                
                end
                
            else
             
                path_storage{1,numel(path_storage)+ numel(name_list_added_element)} = []; % add the number of cells equal to the number of new data to store the new data
                empty_cells = find(cellfun(@isempty, path_storage)); % find the newly created empty cells
                
                for idx = 1:numel(name_list_added_element)
                    
                    path_storage{empty_cells(idx)} = file_full_path_in_string_format{idx}; %put the new data in
                                    
                end
       
            end
           
            
            set(handles.listbox1, 'string', full_name_list);
            set(handles.listbox1, 'string', full_name_list, 'Value',1);

            
        case 'File Input'
                
            [filenamelist, path] = uigetfile({'*.*','All Files';'*.m,*.fig,*.mat,*.slx,*.mdl', ...
                                        'MATLAB Files (*.m,*.fig,*.mat,*.slx,*.mdl)';...
                                        '*.jpg,*.tif,*.png,*.gif, *.PNG, *.JPG, *.TIF',...
                                        'All Image Files';});
     
            if filenamelist == 0                
  
                return;
              
            end
            
            new_text = join_text(filenamelist, handles.listbox1);
           
            if isempty(path_storage) == 1
               
                path_storage = cell(1, numel(new_text));
           
            end
            
            file_full_path = strcat(path,filenamelist);
           
            [size_x, size_y] = size(path_storage);
          
            for idx = 1:size_y
                       
                
                if isempty(path_storage{idx}) 
                 
                    path_storage{idx} =  file_full_path;
                       
                end
                
                if idx == numel(path_storage)
             
                    path_storage{1,numel(path_storage)+ 1} = [];
                        
                    path_storage{numel(path_storage)} = file_full_path;
                
           
                end
                
            end
            
         
            set(handles.listbox1,'string',new_text);  
            set(handles.listbox1, 'string', new_text, 'Value',1);
            
        case 'Cancel'
            
            return;
                
        case ''
                
            return;
            
                
    end    
      
%save the handle onto the handle object
guidata(hObject, handles);    


% function pushbutton2_Callback(hObject, eventdata, handles)
%
% Description:
%
%    This function allows the user to select and delete images on the Image
%    Bay
%   
% Fields:
%
%    hObject    handle to pushbutton3 (see GCBO)
%    eventdata  reserved - to be defined in a future version of MATLAB
%    handles    empty - handles not created until after all CreateFcns called
%
% Initial conditions: None 
%
% Final conditions: None 

function pushbutton2_Callback(hObject, eventdata, handles)
    
    global path_storage;
    handles.output = hObject;  
    list = handles.listbox1;
    entries = get(list, 'string');
    index_selected = get(list, 'value');   
   
    if numel(index_selected) > 1 % if the user selected more than one image
      
        for indx = index_selected(1):index_selected(numel(index_selected))       
            
            entries{indx} = []; %set selected entries in cell array to be empty
            path_storage{idx} = []; % set the path to that image to be empty
            
        end   
        
        new_entries = entries(~cellfun('isempty',entries)); % remove empty cells
        path_storage = path_storage(~cellfun(@isempty, path_storage)); %remove empty cells to path to image 
        set(list, 'string', new_entries, 'Value',1);
        
    else
        
        entries{index_selected} = [];
        new_entries = entries(~cellfun('isempty',entries));
        path_storage{index_selected} = [];
        
        path_storage = path_storage(~cellfun(@isempty, path_storage));
       
        set(list, 'String', new_entries);
        set(list, 'string', new_entries, 'Value',1);
              
    end 
guidata(hObject, handles);
    
% function pushbutton3_Callback(hObject, eventdata, handles)
%
% Description:
%
%    This function clears the Image Bay when the user press the Clear All 
%    button, also known as pushbutton3_Callback.
%   
% Fields:
%
%    hObject    handle to pushbutton3 (see GCBO)
%    eventdata  reserved - to be defined in a future version of MATLAB
%    handles    empty - handles not created until after all CreateFcns called
%
% Initial conditions: None 
%
% Final conditions: None 

function pushbutton3_Callback(hObject, eventdata, handles)
    set(handles.listbox1, 'String', '');
    
    % clear all global variables and work spaces
    clearvars -global path_storage; 
    clearvars -global image_read;
    msgbox('Work space cleared');
      
  
    guidata(hObject,handles);   

% function pushbutton3_Callback(hObject, eventdata, handles)
%
% Description:
%
%    This function clears the Image Bay when the user press the Clear All 
%    button, also known as pushbutton3_Callback.
%   
% Fields:
%
%    hObject    handle to edit2 (see GCBO)
%    eventdata  reserved - to be defined in a future version of MATLAB
%    handles    empty - handles not created until after all CreateFcns called
%
% Initial conditions: None 
%
% Final conditions: None 

function edit2_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% function edit3_CreateFcn(hObject, eventdata, handles)
%
% Description:
%
%    This function creates the edit3 GUI. 
%
% Fields:
%
%    hObject    handle to edit3 (see GCBO)
%    eventdata  reserved - to be defined in a future version of MATLAB
%    handles    empty - handles not created until after all CreateFcns called
%
% Initial conditions: None
% Final conditions: None 
%   

function edit3_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end      

% function edit4_CreateFcn(hObject, eventdata, handles)
%
% Description:
%
%    This function creates the edit4 GUI. 
%
% Fields:
%
%    Object    handle to edit4 (see GCBO)
%    eventdata  reserved - to be defined in a future version of MATLAB
%    handles    empty - handles not created until after all CreateFcns called
%
% Initial conditions: None
% Final conditions: None 
%   
   
function edit4_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% function pushbutton4_Callback(hObject, eventdata, handles)
%
% Description:
%
%    This function calls the Analysis script to perform the Correlation
%    Analysis when the user press Start, also known as
%    pushbutton4_Callback.
%
% Fields:
%
%    hObject    handle to edit4 (see GCBO)
%    eventdata  reserved - to be defined in a future version of MATLAB
%    handles    empty - handles not created until after all CreateFcns called
%
% Initial conditions: None
%
% Final conditions: 
%
%    Displays the correlation analysis on the axes. 
% 

function pushbutton4_Callback(hObject, eventdata, handles)
   
    status = 0; 
    [theta, Brange, Sigma, status] = getterandchecker(handles,status);
    
   
    if status == 1
       
        return;
    
    end    
      
    disp('Processing your image, please wait...');
    
    % Do correlation analysis once all variables are set 
    cor_res = Analysis(theta,Brange, Sigma);
    
    if cor_res == 0
        return;
    end
    
    axes(handles.axes2);
    imagesc(cor_res);


    
% function pushbutton5_Callback(hObject, eventdata, handles)
%
% Description:
%       
%    This function processes all of the files on the image bay when the
%    user clicks on Start with bash, also known as pushbutton5
%
%
% Fields:
%
%     hObject    handle to pushbutton5 (see GCBO)
%     eventdata  reserved - to be defined in a future version of MATLAB
%     handles    structure with handles and user data (see GUIDATA)
%    
%
% Initial conditions: None
%
% Final conditions: 
%
%     Creates a folder with the user specified name, saves the correlation
%     analysis result as a png file and puts them into the folder. 
%                

function pushbutton5_Callback(hObject, eventdata, handles)
    
  
    global image_read;
    global path_storage;
   
    status = 0;
    [theta, Brange, Sigma, status] = getterandchecker(handles,status);  
    
    if status == 1
       
        return;
    
    end
    
    answer = prompt;
    
    if isempty(answer)
        
        return;
    
    end
       
    [fold_name, status] = makefolder(answer{1});   
    
    if status == 1
        
        return;
    
    end
   
    % loop through all files of image bay      
    
    for idx = 1:numel(path_storage)
      
       word_status = sprintf('Processing %d image on image bay, please wait', idx);
       
       disp(word_status);           
       
       if isempty(path_storage{idx})
           
            continue;
       
       end
       
       image_read = imread(path_storage{idx});
       cor_result = Analysis(theta,Brange, Sigma);      
       
       % show image on GUI 
       axes(handles.axes1);
       img_read = imread(path_storage{idx});
       imagesc(img_read);
       
       % show result on GUI 
       axes(handles.axes2);
       imagesc(cor_result); 
       save_name = sprintf('corr_result_img_%d',idx);
       
       try
         
           save_file(save_name, fold_name);
         
       catch exception
         
            errordlg('The file you are saving to already existed, please delete or rename the existed file and try again');
            return;
      
       end
       
       
    end


% function pushbutton6_Callback(hObject, eventdata, handles)
%  
% Description:
%       
%    This function prompts the user to enter the file name and folder name
%    of his or her choice for saving purposes
%
% Fields:
%
%      hObject    handle to pushbutton6 (see GCBO)
%      eventdata  reserved - to be defined in a future version of MATLAB
%      handles    structure with handles and user data (see GUIDATA)
%
% Initial conditions: None
%     
%
% Final conditions: 
%
%     Saves the file with the user specified folder name and file name
%

function pushbutton6_Callback(hObject, eventdata, handles)

 
    prompt = {'Enter the name you want your file to be saved as', 'Enter the folder you want your image to be saved in'};
    dlg_title = 'Input';
    num_lines = 1;
   
    answer = inputdlg(prompt,dlg_title,num_lines);
     
    if isempty(answer)== 1
        
        return;
        
    end
        
    if isempty(answer{1}) || isempty(answer{2})
        
        errordlg('You forgot to input one of the fields, please try again');
        return;
    
    end
    
    file_name = answer{1};
    folder = answer{2};
    
    folder_name = makefolder(folder);
    save_file(file_name, folder_name);
   
% function axes1_CreateFcn(hObject, eventdata, handles)
%   
% Description:
%       
%    The function defines the behavior of axes1 when it is created everytime by GUIDE 
%
% Fields:
%
%      hObject    handle to axes1 (see GCBO)
%      eventdata  reserved - to be defined in a future version of MATLAB
%      handles    structure with handles and user data (see GUIDATA)
%
% Initial conditions: None
% Final conditions: None
 

function axes1_CreateFcn(hObject, eventdata, handles)
    


    
% function pushbutton7_Callback(hObject, eventdata, handles)
%   
% Description:
%       
%     The function clears the values in the input text box for theta,
%     B-range, and Sigma
%     
%
% Fields:
%
%      hObject    handle to pushbutton7 (see GCBO)
%      eventdata  reserved - to be defined in a future version of MATLAB
%      handles    structure with handles and user data (see GUIDATA)
%
% Initial conditions: None
%
% Final conditions: 
%      Cleans the textboxs for thetam B-range, and Sigma . 


function pushbutton7_Callback(hObject, eventdata, handles)


    if isempty(handles.edit2) && isemtpy(handles.edit3) && isempty(handles.edit4)

        return;
        
    end
    
    set(handles.edit2, 'String', '');
    set(handles.edit3, 'String', '');
    set(handles.edit4, 'String', '');
    
% function edit2_Callback(hObject, eventdata, handles)
%   
% Description:
%       
%      Call back function for theta textbox
%     
%
% Fields:
%
%      hObject    handle to edit2 (see GCBO)
%      eventdata  reserved - to be defined in a future version of MATLAB
%      handles    structure with handles and user data (see GUIDATA)
%
% Initial conditions: None
%
% Final conditions: None
%      
function edit2_Callback(hObject, eventdata, handles)

 return; % return nothing upon pressing the box

% function edit2_Callback(hObject, eventdata, handles)
%   
% Description:
%       
%    Call back function for Brange textbox
%     
%
% Fields:
%
%      hObject    handle to edit3 (see GCBO)
%      eventdata  reserved - to be defined in a future version of MATLAB
%      handles    structure with handles and user data (see GUIDATA)
%
% Initial conditions: None
%
% Final conditions: None 

function edit3_Callback(hObject, eventdata, handles)

return; % return nothing upon pressing the box

% function edit4_Callback(hObject, eventdata, handles)
%   
% Description:
%       
%     Call back function for Sigma textbox 
%     
%
% Fields:
%
%      hObject    handle to edit4 (see GCBO)
%      eventdata  reserved - to be defined in a future version of MATLAB
%      handles    structure with handles and user data (see GUIDATA)
%
% Initial conditions: None
%
% Final conditions:   None 

function edit4_Callback(hObject, eventdata, handles)

return; % return nothing upon pressing the box
