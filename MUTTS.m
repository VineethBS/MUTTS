function varargout = MUTTS(varargin)
% MUTTS
% MUlti Target Tracking Simulator

% Last Modified by GUIDE v2.5 15-Mar-2017 12:26:18

gui_Singleton = 0;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @MUTTS_OpeningFcn, ...
    'gui_OutputFcn',  @MUTTS_OutputFcn, ...
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

% --- Executes just before MUTTS is made visible.
function MUTTS_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
% Update handles structure
handles.stepdelay = 1;
handles.experiment_initialized_flag = -1;
handles.experiment_pause = 1;
set(handles.text_stepdelay, 'String', sprintf('%.1f', handles.stepdelay));
handles.configuration_file = 0;
handles.data_file = 0;
handles.configuration_file_chosen = -1;
handles.data_file_chosen = -1;
guidata(hObject, handles);

axes(handles.axes_block_diagram);
pic = imread('block_diagram.jpg');
image(pic);
axis off;
axis image;

% --- Outputs from this function are returned to the command line.
function varargout = MUTTS_OutputFcn(hObject, eventdata, handles)
varargout{1} = handles.output;

function button_start_Callback(hObject, eventdata, handles)
handles = guidata(hObject);

if (handles.configuration_file_chosen == 1) && (handles.data_file_chosen == 1)
    handles = guidata(hObject);
    experiment = MTTSystem(handles.configuration_file, handles.data_file);
    experiment = experiment.initialize_filehandle();
    handles.experiment = experiment;
    guidata(hObject, handles);
    
    % Populate tunable parameters
    list_of_parameters_and_initial_values = handles.experiment.get_dynamic_tunable_parameters();
    table_data = {};
    for i = 1:length(list_of_parameters_and_initial_values)
        temp = list_of_parameters_and_initial_values{i};
        table_data{i, 1} = temp{1};
        table_data{i, 2} = temp{2};
    end
    set(handles.table_parametertuning, 'Data', table_data);
    handles.table_data = table_data;
    guidata(hObject, handles);
    
    while 1
        handles = guidata(hObject);
        if handles.experiment_pause
            pause(str2double(get(handles.text_stepdelay, 'String')));
            continue;
        end
        handles.experiment = handles.experiment.run();
        guidata(hObject, handles);
        [EOF, time, observations, additional_information, tracks] = handles.experiment.get_GUI_step_information();
        if EOF == -1
            return;
        end
        for i = 1:length(observations)
            plot(handles.input_track_axes, time, cell2mat(observations(i)), 'ro', 'MarkerSize', 6);
            hold(handles.input_track_axes, 'on');
        end
        for i = 1:length(tracks)
            plot(handles.input_track_axes, tracks{i}.sequence_times, cell2mat(tracks{i}.sequence_predicted_observations), 'k');
        end
        pause(str2double(get(handles.text_stepdelay, 'String')));
        grid on;
        drawnow;
    end
    
    handles.configuration_file = 0;
    handles.data_file = 0;
    handles.configuration_file_chosen = -1;
    handles.data_file_chosen = -1;
end

function button_chooseconfigfile_Callback(hObject, eventdata, handles)
if get(handles.radio_loadfromfile, 'Value') == 0
    return;
end

[configuration_file, configuration_path] = uigetfile('*.m', 'Choose Configuration File');

if ~(isequal(configuration_file, 0))
    handles = guidata(hObject);
    handles.configuration_file = fullfile(configuration_path, configuration_file);
    handles.configuration_file_chosen = 1;
    set(handles.text_configfilename, 'String', configuration_file);
    guidata(hObject, handles);
end

function slider_stepdelay_Callback(hObject, eventdata, handles)
handles = guidata(hObject);
stepdelay = get(hObject, 'Value');
handles.stepdelay = stepdelay;
guidata(hObject, handles);
set(handles.text_stepdelay, 'String', sprintf('%.1f', handles.stepdelay));
drawnow;

function slider_stepdelay_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function button_pause_Callback(hObject, eventdata, handles)
if strcmp(get(hObject, 'String'), 'Pause')
    set(hObject, 'String', 'Start');
    handles.experiment_pause = 1;
else
    set(hObject, 'String', 'Pause');
    handles.experiment_pause = 0;
end
guidata(hObject, handles);
drawnow;


% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

function popupmenu1_CreateFcn(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function input_track_axes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to input_track_axes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate input_track_axes


% --- Executes on button press in button_configure_inputfile.
function button_configure_inputfile_Callback(hObject, eventdata, handles)
[data_file, data_path] = uigetfile('*.csv', 'Choose Input File');

if ~(isequal(data_file, 0))
    handles = guidata(hObject);
    handles.data_file = fullfile(data_path, data_file);
    handles.data_file_chosen = 1;
    guidata(hObject, handles);
end

% --- Executes on button press in button_configure_metrics.
function button_configure_metrics_Callback(hObject, eventdata, handles)
% hObject    handle to button_configure_metrics (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in button_configure_data_association.
function button_configure_data_association_Callback(hObject, eventdata, handles)
% hObject    handle to button_configure_data_association (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in button_configure_gating.
function button_configure_gating_Callback(hObject, eventdata, handles)
% hObject    handle to button_configure_gating (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in button_configure_track_maintenance.
function button_configure_track_maintenance_Callback(hObject, eventdata, handles)
% hObject    handle to button_configure_track_maintenance (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in button_configure_filtering.
function button_configure_filtering_Callback(hObject, eventdata, handles)
% hObject    handle to button_configure_filtering (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in button_viewconfiguration.
function button_viewconfiguration_Callback(hObject, eventdata, handles)
% hObject    handle to button_viewconfiguration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(handles.radio_loadfromfile, 'Value') == 0
    return;
end

edit(handles.configuration_file);


% --------------------------------------------------------------------
function menu_help_Callback(hObject, eventdata, handles)
% hObject    handle to menu_help (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menu_help_about_Callback(hObject, eventdata, handles)
% hObject    handle to menu_help_about (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
MUTTS_SS;

% --- Executes when entered data in editable cell(s) in table_parametertuning.
function table_parametertuning_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to table_parametertuning (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)
handles = guidata(hObject);
if handles.experiment_pause
    row = eventdata.Indices(1); % column in 2 by design
    handles.table_data{row, 2} = eventdata.NewData;
    handles.experiment = handles.experiment.set_dynamic_tunable_parameters(handles.table_data{row, 1}, handles.table_data{row, 2});
    guidata(hObject, handles);
end
