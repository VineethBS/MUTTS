function varargout = MUTTS_MetricsConfigure(varargin)
% MUTTS_METRICSCONFIGURE MATLAB code for MUTTS_MetricsConfigure.fig
%      MUTTS_METRICSCONFIGURE, by itself, creates a new MUTTS_METRICSCONFIGURE or raises the existing
%      singleton*.
%
%      H = MUTTS_METRICSCONFIGURE returns the handle to a new MUTTS_METRICSCONFIGURE or the handle to
%      the existing singleton*.
%
%      MUTTS_METRICSCONFIGURE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MUTTS_METRICSCONFIGURE.M with the given input arguments.
%
%      MUTTS_METRICSCONFIGURE('Property','Value',...) creates a new MUTTS_METRICSCONFIGURE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MUTTS_MetricsConfigure_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MUTTS_MetricsConfigure_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MUTTS_MetricsConfigure

% Last Modified by GUIDE v2.5 15-Mar-2017 15:43:47

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MUTTS_MetricsConfigure_OpeningFcn, ...
                   'gui_OutputFcn',  @MUTTS_MetricsConfigure_OutputFcn, ...
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


% --- Executes just before MUTTS_MetricsConfigure is made visible.
function MUTTS_MetricsConfigure_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MUTTS_MetricsConfigure (see VARARGIN)

% Choose default command line output for MUTTS_MetricsConfigure
handles.output = hObject;
handles.original_file_chosen = 0;
handles.original_file = 0;
set(handles.check_compute_ospa, 'Value', 1);
set(handles.check_compute_omat, 'Value', 1);
set(handles.check_compute_hausdorff, 'Value', 1);
set(handles.edit_ospa_c, 'String', '100');
set(handles.edit_ospa_p, 'String', '2');
set(handles.edit_omat_c, 'String', '100');
set(handles.edit_separator, 'String', ',');
set(handles.edit_dimensions, 'String', '1');
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes MUTTS_MetricsConfigure wait for user response (see UIRESUME)
uiwait(handles.figure_metrics_configure);


% --- Outputs from this function are returned to the command line.
function varargout = MUTTS_MetricsConfigure_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in button_choose_originaltracks.
function button_choose_originaltracks_Callback(hObject, eventdata, handles)
[tracks_file, tracks_path] = uigetfile('*.csv', 'Choose Original Tracks File');

if ~(isequal(tracks_file, 0))
    handles = guidata(hObject);
    handles.original_file = fullfile(tracks_path, tracks_file);
    handles.original_file_chosen = 1;
    set(handles.text_original_tracks_file, 'String', tracks_file);
    guidata(hObject, handles);
end


% --- Executes on button press in check_compute_ospa.
function check_compute_ospa_Callback(hObject, eventdata, handles)
% hObject    handle to check_compute_ospa (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of check_compute_ospa


% --- Executes on button press in check_compute_omat.
function check_compute_omat_Callback(hObject, eventdata, handles)
% hObject    handle to check_compute_omat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of check_compute_omat


% --- Executes on button press in check_compute_hausdorff.
function check_compute_hausdorff_Callback(hObject, eventdata, handles)
% hObject    handle to check_compute_hausdorff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of check_compute_hausdorff


function edit_ospa_c_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ospa_c (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ospa_c as text
%        str2double(get(hObject,'String')) returns contents of edit_ospa_c as a double


% --- Executes during object creation, after setting all properties.
function edit_ospa_c_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ospa_c (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ospa_p_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ospa_p (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ospa_p as text
%        str2double(get(hObject,'String')) returns contents of edit_ospa_p as a double


% --- Executes during object creation, after setting all properties.
function edit_ospa_p_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ospa_p (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_omat_c_Callback(hObject, eventdata, handles)
% hObject    handle to edit_omat_c (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_omat_c as text
%        str2double(get(hObject,'String')) returns contents of edit_omat_c as a double


% --- Executes during object creation, after setting all properties.
function edit_omat_c_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_omat_c (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in button_ok.
function button_ok_Callback(hObject, eventdata, handles)
% hObject    handle to button_ok (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = guidata(hObject);
if handles.original_file_chosen
    parameters.original_tracks_file = handles.original_file;
    parameters.in_field_separator = get(handles.edit_separator, 'String');
    parameters.dimension_observations = floor(get(handles.edit_dimensions, 'String'));
    parameters.compute_omat = get(handles.check_compute_omat, 'Value');
    parameters.compute_ospa = get(handles.check_compute_ospa, 'Value');
    parameters.compute_hausdorff = get(handles.check_compute_hausdorff, 'Value');
    parameters.ospa_parameters.c = double(get(handles.edit_ospa_c, 'String'));
    parameters.ospa_parameters.p = double(get(handles.edit_ospa_p, 'String'));
    parameters.omat_parameters.c = double(get(handles.edit_omat_c, 'String'));
    parameters.plot_metrics = 1;
    temp = Metrics(parameters);
    handles.output = temp;
    guidata(hObject, handles);
    uiresume();
end

% --- Executes on button press in button_cancel.
function button_cancel_Callback(hObject, eventdata, handles)
% hObject    handle to button_cancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(gcf);


% --- Executes when user attempts to close figure_metrics_configure.
function figure_metrics_configure_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure_metrics_configure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
delete(hObject);



function edit_separator_Callback(hObject, eventdata, handles)
% hObject    handle to edit_separator (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_separator as text
%        str2double(get(hObject,'String')) returns contents of edit_separator as a double


% --- Executes during object creation, after setting all properties.
function edit_separator_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_separator (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_dimensions_Callback(hObject, eventdata, handles)
% hObject    handle to text_dimensions (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of text_dimensions as text
%        str2double(get(hObject,'String')) returns contents of text_dimensions as a double


% --- Executes during object creation, after setting all properties.
function text_dimensions_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text_dimensions (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
