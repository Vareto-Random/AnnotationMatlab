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

    % Last Modified by GUIDE v2.5 02-Dec-2016 00:25:20

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
    folderPath = uigetdir('.','Select a folder containing camera subfolders');
    if isequal(folderPath, 0)
        disp('User should select folder containing cameras to start...');
        return;
    end
    
    % exploring path
    set(handles.editPath,'String',folderPath);
    directory = dir(folderPath);
    realFolders = [directory(:).isdir];
    
    % filtering unnecessary columns and elements
    subfolders = {directory(realFolders).name}';
    subfolders(ismember(subfolders,{'.','..'})) = [];
    
    % creating structure
    global controlVariable;
    controlVariable.tracklet = cell(size(subfolders));
    controlVariable.subject = cell(size(subfolders));
    
    % populating listboxCameras
    set(handles.listboxCameras,'String',subfolders);
    set(handles.listboxCameras,'Enable','on');
    drawnow;
    

% --- Executes on selection change in listboxCameras.
function listboxCameras_Callback(hObject, eventdata, handles)
    % hObject    handle to listboxCameras (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    % Hints: contents = cellstr(get(hObject,'String')) returns listboxCameras contents as cell array
    %        contents{get(hObject,'Value')} returns selected item from listboxCameras
    
    % getting values from interface
    path = get(handles.editPath,'String');
    index = get(handles.listboxCameras,'Value');
    folders = get(handles.listboxCameras,'String');
    
    % appending subfolder
    folder = char(folders(index));
    folderPath = [path '/' folder];
    
    % exploring path
    directory = dir(folderPath);
    realFolders = [directory(:).isdir];
    
    % filtering unnecessary columns and elements
    subfolders = {directory(realFolders).name}';
    subfolders(ismember(subfolders,{'.','..'})) = [];

    % populating listboxTracklets
    set(handles.listboxTracklets,'String',subfolders);
    set(handles.listboxTracklets,'Enable','on');
    drawnow;

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


% --- Executes on selection change in listboxTracklets.
function listboxTracklets_Callback(hObject, eventdata, handles)
    % hObject    handle to listboxTracklets (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    % Hints: contents = cellstr(get(hObject,'String')) returns listboxTracklets contents as cell array
    %        contents{get(hObject,'Value')} returns selected item from listboxTracklets
    
    % getting values from interface
    path = get(handles.editPath,'String');
    cameraIndex = get(handles.listboxCameras,'Value');
    cameraFolder = get(handles.listboxCameras,'String');
    trackletIndex = get(handles.listboxTracklets,'Value');
    trackletFolder = get(handles.listboxTracklets,'String');
    
    % generating final path
    camera = char(cameraFolder(cameraIndex));
    tracklet = char(trackletFolder(trackletIndex));
    folderPath = [path '/' camera '/' tracklet];
    
    % get path to all images
    gallery = imageSet(folderPath);
    numSamples = 24;
    
    % reading images
    counter = 1;
    images = cell(1, numSamples);
    step = floor(gallery.Count / numSamples);
    for index = 1 : step : gallery.Count
        crop = read(gallery, index);
        image = imresize(crop, [120 60]);
        images{counter} = image;
        counter = counter + 1;
    end
    
    % ensuring 24 samples
    samples = images(1:numSamples);
    
    % concatenating all images
    collate01 = [];
    collate02 = [];
    collate03 = [];
    for index = 1 : 8
        collate01 = [collate01 cell2mat(images(index))];
        collate02 = [collate02 cell2mat(images(index + 8))];
        collate03 = [collate03 cell2mat(images(index + 16))];
    end
    collate = [collate01;collate02;collate03];
    imshow(collate);
    


% --- Executes during object creation, after setting all properties.
function listboxTracklets_CreateFcn(hObject, eventdata, handles)
    % hObject    handle to listboxTracklets (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    empty - handles not created until after all CreateFcns called

    % Hint: listbox controls usually have a white background on Windows.
    %       See ISPC and COMPUTER.
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end


% --- Executes on selection change in popupmenuSubjects.
function popupmenuSubjects_Callback(hObject, eventdata, handles)
    % hObject    handle to popupmenuSubjects (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    % Hints: contents = cellstr(get(hObject,'String')) returns popupmenuSubjects contents as cell array
    %        contents{get(hObject,'Value')} returns selected item from popupmenuSubjects

    % get components and index
    contents = cellstr(get(handles.popupmenuSubjects,'String'));
    index = get(handles.popupmenuSubjects,'Value');

    % get indices
    cameraIndex = get(handles.listboxCameras,'Value');
    trackletIndex = get(handles.listboxTracklets,'Value');
    trackletFolder = get(handles.listboxTracklets,'String');

    % save to matrix
    global controlVariable;
    controlVariable.tracklet{cameraIndex,trackletIndex} = trackletFolder(trackletIndex);
    controlVariable.subject{cameraIndex,trackletIndex} = contents(index);


% --- Executes during object creation, after setting all properties.
function popupmenuSubjects_CreateFcn(hObject, eventdata, handles)
    % hObject    handle to popupmenuSubjects (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    empty - handles not created until after all CreateFcns called

    % Hint: popupmenu controls usually have a white background on Windows.
    %       See ISPC and COMPUTER.
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end


% --- Executes on button press in pushbuttonNext.
function pushbuttonNext_Callback(hObject, eventdata, handles)
    % hObject    handle to pushbuttonNext (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    trackletFolder = get(handles.listboxTracklets,'String');
    trackletIndex = get(handles.listboxTracklets,'Value');
    
    if trackletIndex < size(trackletFolder,1)
        trackletIndex = trackletIndex + 1;
        set(handles.listboxTracklets,'Value',trackletIndex);
        listboxTracklets_Callback(hObject, eventdata, handles);
        popupmenuSubjects_Callback(hObject, eventdata, handles)
    end


% --- Executes on button press in pushbuttonBack.
function pushbuttonBack_Callback(hObject, eventdata, handles)
    % hObject    handle to pushbuttonBack (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    trackletIndex = get(handles.listboxTracklets,'Value');
    
    if trackletIndex > 1
        trackletIndex = trackletIndex - 1;
        set(handles.listboxTracklets,'Value',trackletIndex);
        listboxTracklets_Callback(hObject, eventdata, handles);
        popupmenuSubjects_Callback(hObject, eventdata, handles)
    end


% --- Executes on button press in pushbuttonSave.
function pushbuttonSave_Callback(hObject, eventdata, handles)
    % hObject    handle to pushbuttonSave (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    
    global controlVariable;
    
    % getting values from interface
    path = get(handles.editPath,'String');
    folders = get(handles.listboxCameras,'String');
    
    for row = 1 : size(controlVariable.tracklet,1)
        % appending subfolder
        folder = char(folders(row));
        folderPath = [path '/' folder];
        fileName = [folder '_annotation_file.txt'];
        
        % opening file in folder cam$$
        fileID = fopen([folderPath '/' fileName],'w');
        for col = 1 : size(controlVariable.tracklet,2)
            if ~isempty(controlVariable.tracklet{row,col})
                % printing to file
                tracklet = char(controlVariable.tracklet{row,col});
                label = char(controlVariable.subject{row,col});
                label = strrep(label,' ','');
                fprintf(fileID,'%s %s\n',tracklet,label);
            end
        end
        fclose(fileID);
    end
    
