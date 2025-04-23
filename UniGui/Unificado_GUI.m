function varargout = Unificado_GUI(varargin)
% UNIFICADO_GUI M-file for Unificado_GUI.fig
%      UNIFICADO_GUI, by itself, creates a new UNIFICADO_GUI or raises the existing
%      singleton*.
%
%      H = UNIFICADO_GUI returns the handle to a new UNIFICADO_GUI or the handle to
%      the existing singleton*.
%
%      UNIFICADO_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in UNIFICADO_GUI.M with the given input arguments.
%
%      UNIFICADO_GUI('Property','Value',...) creates a new UNIFICADO_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Unificado_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Unificado_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Unificado_GUI

% Last Modified by GUIDE v2.5 11-Jan-2019 11:38:46

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @Unificado_GUI_OpeningFcn, ...
    'gui_OutputFcn',  @Unificado_GUI_OutputFcn, ...
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


% --- Executes just before Unificado_GUI is made visible.
function Unificado_GUI_OpeningFcn(hObject, ~, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Unificado_GUI (see VARARGIN)

% Choose default command line output for Unificado_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Unificado_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Unificado_GUI_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit_path_Callback(hObject, eventdata, handles)
% hObject    handle to edit_path (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_path as text
%        str2double(get(hObject,'String')) returns contents of edit_path as a double


% --- Executes during object creation, after setting all properties.
function edit_path_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_path (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Browse_path.
function Browse_path_Callback(hObject, eventdata, handles)
% hObject    handle to Browse_path (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set( handles.edit_path,'String',uigetdir());



function editEpochSize_Callback(hObject, eventdata, handles)
% hObject    handle to editEpochSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editEpochSize as text
%        str2double(get(hObject,'String')) returns contents of editEpochSize as a double


% --- Executes during object creation, after setting all properties.
function editEpochSize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editEpochSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editUpTrashold_Callback(hObject, eventdata, handles)
% hObject    handle to editUpTrashold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editUpTrashold as text
%        str2double(get(hObject,'String')) returns contents of editUpTrashold as a double


% --- Executes during object creation, after setting all properties.
function editUpTrashold_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editUpTrashold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editLowTrashold_Callback(hObject, eventdata, handles)
% hObject    handle to editLowTrashold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editLowTrashold as text
%        str2double(get(hObject,'String')) returns contents of editLowTrashold as a double


% --- Executes during object creation, after setting all properties.
function editLowTrashold_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editLowTrashold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on button press in pushbutton_Executar.
function pushbutton_Executar_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Executar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.text_ready_busy,'String','Busy');
handle_msgbox = msgbox('Calculando');

path = strcat(get(handles.edit_path,'String'),'\');
format=get(handles.FormatPnl,'SelectedObject');
format=get(format,'String');


epochs = strcat(path,'eventos.txt');

EpochSize = str2double( get(handles.editEpochSize,'String') );
upthresh= str2num( get(handles.editUpTrashold,'String') );    %limite máximo
lowthresh= str2num( get(handles.editLowTrashold,'String') );   %limite minimo
lowFreq= str2num( get(handles.lFreq,'String') );
higFreq= str2num( get(handles.hFreq,'String') );

freq_amostragem = str2num( get(handles.edit_freq_amostragem,'String'));

name=strcat(path,['*.' format]);
d=dir(name);   %carrega os arquivo
folder = 'netlab\';
mkdir(path, folder);
path2 = strcat(path,folder);
fpRe=fopen([strcat(path,folder)+"report"+date+".csv"],"wt");
fprintf(fpRe,"EpochSize=%g\n",EpochSize);
fprintf(fpRe,"upthresh=%g\n",upthresh);
fprintf(fpRe,"lowthresh=%g\n",lowthresh);
fprintf(fpRe,"lowFreq=%g\n",lowFreq);
fprintf(fpRe,"higFreq=%g\n",higFreq);

fprintf(fpRe,"File\tDeleted\ttotal\tdif\ttempo\n");


for j=1:length(d)
    
    filename = strcat(path, d(j).name);
    %% Load Data
    if(format(1)=='A')
        EEG = pop_loadbci( filename, freq_amostragem );
    elseif format(1)=='V'
        EEG = pop_loadbv(path,d(j).name);
    elseif format(1)=='E'
        EEG = pop_biosig(filename, 'importevent','off');
    else
        EEG = pop_loadset( filename);
    end
    
    disp(['========================>',d(j).name]);
    
    N = floor(EEG.pnts/(freq_amostragem*EpochSize ));
    fid = fopen([path 'eventos.txt' ],'w');
    fprintf(fid,'type\tlatency\n');
    for q=1:N
        fprintf(fid,'%d\t%f\n',q,q*EpochSize);
    end
    fclose(fid);
    
   
    if(format(1)=='A' || format(1)=='E' )
        EEG = pop_chanedit(EEG, 'lookup','standard-10-5-cap385.elp');
    end
    %caso queira eliminar algum eletrodo adicionar nesta lista
    EEG = pop_select( EEG,'nochannel',{'EMGd' 'EMGm' 'ECM' 'Óculo' 'FOTO' 'M1' 'M2' 'VEOG' 'HEOG' 'EMG' 'EKG' '1.F10' '1.F9' '2.F10' '2.F9' '1.T9' '1.T10' '2.T10' '2.T9'});
    
    EEG = pop_eegfiltnew(EEG, 'locutoff',lowFreq,'hicutoff',higFreq);
    %EEG = pop_eegfilt( EEG, lowFreq, higFreq, [], [0], 0, 0, 'fir1', 0);
    
    %% Epoch Data
    
    EEG = pop_importevent( EEG, 'event',epochs,'fields',{'type' 'latency'},'skipline',1,'timeunit',1);
    
    EEG = pop_epoch( EEG, {  }, [0        EpochSize], 'epochinfo', 'yes');
    
    %% Filter data values, reject ephocs with values greater than upthresh
    nchan=EEG.nbchan;
    tmin=EEG.xmin;
    tmax=EEG.xmax;
    
    
    [EEG trej] = pop_eegthresh(EEG,1,[1:nchan],lowthresh,upthresh,tmin,tmax,0,0);
    disp("Ephocas resultantes = " + (EEG.trials - length(trej)));
    difT=EEG.trials -length(trej);
    fprintf(fpRe,"%s\t%g\t%g\t%g\t%g\n",d(j).name,length(trej),EEG.trials,difT,difT*EpochSize);

    EEG = pop_rejepoch(EEG, trej, 0); %rejeita épocas por limites de microV
    
    %% save ascii data in a different folder
    
    EEG = pop_saveset( EEG, 'filename',d(j).name,'filepath',path2);
    
    pop_export(EEG,[path2 d(j).name(1:end-3) 'asc'],'transpose','on','time','off','precision',5);
    
end

set(handles.text_ready_busy,'String','Ready');
delete(handle_msgbox);
fclose(fpRe);
disp ('FIM');



function edit_freq_amostragem_Callback(hObject, eventdata, handles)
% hObject    handle to edit_freq_amostragem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_freq_amostragem as text
%        str2double(get(hObject,'String')) returns contents of edit_freq_amostragem as a double


% --- Executes during object creation, after setting all properties.
function edit_freq_amostragem_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_freq_amostragem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1


% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton2


% --- Executes on button press in onlyFilter.
function onlyFilter_Callback(hObject, eventdata, handles)
% hObject    handle to onlyFilter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of onlyFilter



function lFreq_Callback(hObject, eventdata, handles)
% hObject    handle to lFreq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lFreq as text
%        str2double(get(hObject,'String')) returns contents of lFreq as a double


% --- Executes during object creation, after setting all properties.
function lFreq_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lFreq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function hFreq_Callback(hObject, eventdata, handles)
% hObject    handle to hFreq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of hFreq as text
%        str2double(get(hObject,'String')) returns contents of hFreq as a double


% --- Executes during object creation, after setting all properties.
function hFreq_CreateFcn(hObject, eventdata, handles)
% hObject    handle to hFreq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
