function varargout = Correlation_V2(varargin)
%CORRELATION_V2 M-file for Correlation_V2.fig
%      CORRELATION_V2, by itself, creates a new CORRELATION_V2 or raises the existing
%      singleton*.
%
%      H = CORRELATION_V2 returns the handle to a new CORRELATION_V2 or the handle to
%      the existing singleton*.
%
%      CORRELATION_V2('Property','Value',...) creates a new CORRELATION_V2 using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to Correlation_V2_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      CORRELATION_V2('CALLBACK') and CORRELATION_V2('CALLBACK',hObject,...) call the
%      local function named CALLBACK in CORRELATION_V2.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Correlation_V2

% Last Modified by Dan Lin 21-Aug-2014 17:01:05

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Correlation_V2_OpeningFcn, ...
                   'gui_OutputFcn',  @Correlation_V2_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
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
% --- Executes just before Correlation_V2 is made visible.
function Correlation_V2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)    
    % clear existing persistant data 
    clearvars -global path_storage
    clearvars -global struct_mode_of_operation
    clearvars -global pars_structure
    % set slider values
    slider_min = 2;
    slider_max = 10; % place holder slider value    
    slider_step(1) = 1/(slider_max-slider_min);
    slider_step(2) = 1/(slider_max-slider_min); 
    set(handles.slider1, 'Min',slider_min ,'Max', slider_max, ...
        'SliderStep', slider_step, 'Value', 2);
    set(handles.edit7, 'String',2);
    % initialize mode of operation struct
    global struct_mode_of_operation;  
    % init struct modes
    struct_mode_name_corr = 'Correlation_Analysis';
    struct_mode_name_sub = 'Sub_window_Analysis';
    mode_op_corr_analysis = 0;
    mode_op_sub_window = 0;  
    struct_mode_of_operation = struct(struct_mode_name_corr, mode_op_corr_analysis, ...
                                      struct_mode_name_sub, mode_op_sub_window);    
% Choose default command line output for Correlation_V2
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);
% UIWAIT makes Correlation_V2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);
% --- Outputs from this function are returned to the command line.
function varargout = Correlation_V2_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)    
     global path_storage    
     % get current listbox strings and entries 
     entries = get(handles.listbox1, 'String');
     index_selected = get(handles.listbox1, 'Value');       
     % remove user selected value
     entries{index_selected} = [];     
     % remove the deleted file's path from path storage variable
     new_entries = entries(~cellfun('isempty',entries));
     path_storage{index_selected} = [];       
     path_storage = path_storage(~cellfun(@isempty, path_storage));      
     % update listbox handle
     set(handles.listbox1, 'String', new_entries);
     set(handles.listbox1, 'String', new_entries, 'Value',1);

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    clearvars -global path_storage
    set(handles.listbox1, 'String', '');     
% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)   
    global path_storage;           
    [image_file_name, image_file_path] = GetAndSetImageFile(handles);
    existing_path_list = path_storage;         
    % if path_stroage is empty, set the variable equal to path_storage.
    % Else, concat path_storage file name list with new file name list    
    if isempty(path_storage) && ~iscell(image_file_path)       
        image_file_path = {image_file_name};        
        path_storage = image_file_path;
        return       
    end    
    % GetAndSetImageFile returns the full path of the image
    % file with the image's name inside image_file_name variable if uigetfile is invoked. Thus, we
    % only have to add this path to the path_storage variable.     
    if ~iscell(image_file_path)       
        image_file_path = {image_file_name};  
        new_path_list = horzcat(existing_path_list, image_file_path);        
    else       
        new_path_list = horzcat(existing_path_list, image_file_path);  % file path from uigetdir, 
                                                                       % which returns a n x m cell with image's file path                                                                   
																	   % and name together      
    end
    path_storage = new_path_list;

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)   
    % clear all list boxes
    set(handles.edit11,'String','');
    set(handles.edit12,'String','');
    set(handles.edit13,'String','');
    set(handles.edit1, 'String','');
    set(handles.edit9, 'String','');
    set(handles.edit10,'String',''); 
    set(handles.edit2, 'String',''); 
% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    global path_storage   
    if isempty(get(handles.listbox1,'string')) 
        return;  
    end        
    [sanitized_image_name, sanitized_image_pos] = CheckFileName(handles);   
    if ~isempty(sanitized_image_name)
        % read image and display image on axes1
        image_read = imread(path_storage{sanitized_image_pos});   
        axes(handles.axes10);
        image_to_display_handle = imagesc(image_read);       
        % display crop image dialogue if user click on image
        set(image_to_display_handle, 'ButtonDownFcn',{@CropImage,image_read,handles});        
    else        
        return
    end

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1

% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    global path_storage 
    global struct_mode_of_operation;
    global pars_structure;
    [ theta, brange, sigma ] = UserVariableInputSanitization(handles);
    [ sanitized_image_name, sanitized_image_pos ] = CheckFileName(handles);
    % boolean to check user input
    check_input = ~isempty(theta) && ~isempty(brange) && ~isempty(sigma) ...
                  && ~isempty(sanitized_image_pos);   
    if check_input == 1
        mode_op = CheckStructMode(struct_mode_of_operation);
        image_to_be_analyzed = imread(path_storage{sanitized_image_pos});
        corr_map_analyzed = Analysis(mode_op, theta, brange, sigma, image_to_be_analyzed, pars_structure);
        axes(handles.axes6);           
        imagesc(corr_map_analyzed);  
        peak_map_of_corr_map = MaxIntensityFinding(corr_map_analyzed);
        axes(handles.axes11);
        imagesc(peak_map_of_corr_map);  
        CountMax(handles, peak_map_of_corr_map); 
		PlotPeakOnImage(handles);	
        % reset edit box and slider values to readjust to the change in
        % peak map size
        set(handles.slider1, 'Value',2);
        set(handles.edit7, 'String',2);  
    else        
        return        
    end   
% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    prompt = ' What would you like to save your file as? ';
    saved_file_name = inputdlg(prompt);   
    % saved_file_name is a cell string. saved_file_name{1} turns the cell
    % string into a string
    SaveData(saved_file_name{1});
% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)    
    global path_storage    
    [ theta, brange, sigma ] = UserVariableInputSanitization(handles);    
    % File name can be anything, but format must be jpg, tif, tiff, or png 
    valid_image_extensions = {'.jpg', '.png', '.tif', '.tiff'};    
    mode_op = CheckStructMode(struct_mode_of_operation);
    for idx = 1:numel(path_storage)            
        [pathstr, file, ext] = fileparts(path_storage{idx});       
        if ismember(ext,valid_image_extensions) && (~isempty(theta) ...
                    && ~isempty(brange) && ~isempty(sigma))                     
            image_to_be_analyzed = imread(path_storage{idx});
            corr_map = Analysis(mode_op, theta, brange, sigma, image_to_be_analyzed);
            peak_map = MaxIntensityFinding(corr_map);
            % display image, corr_map, and peak_map on graph
            exp_image = imread(path_storage{idx});
            axes(handles.axes10);
            imagesc(exp_image);          
            axes(handles.axes6);           
            imagesc(corr_map);            
            axes(handles.axes11);
            imagesc(peak_map);
			CountMax(handles, peak_map);
			PlotPeakOnImage(handles);	
            % save data 
            experiment_name = sprintf('experiment_number_%d',idx);
            SaveData(experiment_name);               
        end   
    end

% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    % get size of the current peak map
    axes_size = size(getimage(handles.axes11));      
    if any(axes_size) == 1 % if the size is non-zero               
        % reset slider step
        slider_min = get(hObject, 'Min');
        slider_max = get(hObject, 'Max');
        slider_step(1) = 1/(slider_max-slider_min);
        slider_step(2) = 1/(slider_max-slider_min);
        set(handles.slider1, 'Max', axes_size(2), 'SliderStep', slider_step);                
        % get slider value and set it to edit box 7
        slider_value = round(get(hObject, 'Value'));
        set(handles.edit7, 'String', slider_value);    
    else            
        slider_value = round(get(hObject, 'Value'));
        set(handles.edit7, 'String', slider_value);       
    end
       
% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
% --- Executes during object creation, after setting all properties.
function edit11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
% --- Executes during object creation, after setting all properties.
function edit12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function edit13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

function edit10_Callback(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

function edit11_Callback(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

function edit12_Callback(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

function edit13_Callback(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)   
    corr_image = getimage(handles.axes6);
    dist_threshold_user_input = str2num(get(handles.edit7, 'String')); 
    new_peak_map = MaxIntensityFinding(corr_image, dist_threshold_user_input); 
    CountMax(handles,new_peak_map);
    axes(handles.axes11);
    imagesc(new_peak_map);
    PlotPeakOnImage(handles);
        
% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    corr_map = getimage(handles.axes6);  
    % find the maximum value of the corr_map 
    max_values_at_eath_column_of_corr_map = max(corr_map,[],1);
    max_absolute = max(max_values_at_eath_column_of_corr_map);
    % set map value under threshold value to zero
    corr_map(corr_map < (0.8*max_absolute)) = 0;
    axes(handles.axes6);
    imagesc(corr_map);   
 
 function StructModeSetting(mode_cmd)      
    global struct_mode_of_operation;
    % compare modes 
    if strcmp(mode_cmd, 'Correlation_Analysis') == 0       
        struct_mode_of_operation.Correlation_Analysis = 1;
        struct_mode_of_operation.Sub_window_Analysis = 0;
    else 
        struct_mode_of_operation.Correlation_Analysis = 0;
        struct_mode_of_operation.Sub_window_Analysis = 1;
    end

% --- Executes on button press in pushbutton14.
function pushbutton14_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    StructModeSetting('Sub_window_Analysis');

% --- Executes on button press in pushbutton15.
function pushbutton15_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    StructModeSetting('Correlation_Analysis');

% --- Executes on button press in pushbutton16.
function pushbutton16_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    global struct_mode_of_operation;
    global pars_structure;
    mode_op = CheckStructMode(struct_mode_of_operation);
    % mode op determines what type of pop up window 
    if strcmp(mode_op, 'Sub-window-Analysis') == 1
        prompt ={ 'Subwindow Size:', 'Local Cutoff Point:', ...
                 'Global Cutoff', 'Normalize'};
        name = 'Additional Parameters For Sub-window Analysis';
        numlines = 1;
        response_pars =inputdlg(prompt,name,numlines);
        pars_structure = struct('subwdsz', str2num(response_pars{1}), ...
                                'iflocalcutoff', str2num(response_pars{2}), ...
                                'ifglobalcutoff', str2num(response_pars{3}), ...
                                'ifnormalize', str2num(response_pars{4}));
    else
        prompt = {'Threshold input for image map'};
        name = 'Additional Parameters For Regular Correlation Analysis';
        numlines = 1;
        response_pars = inputdlg(prompt, name, numlines);
        pars_structure = struct('Threshold', response_pars{1});
    end
