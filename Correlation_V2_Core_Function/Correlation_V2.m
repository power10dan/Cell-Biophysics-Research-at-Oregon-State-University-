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
    clearvars -global absgrid
    % set slider values
    slider_min = 2;
    slider_max = 10; % place holder slider value    
    slider_step(1) = 1/(slider_max-slider_min);
    slider_step(2) = 1/(slider_max-slider_min); 
    set(handles.slider1, 'Min',slider_min ,'Max', slider_max, ...
        'SliderStep', slider_step, 'Value', 2);
    set(handles.edit7, 'String',2);
    % initialize mode of operation and pars_structure 
    global struct_mode_of_operation; 
    global pars_structure;
    % init struct modes
    struct_mode_name_corr = 'Correlation_Analysis';
    struct_mode_name_sub = 'Sub_window_Analysis';
    mode_op_corr_analysis = 0;
    mode_op_sub_window = 0;  
    struct_mode_of_operation = struct(struct_mode_name_corr, ...
                                      mode_op_corr_analysis, ...
                                      struct_mode_name_sub, ...
                                      mode_op_sub_window); 
    % set up axes label
    axes(handles.axes6);
    ylabel('Y-Axis');
    xlabel('X-Axis')
    axes(handles.axes11);
    ylabel('Y-Axis');
    xlabel('X-Axis');
    axes(handles.axes10);
    ylabel('Y-Axis');
    xlabel('X-Axis');
    % set default button selected
    set(handles.pushbutton15,'ForegroundColor','blue');
    % set graph label
    set(handles.uipanel7, 'Title', 'Sub-window Nematic Graph Result');
    set(handles.uipanel8, 'Title', 'Nematic Graph Peak Finding');
    pars_structure = struct('subwdsz', [], ...
                            'iflocalcutoff', [], ...
                            'ifglobalcutoff', [], ...
                            'ifnormalize', []);
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
    %clearvars -global path_storage
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
        set(image_to_display_handle, 'ButtonDownFcn',{@CropImage, image_read,handles});        
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
    global path_storage;
    global struct_mode_of_operation;
    global pars_structure;
    global absgrid;
    global corr_map_analyzed;
    global nematic_graph;
    [ theta, brange, sigma ] = UserVariableInputSanitization(handles);
    [ sanitized_image_name, sanitized_image_pos ] = CheckFileName(handles);
    % boolean to check user input
    check_input = ~isempty(theta) && ~isempty(brange) && ~isempty(sigma) ...
                  && ~isempty(sanitized_image_pos);
    if check_input == 1
        theta_range = sprintf('Theta (start, step, end): %d %d %d', ...
                          theta(1), theta(2), theta(3));
        b_range = sprintf('b_range (start, step, end): %d %d %d', brange(1), brange(2), brange(3));
        sigma_value = sprintf('Sigma: %f', sigma);
        data_array = {theta_range, b_range, sigma_value};   
        mode_op = CheckStructMode(struct_mode_of_operation);
        image_to_be_analyzed = imread(path_storage{sanitized_image_pos});
        % perform analysis
        [corr_map_analyzed, nematic_graph, absgrid] = Analysis(mode_op, theta, ...
            brange, sigma, image_to_be_analyzed, pars_structure, handles);
        
        if isempty(corr_map_analyzed) && isempty(nematic_graph)
            return;
        end
        
        Export_Data(data_array, 'Input Arguments', mode_op);
        
        if strcmp(mode_op, 'Regular-Corr-Analysis') == 1
            % display correlation map and do peak finding                
            axes(handles.axes10);
            % scale axes correctly
            b_min = str2num(get(handles.edit1, 'String')); 
            b_max = str2num(get(handles.edit10, 'String')); 
            b_step = str2num(get(handles.edit9, 'String'));
            theta_min = str2num(get(handles.edit11, 'String')); 
            theta_max = str2num(get(handles.edit13, 'String')); 
            theta_step = str2num(get(handles.edit12, 'String'));
            axes(handles.axes6);
            imagesc(b_min:b_step:b_max,theta_min:theta_step:theta_max,corr_map_analyzed);  
            % label axes
            xlabel('X-Axis');   
            ylabel('Y-Axis');        
            axes(handles.axes11);
            xlabel('Translation');
            ylabel('Theta');          
            axes(handles.axes10);
            ylabel('Y-Axis');
            xlabel('X-Axis');
            % reset edit box and slider values to readjust to the change in
            % peak map size
            set(handles.slider1, 'Value',2);
            set(handles.edit7, 'String',2);
        else
            axes(handles.axes10);
            xLimits = get(gca,'XLim');  %# Get the range of the x axis
            yLimits = get(gca,'YLim');  %# Get the range of the y axis
            axes(handles.axes6);
            imagesc(xLimits, yLimits,nematic_graph);           
        end
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
    if isempty(saved_file_name) || strcmp(saved_file_name, '') == 1
        errordlg('You did not input a file name, please try again');
        return
    end
    % saved_file_name is a cell string. saved_file_name{1} turns the cell
    % string into a string
    SaveData(saved_file_name{1}, handles);
% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)    
    global path_storage
    global pars_structure;
    global struct_mode_of_operation;
    
    [ theta, brange, sigma ] = UserVariableInputSanitization(handles);
    % File name can be anything, but format must be jpg, tif, tiff, or png
    valid_image_extensions = {'.jpg', '.png', '.tif', '.tiff'};
    mode_op = CheckStructMode(struct_mode_of_operation);
    for idx = 1:numel(path_storage)
        [pathstr, file, ext] = fileparts(path_storage{idx});
        if ismember(ext,valid_image_extensions) && (~isempty(theta) ...
                && ~isempty(brange) && ~isempty(sigma))

            image_to_be_analyzed = imread(path_storage{idx});
            [corr_map_analyzed, nematic_graph, absgrid] = Analysis(mode_op, theta, brange, sigma, ...
                image_to_be_analyzed, pars_structure, handles);
            % display image, corr_map, and peak_map on graph
            exp_image = imread(path_storage{idx});
            axes(handles.axes10);
            imagesc(exp_image);

            if strcmp(mode_op, 'Regular-Corr-Analysis') == 1
                axes(handles.axes10);
                xLimits = get(gca,'XLim'); % Get the range of the x axis
                yLimits = get(gca,'YLim'); % Get the range of the y axis                
                axes(handles.axes6);
                imagesc(xLimits, yLimits, corr_map_analyzed);
                PeakFindingWrapper('Regular-Corr-Analysis', corr_map_analyzed,...
                                   handles, absgrid);
            else
                axes(handles.axes6);
                imagesc(nematic_graph);
                PeakFindingWrapper('Sub-window-Analysis', nematic_graph, ...
                                   handles, absgrid);
            end
            
            % save data
            experiment_name = sprintf('%s_experiment_%d',file,idx);
            SaveData(experiment_name, handles);
        end
    end
    
    if strcmp(theta, '') == 0 && strcmp(brange, '') == 0 && strcmp(sigma, '') == 0
        theta_range = sprintf('Theta (start, step, end): %d %d %d', ...
                          theta(1), theta(2), theta(3));
        b_range = sprintf('b_range (start, step, end): %d %d %d', brange(1), brange(2), brange(3));
        sigma_value = sprintf('Sigma: %f', sigma);
        data_array = {theta_range, b_range, sigma_value}; 
        Export_Data(data_array, 'Input Arguments', mode_op);
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
% --- Executes on button press in pushbutton12

function pushbutton12_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)   
    global struct_mode_of_operation;
    global absgrid;
    global corr_map_analyzed;
    global nematic_graph;

    mode_op = CheckStructMode(struct_mode_of_operation); 
    
    if isempty(getimage(handles.axes6)) ==1
        errordlg('You did not produce a peak map with your image');
        return;
    end
    
    if strcmp(mode_op, 'Regular-Corr-Analysis') == 1
        PeakFindingWrapper('Regular-Corr-Analysis', corr_map_analyzed, handles, absgrid);
    else
        PeakFindingWrapper('Sub-window-Analysis', nematic_graph, handles, absgrid);
    end

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
    % change mode and set GUI graphs labels to reflect mode result
    StructModeSetting('Sub_window_Analysis');
    set(handles.pushbutton14,'ForegroundColor','blue');
    set(handles.pushbutton15,'ForegroundColor','black');
    set(handles.uipanel7, 'Title', 'Correlation Result');
    set(handles.uipanel8, 'Title', 'Correlation Peak Finding');

