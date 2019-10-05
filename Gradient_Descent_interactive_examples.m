function varargout = Gradient_Descent_interactive_examples(varargin)
% GRADIENT_DESCENT_INTERACTIVE_EXAMPLES MATLAB code for Gradient_Descent_interactive_examples.fig
%      GRADIENT_DESCENT_INTERACTIVE_EXAMPLES, by itself, creates a new GRADIENT_DESCENT_INTERACTIVE_EXAMPLES or raises the existing
%     
%      H = GRADIENT_DESCENT_INTERACTIVE_EXAMPLES returns the handle to a new GRADIENT_DESCENT_INTERACTIVE_EXAMPLES or the handle to
%      the existing singleton*.
%
%      GRADIENT_DESCENT_INTERACTIVE_EXAMPLES('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GRADIENT_DESCENT_INTERACTIVE_EXAMPLES.M with the given input arguments.
%
%      GRADIENT_DESCENT_INTERACTIVE_EXAMPLES('Property','Value',...) creates a new GRADIENT_DESCENT_INTERACTIVE_EXAMPLES or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Gradient_Descent_interactive_examples_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Gradient_Descent_interactive_examples_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Gradient_Descent_interactive_examples

% Last Modified by GUIDE v2.5 04-Oct-2019 19:03:38

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Gradient_Descent_interactive_examples_OpeningFcn, ...
                   'gui_OutputFcn',  @Gradient_Descent_interactive_examples_OutputFcn, ...
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


% --- Executes just before Gradient_Descent_interactive_examples is made visible.
function Gradient_Descent_interactive_examples_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Gradient_Descent_interactive_examples (see VARARGIN)

% Choose default command line output for Gradient_Descent_interactive_examples
handles.output = hObject;
x = -20:0.1:20;
y = -5:0.1:5;
[X,Y] = meshgrid(x,y);
Z = quadratic_plot(X,Y);
hold on
contour(X,Y,Z)
x0 = [str2num(handles.x01_value.String);str2num(handles.x02_value.String)];
plot(x0(1),x0(2),'r+','MarkerSize',10);
box on

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Gradient_Descent_interactive_examples wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Gradient_Descent_interactive_examples_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

handles = guidata(hObject);

alpha = get(hObject,'Value');
handles.valeur_alpha_txt.String = num2str(round(alpha,4));
x0 = [str2num(handles.x01_value.String);str2num(handles.x02_value.String)];

if handles.checkbox1.Value
    obj_function = @(x) quadratic_function(x);
elseif handles.checkbox2.Value
    obj_function = @(x) rosenbrock_function(x);
end

% On lance le gradient
[sol, points] = gradient_descent(obj_function, x0, alpha);
cla(handles.axes1)


plot(handles.axes1,[x0(1) points(1,:)],[x0(2) points(2,:)],'r','LineStyle','-','Marker','o');
hold(handles.axes1,'on')
plot(handles.axes1,x0(1),x0(2),'r+','MarkerSize',10);
if handles.checkbox1.Value
    x = -20:0.1:20;
    y = -5:0.1:5;
    [X,Y] = meshgrid(x,y);
    Z = quadratic_plot(X,Y);
    contour(X,Y,Z,'Parent', handles.axes1)
    hold(handles.axes1,'off')
    xlim(handles.axes1,[-20,20]);
    ylim(handles.axes1,[-5,5]);
elseif handles.checkbox2.Value
    x = -2:0.01:2;
    y = -1:0.01:3;
    [X,Y] = meshgrid(x,y);
    Z = rosenbrock_plot(X,Y);
    contour(X,Y,Z,'Parent', handles.axes1,'LevelList',[0.1,3,5,10,20,50,200,450,1500])
    hold(handles.axes1,'off')
    xlim(handles.axes1,[-2,2]);
    ylim(handles.axes1,[-1,3]);
end





% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
addlistener(hObject, 'ContinuousValueChange', @(hObject, eventdata) slider1_Callback(hObject, eventdata, handles));
% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.checkbox2.Value = 0;
handles.step_min_val.String = 0;
handles.step_max_val.String = 0.5;
handles.slider1.Min = 0;
handles.slider1.Max = 0.5;
handles.slider1.Value = (handles.slider1.Min + handles.slider1.Max)/2;

alpha = handles.slider1.Value;
handles.valeur_alpha_txt.String = num2str(round(alpha,5));

cla(handles.axes1)
x = -20:0.1:20;
y = -5:0.1:5;
[X,Y] = meshgrid(x,y);
Z = quadratic_plot(X,Y);
contour(X,Y,Z,'Parent', handles.axes1)
xlim(handles.axes1,[-20,20]);
ylim(handles.axes1,[-5,5]);

handles.x01_value.String ='-4.5';
handles.x02_value.String ='4.5';

hold(handles.axes1,'on')
plot(handles.axes1,-4.5,4.5,'r+','MarkerSize',10);

% Hint: get(hObject,'Value') returns toggle state of checkbox1


% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.checkbox1.Value = 0;

handles.step_min_val.String = 0;
handles.step_max_val.String = 0.005;
handles.slider1.Min = 0;
handles.slider1.Max = 0.005;
handles.slider1.Value = (handles.slider1.Min + handles.slider1.Max)/2;

alpha = handles.slider1.Value;
handles.valeur_alpha_txt.String = num2str(round(alpha,5));

cla(handles.axes1)

x = -2:0.01:2;
y = -1:0.01:3;
[X,Y] = meshgrid(x,y);

Z = rosenbrock_plot(X,Y);
contour(X,Y,Z,'Parent', handles.axes1,'LevelList',[0.1,3,5,10,20,50,200,450,1500]);
xlim(handles.axes1,[-2,2]);
ylim(handles.axes1,[-1,3]);

handles.x01_value.String ='-1.5';
handles.x02_value.String ='1.5';

hold(handles.axes1,'on')
plot(handles.axes1,-1.5,1.5,'r+','MarkerSize',10);
% Hint: get(hObject,'Value') returns toggle state of checkbox2

    
function [fx,dfx] = quadratic_function(x)
    fx = x(1)^2 + 2*x(2)^2;
    dfx = [2*x(1);4*x(2)];
    
function [Z] = quadratic_plot(X,Y)
   Z = X.^2 + 2*Y.^2;
    
function [fx,dfx] = rosenbrock_function(x)
    a = 1;
    b = 100;
    fx = (a-x(1))^2 + b * (x(2)-x(1)^2)^2;
    dfx = [-2*(a-x(1))+2*b*(x(2)-x(1)^2)*(-2*x(1)) ; b*2*(x(2)-x(1)^2)];
    
function [Z] = rosenbrock_plot(X,Y)
    a = 1;
    b = 100;
    Z = (a-X).^2 + b * (Y-X.^2).^2;


function [sol, points] = gradient_descent(obj_function, x0, alpha)
    
    Nmax = 500;
    
    points = zeros(2,Nmax);
    
    xcurr = x0;
    [~,dfx] = obj_function(xcurr);
    
    for i = 1: Nmax
        xnew = xcurr - alpha*dfx;
        points(:,i) = xnew;
        xcurr = xnew;
        [~,dfx] = obj_function(xcurr);
    end
    
    sol = xnew;



function x01_value_Callback(hObject, eventdata, handles)
% hObject    handle to x01_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if handles.checkbox1.Value
    lim_val_max = 20;
    lim_val_min = -lim_val_max;
elseif handles.checkbox2.Value
    lim_val_max = 2;
    lim_val_min = -lim_val_max;
end
value = round(str2num(hObject.String),1);

if(isempty(value))
    value = 1;
    hObject.String = '1';
end
if value <lim_val_min
    value = lim_val_min;
elseif value >lim_val_max
    value = lim_val_max;
end
hObject.String = num2str(value);
handles.Ti_value.Value = value;
% Hints: get(hObject,'String') returns contents of x01_value as text
%        str2double(get(hObject,'String')) returns contents of x01_value as a double


% --- Executes during object creation, after setting all properties.
function x01_value_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x01_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function x02_value_Callback(hObject, eventdata, handles)
% hObject    handle to x02_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if handles.checkbox1.Value
    lim_val_max = 5;
    lim_val_min = -lim_val_max;
elseif handles.checkbox2.Value
    lim_val_max = 3;
    lim_val_min = -1;
end

value = round(str2num(hObject.String),1);
if(isempty(value))
    value = 1;
    hObject.String = '1';
end

if value <lim_val_min
    value = lim_val_min;
elseif value >lim_val_max
    value = lim_val_max;
end
hObject.String = num2str(value);
handles.Ti_value.Value = value;
% Hints: get(hObject,'String') returns contents of x02_value as text
%        str2double(get(hObject,'String')) returns contents of x02_value as a double


% --- Executes during object creation, after setting all properties.
function x02_value_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x02_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1
