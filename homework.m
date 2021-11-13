function varargout = homework(varargin)
% HOMEWORK MATLAB code for homework.fig
%      HOMEWORK, by itself, creates a new HOMEWORK or raises the existing
%      singleton*.
%
%      H = HOMEWORK returns the handle to a new HOMEWORK or the handle to
%      the existing singleton*.
%
%      HOMEWORK('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in HOMEWORK.M with the given input arguments.
%
%      HOMEWORK('Property','Value',...) creates a new HOMEWORK or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before homework_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to homework_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help homework

% Last Modified by GUIDE v2.5 09-Jul-2019 09:11:38

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @homework_OpeningFcn, ...
                   'gui_OutputFcn',  @homework_OutputFcn, ...
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


% --- Executes just before homework is made visible.
function homework_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to homework (see VARARGIN)

% Choose default command line output for homework
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes homework wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = homework_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in Mode.
function Mode_Callback(hObject, eventdata, handles)
% hObject    handle to Mode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Mode contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Mode
edit_button(handles);
mode = get(hObject, 'Value');
switch mode
    case 2
        gaussian_image(handles);
    case 3
        laplace_image(handles);
    case 4
        search_image(handles);
    case 5
        identification_image(handles);
end


% --- Executes during object creation, after setting all properties.
function Mode_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Mode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject, 'Value', 1);



function Std_Callback(hObject, eventdata, handles)
% hObject    handle to Std (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Std as text
%        str2double(get(hObject,'String')) returns contents of Std as a double
if isempty(get(hObject, 'String'))
    set(hObject, 'String', '1.0');
end
setappdata(hObject, 'Std', str2double(get(hObject, 'String')));
gaussian_image(handles);


% --- Executes during object creation, after setting all properties.
function Std_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Std (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject, 'Enable', 'off');
setappdata(hObject, 'Std', str2double(get(hObject, 'String')));



function Threshold_Callback(hObject, eventdata, handles)
% hObject    handle to Threshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Threshold as text
%        str2double(get(hObject,'String')) returns contents of Threshold as a double
if isempty(get(hObject, 'String'))
    set(hObject, 'String', '0.0');
end
setappdata(hObject, 'Threshold', str2double(get(hObject, 'String')));
laplace_image(handles);


% --- Executes during object creation, after setting all properties.
function Threshold_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Threshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject, 'Enable', 'off');
setappdata(hObject, 'Threshold', str2double(get(hObject, 'String')));


% --- Executes on button press in Load.
function Load_Callback(hObject, eventdata, handles)
% hObject    handle to Load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[file, path] = uigetfile({'*.jpg', '*.png'}, 'Select an image', './images');
if isequal(file, 0) || isequal(path, 0)
    warndlg('Please select an image!', 'Warning');
    return;
else
    image = imread([path, file]);
    image = im2double(image);
    
    setappdata(handles.Origin, 'Image', image);
    
    set(handles.Mode, 'Value', 1);
    edit_button(handles);
    
    axes(handles.Origin);
    imshow(image, []);
end

% --- Executes on button press in Save.


% --- Executes during object creation, after setting all properties.
function Origin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Origin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate Origin
setappdata(hObject, 'Image', []);


% --- Executes during object creation, after setting all properties.
function Process_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Process (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate Process
setappdata(hObject, 'Image', []);


% --- Executes on button press in Click.
function Click_Callback(hObject, eventdata, handles)
% hObject    handle to Click (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
classifier_image(handles);



function Search_Callback(hObject, eventdata, handles)
% hObject    handle to Search (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Search as text
%        str2double(get(hObject,'String')) returns contents of Search as a double
if isempty(get(hObject, 'String'))
    set(hObject, 'String', '0.0');
end
setappdata(hObject, 'Search', str2double(get(hObject, 'String')));
search_image(handles);

% --- Executes during object creation, after setting all properties.
function Search_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Search (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject, 'Enable', 'off');
setappdata(hObject, 'Search', str2double(get(hObject, 'String')));
