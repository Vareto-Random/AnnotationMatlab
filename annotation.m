function varargout = annotation(varargin)
% ANNOTATION MATLAB code for annotation.fig
%      ANNOTATION, by itself, creates a new ANNOTATION or raises the existing
%      singleton*.
%
%      H = ANNOTATION returns the handle to a new ANNOTATION or the handle to
%      the existing singleton*.
%
%      ANNOTATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ANNOTATION.M with the given input arguments.
%
%      ANNOTATION('Property','Value',...) creates a new ANNOTATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before annotation_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to annotation_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help annotation

% Last Modified by GUIDE v2.5 30-Nov-2016 10:34:46

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @annotation_OpeningFcn, ...
                   'gui_OutputFcn',  @annotation_OutputFcn, ...
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


% --- Executes just before annotation is made visible.
function annotation_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to annotation (see VARARGIN)

% Choose default command line output for annotation
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes annotation wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = annotation_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function editPath_Callback(hObject, eventdata, handles)
% hObject    handle to editPath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editPath as text
%        str2double(get(hObject,'String')) returns contents of editPath as a double


% --- Executes during object creation, after setting all properties.
function editPath_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editPath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbuttonPath.
function pushbuttonPath_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonPath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    folderName = uigetdir('.','Select a folder containing camera subfolders');
    if isequal(folderName, 0)
        disp('User should select folder containing cameras to start...');
        return;
    end
    set(handles.editPath,'String',folderName);
    directory = dir(folderName);
    realFolders = [directory(:).isdir];
    subfolders = {directory(realFolders).name}';
    subfolders(ismember(subfolders,{'.','..'})) = [];
    set(handles.listboxCameras,'String',subfolders);
    


% --- Executes on selection change in listboxCameras.
function listboxCameras_Callback(hObject, eventdata, handles)
% hObject    handle to listboxCameras (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listboxCameras contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listboxCameras


% --- Executes during object creation, after setting all properties.
function listboxCameras_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listboxCameras (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
