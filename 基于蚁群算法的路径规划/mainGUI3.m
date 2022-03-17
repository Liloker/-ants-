function varargout = mainGUI3(varargin)
% MAINGUI3 M-file for mainGUI3.fig
%      MAINGUI3, by itself, creates a new MAINGUI3 or raises the existing
%      singleton*.
%
%      H = MAINGUI3 returns the handle to a new MAINGUI3 or the handle to
%      the existing singleton*.
%
%      MAINGUI3('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAINGUI3.M with the given input arguments.
%
%      MAINGUI3('Property','Value',...) creates a new MAINGUI3 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before mainGUI3_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to mainGUI3_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help mainGUI3

% Last Modified by GUIDE v2.5 20-Jan-2010 10:47:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @mainGUI3_OpeningFcn, ...
                   'gui_OutputFcn',  @mainGUI3_OutputFcn, ...
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


% --- Executes just before mainGUI3 is made visible.
function mainGUI3_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to mainGUI3 (see VARARGIN)

% Choose default command line output for mainGUI3
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes mainGUI3 wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% ustawic zminne globalne
global cost_matrix points;

%set(handles.uitable_macierz_kosztow, 'Data', cost_matrix);

title(handles.axes_droga_psz,'Najlepsza droga, alg. pszczeli');
xlabel(handles.axes_droga_psz,'X');
ylabel(handles.axes_droga_psz,'Y');

title(handles.axes_ANT_droga,'Najlepsza droga, alg. mrówkowy');
xlabel(handles.axes_ANT_droga,'X');
ylabel(handles.axes_ANT_droga,'Y');

title(handles.axes_GEN_droga,'Najlepsza droga, alg. genetyczny');
xlabel(handles.axes_GEN_droga,'X');
ylabel(handles.axes_GEN_droga,'Y');

xlabel(handles.axes_GUI_mapa_miast,'X');
ylabel(handles.axes_GUI_mapa_miast,'Y');

% gui_figure_handle = figure(gcbf);
% set(gui_figure_handle,'CurrentAxes',handles.axes_GUI_mapa_miast);
% plot(handles.axes_GUI_mapa_miast, points(:,1), points(:,2),'ok');
% if(mat_row_length(points)>=1)
%     hold on;
%     plot(h, points(1,1), points(1,2),...
%         'o',...
%         'LineWidth',2,...
%         'color', 'k', ...
%         'MarkerFaceColor','r',...
%         'MarkerSize',10);
%     hold off;
% end




% --- Outputs from this function are returned to the command line.
function varargout = mainGUI3_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_start.
function pushbutton_start_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global n size cost_matrix type points max_iter N Cn;
Cn = n;
N = size;


%zostaw tylko najwazniejsze wartosci:
clear('-regexp', '!n|!size|!cost_matrix|!type|!max_iter|!points|!N|!Cn|!GUI_BEE_scouts|!GUI_BEE_paths_count|!GUI_BEE_workers|!GUI_ANT_wspolczynnik_parowania|!GUI_ANT_rozmiar_jednej_populacji|!GUI_GEN_poczatkowa_wielkosc_populacji');

% clearvars -global -except...
%     n size cost_matrix type max_iter points N Cn... 
%     GUI_BEE_scouts GUI_BEE_paths_count GUI_BEE_workers...
%     GUI_ANT_wspolczynnik_parowania GUI_ANT_rozmiar_jednej_populacji...
%     GUI_GEN_poczatkowa_wielkosc_populacji
whos('global')
hf=figure(1);
clf(hf);


%algorytm pszczeli INIT
global GUI_BEE_scouts GUI_BEE_paths_count GUI_BEE_workers;
BEE_routes=[];
BEE_q=[];
BEE_time=[];
bee_init(cost_matrix,n,GUI_BEE_workers,GUI_BEE_scouts,GUI_BEE_paths_count);
%global BEE_time BEE_time_sums;
BEE_best_route = [];
BEE_best_q = [];

%algorytm mrowkowy INIT
global GUI_ANT_wspolczynnik_parowania;
ANT_routes=[];
ANT_q=[];
ANT_time=[];
ant_init(cost_matrix,... % 
    n,... % Cie
    inf,... % poj
    2,... % bet
    10.0,... % al1
    1,... % al2
    GUI_ANT_wspolczynnik_parowania,... % ro
    1,... % g1
    4.0,... % g2
    1,... % g3
    200,... % pop
    Inf); % popr


%algorytm genetyczny INIT
global GUI_GEN_poczatkowa_wielkosc_populacji;
GEN_routes=[];
GEN_q=[];
GEN_time=[];
gen_init(GUI_GEN_poczatkowa_wielkosc_populacji);
%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%

% okno z dodatkowymi informacjami o algorytmie
h_figure_pszczeli = figure(1);
set(h_figure_pszczeli,'Name','Algorytm pszczeli' );

% pod-wykres z kosztem drogi dla najlepszego rozwiazania
hold on;    
h_figure_pszczeli_naj_rozwiazanie = subplot(2,1,1);
title('Koszt drogi najlepszego rozwiazania');
xlabel('Numer iteracji');
ylabel('Wartosc funkcji celu');
grid on;
hold off;

hold on;
h_figure_pszczeli_czas = subplot(2,1,2);
title('Czas wykonywania sie algorytmu');
xlabel('Numer iteracji');
ylabel('Czas [s]');
grid on;
hold off;


% GLOWNA PETLA ALGORYTMOW %
for k=1:max_iter
    
    % BEGIN algorytm pszczeli STEP     
    tic;
    [BEE_best_route BEE_best_q] = bee_step; 
    BEE_step_time = toc;
    BEE_time = [BEE_time BEE_step_time];
    %BEE_routes = [BEE_routes BEE_best_route];
    BEE_q = [BEE_q BEE_best_q];
    % END algorytm pszczeli STEP 
    
    
    
    % BEGIN algorytm mrowkowy STEP
    tic;
    for ANT_k = 1:30
        [ANT_best_route ANT_best_q] = ant_step; 
    end;
    ANT_time = [ANT_time toc];
    ANT_routes = [ANT_routes ANT_best_route'];
    ANT_q = [ANT_q ANT_best_q];
    % END algorytm pszczeli STEP 

    
    
    % BEGIN algorytm genetyczny STEP
    tic;
    [GEN_best_route GEN_best_q] = gen_step; 
    GEN_time = [GEN_time toc];
    GEN_routes = [GEN_routes GEN_best_route];
    GEN_q = [GEN_q GEN_best_q];
    % END algorytm pszczeli STEP 

    
    
%     gui_figure_handle = figure(gcbf);
%     set(gui_figure_handle,'CurrentAxes',handles.axes_GUI_mapa_miast);
    % rysowanie drogi
    % set(0,'CurrentFigure',gcbf);
    gui_figure_handle = figure(gcbf);
    set(gui_figure_handle,'CurrentAxes',handles.axes_droga_psz);
    color_plot_odwiedzone_miejsca(handles.axes_droga_psz, BEE_best_route, n, points);
    set(gui_figure_handle,'CurrentAxes',handles.axes_ANT_droga);
    color_plot_odwiedzone_miejsca(handles.axes_ANT_droga, ANT_best_route', n, points);
    set(gui_figure_handle,'CurrentAxes',handles.axes_GEN_droga);
    color_plot_odwiedzone_miejsca(handles.axes_GEN_droga, GEN_best_route', n, points);
    hold off;
    
    %rysowanie najlepszych kosztow
    %figure(h_figure_pszczeli);
    set(0,'CurrentFigure',h_figure_pszczeli);
    set(h_figure_pszczeli,'CurrentAxes',h_figure_pszczeli_naj_rozwiazanie);
    hold on;
    plot(h_figure_pszczeli_naj_rozwiazanie, BEE_q,'-go');
    plot(h_figure_pszczeli_naj_rozwiazanie, ANT_q,'-bo');
    plot(h_figure_pszczeli_naj_rozwiazanie, GEN_q,'-ro');
    hold off;
    
    %rysowanie calkowitego czasu
    set(h_figure_pszczeli,'CurrentAxes',h_figure_pszczeli_czas);
    hold on;
    BEE_time_sums(k) = sum(BEE_time);
    ANT_time_sums(k) = sum(ANT_time);
    GEN_time_sums(k) = sum(GEN_time);
    plot(h_figure_pszczeli_czas, BEE_time_sums,'-go');
    plot(h_figure_pszczeli_czas, ANT_time_sums,'-bo');
    plot(h_figure_pszczeli_czas, GEN_time_sums,'-ro');
    hold off;
    

    set(handles.edit_psz_droga, 'String', num2str(BEE_best_route'));
    set(handles.edit_psz_koszt_drogi, 'String', num2str(BEE_best_q'));
    set(handles.edit_ANT_droga, 'String', num2str(ANT_best_route));
    set(handles.edit_ANT_droga_koszt, 'String', num2str(ANT_best_q'));
    set(handles.edit_GEN_droga, 'String', num2str(GEN_best_route));
    set(handles.edit_GEN_droga_koszt, 'String', num2str(GEN_best_q'));    
end;

% best_q





% --- Executes on button press in pushbutton_wylosuj.
function pushbutton_wylosuj_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_wylosuj (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global cost_matrix points size n;

[cost_matrix points] = generate_matrix(size, n);
global N Cn
Cn = n;
N = size;

gui_figure_handle = figure(gcbf);
set(gui_figure_handle,'CurrentAxes',handles.axes_GUI_mapa_miast);
hold off;
plot(handles.axes_GUI_mapa_miast, points(:,1), points(:,2),'ok');
if(mat_row_length(points)>=1)
    hold on;
    plot(h, points(1,1), points(1,2),'or');
    hold off;
end




% --- Executes on button press in pushbutton_krok.
function pushbutton_krok_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_krok (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit_ilosc_miast_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ilosc_miast (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ilosc_miast as text
%        str2double(get(hObject,'String')) returns contents of edit_ilosc_miast as a double

global cost_matrix points size n N Cn;


user_entry = str2double(get(hObject,'string'));
if (isnan(user_entry) || user_entry < n || user_entry<1 )
    errordlg('Prawidlowe wartosci to wartosci numeryczne:\n wieksze od 1 i ilosci ciezarowek!, ','Zle dane','modal')
    uicontrol(hObject)
    set(hObject,'string',size);
    return
elseif (user_entry == size)
    return
else
    %set global ilsoc miast
    size = user_entry;
    [cost_matrix points] = generate_matrix(size, n);
    Cn = n;
    N = size;
gui_figure_handle = figure(gcbf);
set(gui_figure_handle,'CurrentAxes',handles.axes_GUI_mapa_miast);
hold off;
plot(handles.axes_GUI_mapa_miast, points(:,1), points(:,2),'ok');
if(mat_row_length(points)>=1)
    hold on;
    plot(h, points(1,1), points(1,2),'or');
    hold off;
end
end



% --- Executes during object creation, after setting all properties.
function edit_ilosc_miast_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ilosc_miast (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.

global size;

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

set(hObject,'string', num2str(size));




function edit_liczba_iteracji_Callback(hObject, eventdata, handles)
% hObject    handle to edit_liczba_iteracji (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_liczba_iteracji as text
%        str2double(get(hObject,'String')) returns contents of edit_liczba_iteracji as a double

global max_iter;

user_entry = str2double(get(hObject,'string'));
if (isnan(user_entry) || user_entry < 1)
    errordlg('Prawidlowe wartosci to wartosci numeryczne wieksze od 1!','Nieprawidlowe dane','modal')
    uicontrol(hObject)
    set(hObject,'string',max_iter);
    return
elseif (user_entry == max_iter)
    return
else
    %set global maksymalna ilosc iteracji
    max_iter = user_entry;
end


% --- Executes during object creation, after setting all properties.
function edit_liczba_iteracji_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_liczba_iteracji (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
global max_iter;

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

set(hObject,'string', num2str(max_iter));




function edit_ilosc_ciezarowek_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ilosc_ciezarowek (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ilosc_ciezarowek as text
%        str2double(get(hObject,'String')) returns contents of edit_ilosc_ciezarowek as a double


global cost_matrix points size n N Cn;

user_entry = str2double(get(hObject,'string'));
if (isnan(user_entry) || user_entry<1 || user_entry>size)
    errordlg('Prawidlowe wartosci to wartosci numeryczne:\n wieksze lub nrowne 1 oraz mniejsze od ilosci miast!','Nieprawidlowe dane','modal')
    uicontrol(hObject)
    set(hObject,'string',n);
    return
elseif (user_entry == n)
    return
else
    %set global ilsoc ciezarowek
    n = user_entry;
    [cost_matrix points] = generate_matrix(size, n);
    Cn = n;
    N = size;
    gui_figure_handle = figure(gcbf);
set(gui_figure_handle,'CurrentAxes',handles.axes_GUI_mapa_miast);
hold off;
plot(handles.axes_GUI_mapa_miast, points(:,1), points(:,2),'ok');
if(mat_row_length(points)>=1)
    hold on;
    plot(h, points(1,1), points(1,2),...
        'o',...
        'LineWidth',2,...
        'color', 'k', ...
        'MarkerFaceColor','r',...
        'MarkerSize',10);
    hold off;
end

end

% --- Executes during object creation, after setting all properties.
function edit_ilosc_ciezarowek_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ilosc_ciezarowek (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
global n;

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


set(hObject,'string', num2str(n));

function edit_psz_robotnicy_Callback(hObject, eventdata, handles)
% hObject    handle to edit_psz_robotnicy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_psz_robotnicy as text
%        str2double(get(hObject,'String')) returns contents of edit_psz_robotnicy as a double
global GUI_BEE_scouts GUI_BEE_paths_count GUI_BEE_workers;

user_entry = str2double(get(hObject,'string'));
if (isnan(user_entry) || user_entry<GUI_BEE_scouts)
    errordlg('Prawidlowe wartosci to wartosci numeryczne:wieksze lub rowne ilosci robotnikow!','Nieprawidlowe dane','modal')
    uicontrol(hObject)
    set(hObject,'string',GUI_BEE_workers);
    return
elseif (user_entry == GUI_BEE_workers)
    return
else
    %set global ilsoc ciezarowek
    GUI_BEE_workers = user_entry;
end


% --- Executes during object creation, after setting all properties.
function edit_psz_robotnicy_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_psz_robotnicy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
global GUI_BEE_scouts GUI_BEE_paths_count GUI_BEE_workers;

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

set(hObject, 'String', GUI_BEE_workers);



function edit_psz_zwaidowcy_Callback(hObject, eventdata, handles)
% hObject    handle to edit_psz_zwaidowcy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_psz_zwaidowcy as text
%        str2double(get(hObject,'String')) returns contents of edit_psz_zwaidowcy as a double
global GUI_BEE_scouts GUI_BEE_paths_count GUI_BEE_workers;

user_entry = str2double(get(hObject,'string'));
if (isnan(user_entry) || user_entry<GUI_BEE_paths_count)
    errordlg('Prawidlowe wartosci to wartosci numeryczne: wieksze lub rowne liczbie drog!','Nieprawidlowe dane','modal')
    uicontrol(hObject)
    set(hObject,'string',GUI_BEE_scouts);
    return
elseif (user_entry == GUI_BEE_scouts)
    return
else
    %set global ilsoc ciezarowek
    GUI_BEE_scouts = user_entry;
end

% --- Executes during object creation, after setting all properties.
function edit_psz_zwaidowcy_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_psz_zwaidowcy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.

global GUI_BEE_scouts GUI_BEE_paths_count GUI_BEE_workers;

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

set(hObject, 'String', GUI_BEE_scouts);




function edit_psz_liczba_drog_Callback(hObject, eventdata, handles)
% hObject    handle to edit_psz_liczba_drog (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_psz_liczba_drog as text
%        str2double(get(hObject,'String')) returns contents of edit_psz_liczba_drog as a double
global GUI_BEE_scouts GUI_BEE_paths_count GUI_BEE_workers;

user_entry = str2double(get(hObject,'string'));
if (isnan(user_entry) || user_entry<1 || user_entry>GUI_BEE_scouts)
    errordlg('Prawidlowe wartosci to wartosci numeryczne: wieksze lub nrowne 1 oraz mniejsze od ilosci zwiadowcow!','Nieprawidlowe dane','modal')
    uicontrol(hObject)
    set(hObject,'string',GUI_BEE_paths_count);
    return
elseif (user_entry == GUI_BEE_paths_count)
    return
else
    %set global ilsoc ciezarowek
    GUI_BEE_paths_count = user_entry;
end


% --- Executes during object creation, after setting all properties.
function edit_psz_liczba_drog_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_psz_liczba_drog (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
global GUI_BEE_scouts GUI_BEE_paths_count GUI_BEE_workers;

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

set(hObject, 'String', GUI_BEE_paths_count);



function edit_psz_droga_Callback(hObject, eventdata, handles)
% hObject    handle to edit_psz_droga (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_psz_droga as text
%        str2double(get(hObject,'String')) returns contents of edit_psz_droga as a double


% --- Executes during object creation, after setting all properties.
function edit_psz_droga_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_psz_droga (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_psz_koszt_drogi_Callback(hObject, eventdata, handles)
% hObject    handle to edit_psz_koszt_drogi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_psz_koszt_drogi as text
%        str2double(get(hObject,'String')) returns contents of edit_psz_koszt_drogi as a double


% --- Executes during object creation, after setting all properties.
function edit_psz_koszt_drogi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_psz_koszt_drogi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when selected object is changed in buttongroup_funkcja_celu.
function buttongroup_funkcja_celu_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in buttongroup_funkcja_celu 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)

global type;

%retrieve GUI data, i.e. the handles structure
handles = guidata(hObject); 
 
switch get(eventdata.NewValue,'Tag')   % Get Tag of selected object
    case 'radiobutton_suma_kosztow'
      %execute this code when radiobutton_suma_kosztow is selected
      type = 0;
 
    case 'radiobutton_suma_kosztow_i_dlugosc_drogi'
      %execute this code when radiobutton_suma_kosztow_i_dlugosc_drogi is selected
      type = 1;
 
    case 'radiobutton_suma_kosztow_i_ladownosc'
      %execute this code when radiobutton_suma_kosztow_i_dlugosc_drogi is selected  
      type = 2;
    otherwise
       % Code for when there is no match.
       type = 1;
 
end
%updates the handles structure
guidata(hObject, handles);



function edit_GEN_poczatkowa_wielkosc_populacji_Callback(hObject, eventdata, handles)
% hObject    handle to edit_GEN_poczatkowa_wielkosc_populacji (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_GEN_poczatkowa_wielkosc_populacji as text
%        str2double(get(hObject,'String')) returns contents of edit_GEN_poczatkowa_wielkosc_populacji as a double

global GUI_GEN_poczatkowa_wielkosc_populacji;

user_entry = str2double(get(hObject,'string'));
if (isnan(user_entry) || user_entry < 1 )
    errordlg('Prawidlowe wartosci to wartosci numeryczne:\n wieksze od 1!, ','Zle dane','modal')
    uicontrol(hObject)
    set(hObject,'string',GUI_GEN_poczatkowa_wielkosc_populacji);
    return
elseif (user_entry == GUI_GEN_poczatkowa_wielkosc_populacji)
    return
else
    %set global ilsoc miast
    GUI_GEN_poczatkowa_wielkosc_populacji = user_entry;
end

% --- Executes during object creation, after setting all properties.
function edit_GEN_poczatkowa_wielkosc_populacji_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_GEN_poczatkowa_wielkosc_populacji (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.


if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

global GUI_GEN_poczatkowa_wielkosc_populacji;
set(hObject, 'String', GUI_GEN_poczatkowa_wielkosc_populacji);




function edit_ANT_wspolczynnik_parowania_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ANT_wspolczynnik_parowania (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ANT_wspolczynnik_parowania as text
%        str2double(get(hObject,'String')) returns contents of edit_ANT_wspolczynnik_parowania as a double

global GUI_ANT_wspolczynnik_parowania;

user_entry = str2double(get(hObject,'string'));
if (isnan(user_entry) || user_entry < 0 ||  user_entry > 1)
    errordlg('Prawidlowe wartosci to wartosci numeryczne: to wieksze od 0 i mniejsze od 1!, ','Zle dane','modal')
    uicontrol(hObject)
    set(hObject,'string',GUI_ANT_wspolczynnik_parowania);
    return
elseif (user_entry == GUI_ANT_wspolczynnik_parowania)
    return
else
    %set global ilsoc miast
    GUI_ANT_wspolczynnik_parowania = user_entry;
end



% --- Executes during object creation, after setting all properties.
function edit_ANT_wspolczynnik_parowania_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ANT_wspolczynnik_parowania (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

global GUI_ANT_wspolczynnik_parowania;
set(hObject, 'String', GUI_ANT_wspolczynnik_parowania);


function edit_ANT_rozmiar_jednej_populacji_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ANT_rozmiar_jednej_populacji (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ANT_rozmiar_jednej_populacji as text
%        str2double(get(hObject,'String')) returns contents of edit_ANT_rozmiar_jednej_populacji as a double

global GUI_ANT_rozmiar_jednej_populacji;

user_entry = str2double(get(hObject,'string'));
if (isnan(user_entry) || user_entry < 1)
    errordlg('Prawidlowe wartosci to wartosci numeryczne: to wieksze od 1!, ','Zle dane','modal')
    uicontrol(hObject)
    set(hObject,'string',GUI_ANT_rozmiar_jednej_populacji);
    return
elseif (user_entry == GUI_ANT_rozmiar_jednej_populacji)
    return
else
    %set global ilsoc miast
    GUI_ANT_rozmiar_jednej_populacji = user_entry;
end


% --- Executes during object creation, after setting all properties.
function edit_ANT_rozmiar_jednej_populacji_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ANT_rozmiar_jednej_populacji (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

global GUI_ANT_rozmiar_jednej_populacji;
set(hObject, 'String', GUI_ANT_rozmiar_jednej_populacji);



function edit_ANT_droga_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ANT_droga (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ANT_droga as text
%        str2double(get(hObject,'String')) returns contents of edit_ANT_droga as a double


% --- Executes during object creation, after setting all properties.
function edit_ANT_droga_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ANT_droga (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ANT_droga_koszt_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ANT_droga_koszt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ANT_droga_koszt as text
%        str2double(get(hObject,'String')) returns contents of edit_ANT_droga_koszt as a double


% --- Executes during object creation, after setting all properties.
function edit_ANT_droga_koszt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ANT_droga_koszt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_GEN_droga_Callback(hObject, eventdata, handles)
% hObject    handle to edit_GEN_droga (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_GEN_droga as text
%        str2double(get(hObject,'String')) returns contents of edit_GEN_droga as a double


% --- Executes during object creation, after setting all properties.
function edit_GEN_droga_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_GEN_droga (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_GEN_droga_koszt_Callback(hObject, eventdata, handles)
% hObject    handle to edit_GEN_droga_koszt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_GEN_droga_koszt as text
%        str2double(get(hObject,'String')) returns contents of edit_GEN_droga_koszt as a double


% --- Executes during object creation, after setting all properties.
function edit_GEN_droga_koszt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_GEN_droga_koszt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
