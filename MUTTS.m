function varargout = MUTTS(varargin)
% MUTTS 
% MUltiobject Target Tracking Simulator

% Last Modified by GUIDE v2.5 07-Mar-2017 18:41:30

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
guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = MUTTS_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;


function button_start_Callback(hObject, eventdata, handles)
experiment = handles.experiment;
while 1
    experiment = experiment.run();
    [EOF, time, observations, additional_information] = experiment.get_GUI_step_information();
    if EOF == -1
        return;
    end
    for i = 1:length(observations)
        plot(handles.input_track_axes, time, cell2mat(observations(i)), 'ro');
        hold(handles.input_track_axes, 'on');
    end
end

function button_stop_Callback(hObject, eventdata, handles)


function button_initialize_Callback(hObject, eventdata, handles)

[configuration_file, configuration_path] = uigetfile('*.m', 'Choose Configuration File');
[data_file, data_path] = uigetfile('*.csv', 'Choose Input File');

if ~((isequal(configuration_file, 0)) && (isequal(data_file, 0)))
    experiment = MTTSystem(fullfile(configuration_path, configuration_file), fullfile(data_path, data_file));
    experiment = experiment.initialize_filehandle();
    set(handles.button_start, 'Enable', 'on');
    set(handles.button_stop, 'Enable', 'on');
    handles.experiment = experiment;
    guidata(hObject, handles);
end
