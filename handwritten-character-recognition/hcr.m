function varargout = hcr(varargin)
% CHARGUI3 M-file for hcr.fig
%      CHARGUI3, by itself, creates a new CHARGUI3 or raises the existing
%      singleton*.
%
%      H = CHARGUI3 returns the handle to a new CHARGUI3 or the handle to
%      the existing singleton*.
%
%      CHARGUI3('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CHARGUI3.M with the given input arguments.
%
%      CHARGUI3('Property','Value',...) creates a new CHARGUI3 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before charGUI_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to hcr_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help hcr

% Last Modified by GUIDE v2.5 10-May-2011 23:30:24

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @hcr_OpeningFcn, ...
                   'gui_OutputFcn',  @hcr_OutputFcn, ...
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


% --- Executes just before hcr is made visible.
function hcr_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to hcr (see VARARGIN)
%load data;
%assignin('base','net',net);
% Choose default command line output for hcr
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes hcr wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = hcr_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pbLoad.
function pbLoad_Callback(hObject, eventdata, handles)
% hObject    handle to pbLoad (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname] = uigetfile({'*.bmp';'*.jpg';'*.gif';'*.png';'*.*'}, 'Pick an Image File');
S = imread([pathname,filename]);
axes(handles.axes1);
imshow(S);
handles.S = S;
guidata(hObject, handles);


% --- Executes on button press in pbSelect.
% function pbSelect_Callback(hObject, eventdata, handles)
% % hObject    handle to pbSelect (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% S = handles.S;
% axes(handles.axes1);
% 
% % Selection of location
% if isfield(handles,'api')
%     handles.api.delete();
%     rmfield(handles,'api');
%     rmfield(handles,'hRect');
%     axes(handles.axes1);
%     imshow(S);
% end
% 
% axes(handles.axes1);
% sz = size(S);
% handles.hRect = imrect(gca,[round(sz(2)/2) round(sz(1)/2) 20 20]); % Select object
% handles.api = iptgetapi(handles.hRect);
% guidata(hObject, handles);
% 
% 
% % img_crop = imcrop(S);
% % axes(handles.axes2);
% % imshow(img_crop);
% % 
% % handles.img_crop = img_crop;
% 
% guidata(hObject, handles);
% 
% 
% 
% 
% % --- Executes on button press in pbCrop.
% function pbCrop_Callback(hObject, eventdata, handles)
% % hObject    handle to pbCrop (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% handles.loc = handles.api.getPosition();
% axes(handles.axes1);
% S = handles.S;
% 
% handles.img_crop = imcrop(S,handles.loc);
% axes(handles.axes2);
% imshow(handles.img_crop);
% 
% % img_crop = imcrop(S);
% % axes(handles.axes2);
% % imshow(img_crop);
% % 
% % handles.img_crop = img_crop;
% 
% 
% guidata(hObject, handles);
% 
% % --- Executes on button press in pbPreprocess.
function pbPreprocess_Callback(hObject, eventdata, handles)
% hObject    handle to pbPreprocess (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

bw1 = handles.S;
bw2 = rgb2gray(bw1);
%figure,imshow(bw2);
bw3 = im2bw(bw1,graythresh(bw2));
%figure,imshow(bw3);
bw=imresize(bw3,[573,786]);
%imgGray = rgb2gray(img_crop);
%bw = im2bw(img_crop,graythresh(imgGray));
%axes(handles.axes2);
%imshow(bw);
% bw2 = edu_imgcrop(bw);
% axes(handles.axes4);
% imshow(bw2);
bw2=hcr_thinned1(bw);
axes(handles.axes1);
imshow(bw2);

handles.bw2 = bw2;
guidata(hObject, handles);


% --- Executes on button press in pbRecognize.
function pbRecognize_Callback(hObject, eventdata, handles)
% hObject    handle to pbRecognize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%charvec = handles.charvec;

%load ('ucrtest3.mat','a3');
check=handles.check;
if(check==1)
load hcr_net.mat;
%net03=create_fit_net(a3,t3);

bw2  = handles.bw2;
I=bw2;
[y3 x1]=size(I);
y1=1;
count=0;
avg=0;
x0=0;
y0=0;
ansr='';
while(y1<y3)
    flo1=0;
    %flo3=0;
    while (sum(I(y1,:))==0)
        y1=y1+1;
        if(y1>y3)
            flo1=1;
            break;
        end
    end
    if(flo1==1)
        break;
    end
    y2=y1;
    while (sum(I(y2,:))>0)
        y2=y2+1;
    end
    p=imcrop(I,[1,y1,(x1-1),(y2-y1)]);
    disp('-');
    ansr=strcat(ansr,'-');
    %figure,imshow(p);
    y1=y2;
    [y4 x4]=size(p);
    x5=1;
    x6=1;

    while(x5<=x4)
        flo2=0;
        while (sum(p(:,x5))==0)
            x5=x5+1;
            if(x5>x4)
                flo2=1;
                break;
            end
        end
        if flo2==1
            break;
        end
        if((x5-x6)>y0/2)
            disp('-');
            ansr=strcat(ansr,'-');
        end
        x6=x5;
        while (sum(p(:,x6))>0)
            x6=x6+1;
        end
        q=imcrop(p,[x5,1,(x6-x5),(y4-1)]);
        x5=x6;
        %figure,imshow(q);
        z=hcr_extracrop(q);
        [rem1 rem2]=size(z);
        if(rem1<5 & rem2<5)
            continue;
        end
        count=count+1;
        if count==1
            [x0 y0]=size(z);
            avg=avg+y0;
            y0=avg/count;
            disp(x0);
            disp(y0);
        end
        %figure,imshow(z);
        array=hcr_ext2(z);
        bw3=uint8(array);
        c=255-bw3;
        level = graythresh(c);
        d = im2bw(c,level);
        array=d;
        %figure,imshow(array);
        a1(:,1)=zeros(500,1);
        a2=1;
        for i=1:25
            for j=1:20
                a1(a2)=array(i,j);
                a2=a2+1;
            end
        end
        
         result = sim(net,a1);
         result = compet(result);
         num = find(compet(result) == 1);
         %[val, num] = max(result);
         ch1=char(num+64);
         disp(ch1);
         ansr=strcat(ansr,ch1);
        %disp(a1);
        %if count==1;
            %a3=a1;
            %a3=[a3 a1];
        %else
            %a3=[a3 a1];
        %end
        %flo3=1;
    end
    %if(flo3==1)
     %   break;
    %end
end
disp(count);
%save('ucrtest3.mat','a3');

% charvec = edu_imgresize(bw2);
% selected_net = get(handles.editNN,'string');
% selected_net = evalin('base',selected_net);


set(handles.answer, 'string',ansr);
else
    load hcr_neural.mat;
%net03=create_fit_net(a3,t3);

bw2  = handles.bw2;
I=bw2;
[y3 x1]=size(I);
y1=1;
count=0;
avg=0;
x0=0;
y0=0;
ansr='';
while(y1<y3)
    flo1=0;
    %flo3=0;
    while (sum(I(y1,:))==0)
        y1=y1+1;
        if(y1>y3)
            flo1=1;
            break;
        end
    end
    if(flo1==1)
        break;
    end
    y2=y1;
    while (sum(I(y2,:))>0)
        y2=y2+1;
    end
    p=imcrop(I,[1,y1,(x1-1),(y2-y1)]);
    disp('-');
    ansr=strcat(ansr,'-');
    %figure,imshow(p);
    y1=y2;
    [y4 x4]=size(p);
    x5=1;
    x6=1;

    while(x5<=x4)
        flo2=0;
        while (sum(p(:,x5))==0)
            x5=x5+1;
            if(x5>x4)
                flo2=1;
                break;
            end
        end
        if flo2==1
            break;
        end
        if((x5-x6)>y0*3/4)
            disp('-');
            ansr=strcat(ansr,'-');
        end
        x6=x5;
        while (sum(p(:,x6))>0)
            x6=x6+1;
        end
        q=imcrop(p,[x5,1,(x6-x5),(y4-1)]);
        x5=x6;
        %figure,imshow(q);
        z=hcr_extracrop(q);
        [rem1 rem2]=size(z);
        if(rem1<5 & rem2<5)
            continue;
        end
        count=count+1;
        if count==1
            [x0 y0]=size(z);
            avg=avg+y0;
            y0=avg/count;
            disp(x0);
            disp(y0);
        end
        %figure,imshow(z);
        u=imresize(z,[14,10],'bicubic');
        level = graythresh(u);
        array = im2bw(u,level);
        %figure,imshow(array);
        a1(:,1)=zeros(140,1);
        a2=1;
        for i=1:14
            for j=1:10
                a1(a2)=array(i,j);
                a2=a2+1;
            end
        end
        
         result = sim(net1,a1);
         result = compet(result);
         num = find(compet(result) == 1);
         %[val, num] = max(result);
         ch1=char(num+96);
         disp(ch1);
         ansr=strcat(ansr,ch1);
        %disp(a1);
        %if count==1;
            %a3=a1;
            %a3=[a3 a1];
        %else
            %a3=[a3 a1];
        %end
        %flo3=1;
    end
    %if(flo3==1)
     %   break;
    %end
end
disp(count);
%save('ucrtest3.mat','a3');

% charvec = edu_imgresize(bw2);
% selected_net = get(handles.editNN,'string');
% selected_net = evalin('base',selected_net);


set(handles.answer, 'string',ansr);
end

% --- Executes on button press in pbNN.
function pbNN_Callback(hObject, eventdata, handles)
% hObject    handle to pbNN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)





function editNN_Callback(hObject, eventdata, handles)
% hObject    handle to editNN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editNN as text
%        str2double(get(hObject,'String')) returns contents of editNN as a double


% --- Executes during object creation, after setting all properties.
function editNN_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editNN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





function editResult_Callback(hObject, eventdata, handles)
% hObject    handle to editResult (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editResult as text
%        str2double(get(hObject,'String')) returns contents of editResult as a double


% --- Executes during object creation, after setting all properties.
function editResult_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editResult (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1
if (get(hObject,'Value') == get(hObject,'Max'))
   % Checkbox is checked-take appropriate action
   check=1;
else
   check=0;
   % Checkbox is not checked-take appropriate action
end
handles.check = check;
guidata(hObject, handles);