% --- Executes on button press in pushbutton15.
function pushbutton15_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    % change mode and set GUI graphs labels to reflect mode result
    StructModeSetting('Correlation_Analysis');
    set(handles.pushbutton15,'ForegroundColor','blue');
    set(handles.pushbutton14,'ForegroundColor','black');
    set(handles.uipanel7, 'Title', 'Sub-window Nematic Graph Result');
    set(handles.uipanel8, 'Title', 'Nematic Graph Peak Finding');

% --- Executes on button press in pushbutton16.
function pushbutton16_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    global struct_mode_of_operation;
    global pars_structure;
    mode_op = CheckStructMode(struct_mode_of_operation);
    % check for empty cells
    prompt_text = {'Subwindow Size: (Inputted: [%d %d])', ...
                   'Local Cutoff point: (Inputted %.2f)',...
                   'Global Cutoff: (Inputted %.2f)', ...
                   'Normalize: (Inputted %.2f)'};               
    prompt_text_empty = {'Subwindow Size: (default: [8 8])', ...
                         'Local Cutoff Point: (default: 1.1)', ...
                         'Global Cutoff: (default: 5)', ...
                         'Normalize: (default: 0)'};

    % mode op determines what type of pop up window for additional
    % parameters
    if strcmp(mode_op, 'Sub-window-Analysis') == 1 
        if isfield(pars_structure, 'Threshold') == 1
            pars_structure = struct('subwdsz', [], ...
                            'iflocalcutoff', [], ...
                            'ifglobalcutoff', [], ...
                            'ifnormalize', []);           
        end
        % if struct is empty
        if isempty(pars_structure) == 1
            prompt = promt_text_empty;
        end       
        empty_struct_idx = structfun(@isempty, pars_structure);
        % if struct is not empty, then take user input and put them as
        % the default prompt inside the message line 
        if isempty(pars_structure) == 0
            field_name = fieldnames(pars_structure);
            for idx = 1:numel(empty_struct_idx)
                if empty_struct_idx(idx) == 1                 
                    prompt{idx} = prompt_text_empty{idx};
                else
                    sprintf(prompt_text{idx}, pars_structure.(field_name{idx}));
                    % combine prompt with field name input by user
                    prompt_input = sprintf(prompt_text{idx}, pars_structure.(field_name{idx}));
                    prompt{idx} = prompt_input;
                end              
            end
        end
        name = 'Additional Parameters For Sub-window Analysis';
        numlines = 1;
        
        response_pars = inputdlg(prompt,name,numlines);

        if isempty(response_pars) == 1
            errordlg('You left field(s) empty, please try again');
            return
        end
        pars_structure = struct('subwdsz', str2num(response_pars{1}), ...
                            'iflocalcutoff', str2num(response_pars{2}), ...
                            'ifglobalcutoff', str2num(response_pars{3}), ...
                            'ifnormalize', str2num(response_pars{4})); 
       
                        
        Export_Data(pars_structure, 'Add_params, sub window', mode_op);
    else
        if isfield(pars_structure, 'subwdsz') == 1
            pars_structure = struct('Threshold', []);
        end
        pars_structure = struct('Threshold', []);
        prompt = {'Relative threshold input for correlation map'};
        name = 'Additional Parameters For Regular Correlation Analysis';
        numlines = 1;
        response_pars = inputdlg(prompt, name, numlines);
        
        if isempty(response_pars) == 0
            pars_structure = struct('Threshold', response_pars{1});
            Export_Data(pars_structure, 'Add Params, regular correlation', mode_op);
            return
        end
      
        errordlg('You did not input anything');
    end
   
