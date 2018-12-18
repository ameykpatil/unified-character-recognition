function varargout = bcr(varargin)
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @bcr_OpeningFcn, ...
                   'gui_OutputFcn',  @bcr_OutputFcn, ...
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

% --- Executes just before bcr is made visible.
function bcr_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to bcr (see VARARGIN)
%load data;
%assignin('base','net',net);
% Choose default command line output for bcr
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes bcr wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = bcr_OutputFcn(hObject, eventdata, handles) 
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
[filename, pathname] = uigetfile({'*.bmp';'*.jpg';'*.gif';'*.*'}, 'Pick an Image File');
S = imread([pathname,filename]);
axes(handles.axes1);
imshow(S);

handles.S = S;
guidata(hObject, handles);

% --- Executes on button press in pbEnterdigit.
function pbDigit_Callback(hObject, eventdata, handles)
% hObject    handle to pbDigit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.num,'Enable','on');

% --- Executes on button press in pbCrop.
function pbCrop_Callback(hObject, eventdata, handles)
% hObject    handle to pbCrop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
S=handles.S;
Q=uint8(S);
R=255-Q;
level = graythresh(R);
BW = im2bw(R,level);
I=BW;

[y1 x3]=size(I);
x1=1;
while (sum(I(:,x1))==0)
    x1=x1+1;
    if(x1>x3)
        break;
    end
end
p1=imcrop(I,[x1,1,(x3-x1),y1]);
%imshow(p1);

x2=x3;
while(sum(I(:,x2))==0)
    x2=x2-1;
    if(x2<1)
        break;
    end
end
p2=imcrop(I,[x1,1,(x2-x1),y1]);
%imshow(p2);

x3=x2;
y2=1;
while(sum(I(y2,:))==0)
    y2=y2+1;
    if(y2>y1)
        break;
    end
end
p3=imcrop(I,[x1,y2,(x2-x1),(y1-y2)]);
%imshow(p3);

while(I(y2,x2)==1)
    x2=x2-1;
    if(x2<1)
        break;
    end
end
while(I(y2,x2)==0)
    x2=x2-1;
    if(x2<1)
        break;
    end
end
while(I(y2,x2)==1)
    x2=x2-1;
    if(x2<1)
        break;
    end
end

x=x1;
while(I(y2,x)==0)
    x=x+1;
    if(x>x2)
        break;
    end
end
while(I(y2,x)==1)
    x=x+1;
    if(x>x2)
        break;
    end
end
while(I(y2,x)==0)
    x=x+1;
    if(x>x2)
        break;
    end
end
while(I(y2,x)==1)
    x=x+1;
    if(x>x2)
        break;
    end
end

p4=imcrop(I,[x,1,(x2-x),y1]);
%figure,imshow(p4);

mid=(x2-x)/2;
p5=imcrop(I,[x,1,mid,y1]);
%figure,imshow(p5);
p6=imcrop(I,[(x+mid),1,mid,y1]);
%figure,imshow(p6);

mid1=round(mid);
xleft=x+mid1;
while(I(y2,xleft)==0)
    xleft=xleft-1;
    if(xleft<x)
        break;
    end
end
while(I(y2,xleft)==1)
    xleft=xleft-1;
    if(xleft<x)
        break;
    end
end
while(I(y2,xleft)==0)
    xleft=xleft-1;
    if(xleft<x)
        break;
    end
end
left=imcrop(I,[x,1,(xleft-x),y1]);
%figure,imshow(left);

xright=x+mid1;
while(I(y2,xright)==0)
    xright=xright+1;
    if(xright>x2)
        break;
    end
end
while(I(y2,xright)==1)
    xright=xright+1;
    if(xright>x2)
        break;
    end
end
while(I(y2,xright)==0)
    xright=xright+1;
    if(xright>x2)
        break;
    end
end
right=imcrop(I,[xright,1,(x2-xright),y1]);
%figure,imshow(right);

digit1=get(handles.num,'string');
digit=str2num(digit1);
if(digit<2 || digit>13)
    out = dialog('WindowStyle', 'normal', 'Name', 'Error');
else
    if(digit>1 && digit<8)
        s=(xleft-x)/42.0;
        new1x=x+(digit-2)*7*s;
        new2x=x+(digit-1)*7*s;
    else
        s1=(x2-xright)/42.0;
        new1x=xright+(digit-8)*7*s1;
        new2x=xright+(digit-7)*7*s1;
    end
    p7=imcrop(I,[new1x,y2,(new2x-new1x),y1]);
    axes(handles.axes3);
    imshow(p7);
    handles.p7=p7;
end
guidata(hObject,handles);

% --- Executes on button press in pbRecognize.
function pbRecognize_Callback(hObject, eventdata, handles)
% hObject    handle to pbRecognize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I=handles.p7;
%ans=zeros(20,8);

z=-1;
for i=1:20
        ans(i,1)=0;
        ans(i,7)=1;
        if(z>8)
            z=-1;
        end
        ans(i,8)=z+1;
        z=z+1;
end

