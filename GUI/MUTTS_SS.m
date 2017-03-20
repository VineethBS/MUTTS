function varargout = MUTTS_SS(varargin)
% MUTTS_SS MATLAB code for MUTTS_SS.fig
%      MUTTS_SS, by itself, creates a new MUTTS_SS or raises the existing
%      singleton*.
%
%      H = MUTTS_SS returns the handle to a new MUTTS_SS or the handle to
%      the existing singleton*.
%
%      MUTTS_SS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MUTTS_SS.M with the given input arguments.
%
%      MUTTS_SS('Property','Value',...) creates a new MUTTS_SS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MUTTS_SS_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MUTTS_SS_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MUTTS_SS

% Last Modified by GUIDE v2.5 10-Mar-2017 13:42:09

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MUTTS_SS_OpeningFcn, ...
                   'gui_OutputFcn',  @MUTTS_SS_OutputFcn, ...
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


% --- Executes just before MUTTS_SS is made visible.
function MUTTS_SS_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MUTTS_SS (see VARARGIN)

% Choose default command line output for MUTTS_SS
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);
% UIWAIT makes MUTTS_SS wait for user response (see UIRESUME)
% uiwait(handles.figure1);
axes(handles.splashimage);
pic = imread('MUTTS.jpg');
image(pic);
axis off;
axis image;


% --- Outputs from this function are returned to the command line.
function varargout = MUTTS_SS_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
