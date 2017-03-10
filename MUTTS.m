function varargout = MUTTS(varargin)
% MUTTS
% MUlti Target Tracking Simulator

% Last Modified by GUIDE v2.5 10-Mar-2017 15:50:22

gui_Singleton = 1;
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
handles.stepdelay = 2;
handles.experiment_initialized_flag = -1;
handles.experiment_pause = 0;
set(handles.text_stepdelay, 'String', sprintf('%.1f', handles.stepdelay));
guidata(hObject, handles);

% --- Outputs from this function are returned to the command line.
function varargout = MUTTS_OutputFcn(hObject, eventdata, handles)
varargout{1} = handles.output;

function button_start_Callback(hObject, eventdata, handles)
handles = guidata(hObject);
experiment = handles.experiment;

while 1
    handles = guidata(hObject);
    if handles.experiment_pause
        pause(str2double(get(handles.text_stepdelay, 'String')));
        continue;
    end
    experiment = experiment.run();
    [EOF, time, observations, additional_information, tracks] = experiment.get_GUI_step_information();
    if EOF == -1
        return;
    end
    for i = 1:length(observations)
        plot(handles.input_track_axes, time, cell2mat(observations(i)), 'ro', 'MarkerSize', 6);
        hold(handles.input_track_axes, 'on');
    end
    for i = 1:length(tracks)
        plot(tracks{i}.sequence_times, cell2mat(tracks{i}.sequence_predicted_observations), 'k');
    end
    pause(str2double(get(handles.text_stepdelay, 'String')));
    grid on;
    drawnow;
end

function button_initialize_Callback(hObject, eventdata, handles)
[configuration_file, configuration_path] = uigetfile('*.m', 'Choose Configuration File');
[data_file, data_path] = uigetfile('*.csv', 'Choose Input File');

if ~((isequal(configuration_file, 0)) && (isequal(data_file, 0)))
    handles = guidata(hObject);
    experiment = MTTSystem(fullfile(configuration_path, configuration_file), fullfile(data_path, data_file));
    experiment = experiment.initialize_filehandle();
    set(handles.button_start, 'Enable', 'on');
    set(handles.button_pause, 'Enable', 'on');
    handles.experiment = experiment;
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
    set(hObject, 'String', 'Restart');
    handles.experiment_pause = 1;
else
    set(hObject, 'String', 'Pause');
    handles.experiment_pause = 0;
end
guidata(hObject, handles);
drawnow;