ans(1,2)=0;
ans(1,3)=0;
ans(1,4)=1;
ans(1,5)=1;
ans(1,6)=0;

ans(2,2)=0;
ans(2,3)=1;
ans(2,4)=1;
ans(2,5)=0;
ans(2,6)=0;

ans(3,2)=0;
ans(3,3)=1;
ans(3,4)=0;
ans(3,5)=0;
ans(3,6)=1;

ans(4,2)=1;
ans(4,3)=1;
ans(4,4)=1;
ans(4,5)=1;
ans(4,6)=0;

ans(5,2)=1;
ans(5,3)=0;
ans(5,4)=0;
ans(5,5)=0;
ans(5,6)=1;

ans(6,2)=1;
ans(6,3)=1;
ans(6,4)=0;
ans(6,5)=0;
ans(6,6)=0;

ans(7,2)=1;
ans(7,3)=0;
ans(7,4)=1;
ans(7,5)=1;
ans(7,6)=1;

ans(8,2)=1;
ans(8,3)=1;
ans(8,4)=1;
ans(8,5)=0;
ans(8,6)=1;

ans(9,2)=1;
ans(9,3)=1;
ans(9,4)=0;
ans(9,5)=1;
ans(9,6)=1;

ans(10,2)=0;
ans(10,3)=0;
ans(10,4)=1;
ans(10,5)=0;
ans(10,6)=1;

ans(11,2)=1;
ans(11,3)=0;
ans(11,4)=0;
ans(11,5)=1;
ans(11,6)=1;

ans(12,2)=1;
ans(12,3)=1;
ans(12,4)=0;
ans(12,5)=0;
ans(12,6)=1;

ans(13,2)=0;
ans(13,3)=1;
ans(13,4)=1;
ans(13,5)=0;
ans(13,6)=1;

ans(14,2)=1;
ans(14,3)=0;
ans(14,4)=0;
ans(14,5)=0;
ans(14,6)=0;

ans(15,2)=0;
ans(15,3)=1;
ans(15,4)=1;
ans(15,5)=1;
ans(15,6)=0;

ans(16,2)=1;
ans(16,3)=1;
ans(16,4)=1;
ans(16,5)=0;
ans(16,6)=0;

ans(17,2)=0;
ans(17,3)=0;
ans(17,4)=0;
ans(17,5)=1;
ans(17,6)=0;

ans(18,2)=0;
ans(18,3)=1;
ans(18,4)=0;
ans(18,5)=0;
ans(18,6)=0;

ans(19,2)=0;
ans(19,3)=0;
ans(19,4)=1;
ans(19,5)=0;
ans(19,6)=0;

ans(20,2)=0;
ans(20,3)=1;
ans(20,4)=0;
ans(20,5)=1;
ans(20,6)=1;

%disp(ans);

[y x]=size(I);
m=x/7.0;
mod=round(m);

digit1=get(handles.num,'string');
digit=str2num(digit1);

count1=0;
count2=0;
first=1;
last=mod;
temp=zeros(1,7);
var=1;

if(digit>1 && digit<7)
    while(last<=x)
        for i=first:last
           if I(1,i)==0
               count1=count1+1;             
           else
               count2=count2+1;     
           end
        end
        if(count1>count2)
            temp(1,var)=0;
        else
            temp(1,var)=1;
        end
        first=last;
        last=last+mod;
        count1=0;
        count2=0;
        var=var+1;
    end
elseif(digit==7)
    first=x-7*mod;
    last=x-6*mod;
    while(last<=x)
        for i=first:last
           if I(1,i)==0
               count1=count1+1;             
           else
               count2=count2+1;     
           end
        end
        if(count1>count2)
            temp(1,var)=0;
        else
            temp(1,var)=1;
        end
        first=last;
        last=last+mod;
        count1=0;
        count2=0;
        var=var+1;
    end
end
    
if(digit>7 && digit<13)
    while(last<=x)
        for i=first:last
           if I(1,i)==1
               count1=count1+1;             
           else
               count2=count2+1;     
           end
        end
        if(count1>count2)
            temp(1,var)=0;
        else
            temp(1,var)=1;
        end
        first=last;
        last=last+mod;
        count1=0;
        count2=0;
        var=var+1;
    end
elseif(digit==13)
    first=x-7*mod;
    last=x-6*mod;
    while(last<=x)
        for i=first:last
           if I(1,i)==1
               count1=count1+1;             
           else
               count2=count2+1;     
           end
        end
        if(count1>count2)
            temp(1,var)=0;
        else
            temp(1,var)=1;
        end
        first=last;
        last=last+mod;
        count1=0;
        count2=0;
        var=var+1;
    end
end
    
%disp(temp);
r=0;

for p=1:20
    if(r==7)
        break;
    end
    for q=1:7
        if(temp(1,q)==ans(p,q))
            r=r+1;
            if r==7
                no=ans(p,8);
            else
                continue;
            end
        else
            break;
        end
    end
    r=0;
end
set(handles.result,'string',no);



function num_Callback(hObject, eventdata, handles)
% hObject    handle to num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of num as text
%        str2double(get(hObject,'String')) returns contents of num as a double
