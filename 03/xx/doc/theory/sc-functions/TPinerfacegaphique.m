function varargout = TPinerfacegaphique(varargin)
% TPINERFACEGAPHIQUE MATLAB code for TPinerfacegaphique.fig
%      TPINERFACEGAPHIQUE, by itself, creates a new TPINERFACEGAPHIQUE or raises the existing
%      singleton*.
%
%      H = TPINERFACEGAPHIQUE returns the handle to a new TPINERFACEGAPHIQUE or the handle to
%      the existing singleton*.
%
%      TPINERFACEGAPHIQUE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TPINERFACEGAPHIQUE.M with the given input arguments.
%
%      TPINERFACEGAPHIQUE('Property','Value',...) creates a new TPINERFACEGAPHIQUE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before TPinerfacegaphique_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to TPinerfacegaphique_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above contentReadFileDisplay1 to modify the response to help TPinerfacegaphique

% Last Modified by GUIDE v2.5 01-Dec-2017 14:43:32

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @TPinerfacegaphique_OpeningFcn, ...
                   'gui_OutputFcn',  @TPinerfacegaphique_OutputFcn, ...
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


% --- Executes just before TPinerfacegaphique is made visible.
function TPinerfacegaphique_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to TPinerfacegaphique (see VARARGIN)

% Choose default command line output for TPinerfacegaphique
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes TPinerfacegaphique wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = TPinerfacegaphique_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in OpenFILE.
function OpenFILE_Callback(hObject, eventdata, handles)
% hObject    handle to OpenFILE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[file_name, path_name] = uigetfile('*.txt','Selectionez fichier');
full_path_name = strcat(path_name,file_name);
set(handles.PathName, 'String', full_path_name)
text=fileread(full_path_name);
set(handles.contentReadFileDisplay1, 'String', text)



function zoneEdit_Callback(hObject, eventdata, handles)
% hObject    handle to zoneEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of zoneEdit as text
%        str2double(get(hObject,'String')) returns contents of zoneEdit as a double
user_input = get(handles.zoneEdit, 'String');
handles.user_input1 = user_input;
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function zoneEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to zoneEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btn_save_file.
function btn_save_file_Callback(hObject, eventdata, handles)
% hObject    handle to btn_save_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[file_name, path_name] = uiputfile('*.txt','Selectionez fichier');
full_path_name = strcat(path_name,file_name);
set(handles.pathName2, 'String', full_path_name)
fid=fopen(full_path_name, 'w');
fprintf(fid, handles.user_input);
fclose(fid);
