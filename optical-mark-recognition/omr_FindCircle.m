function[p]=omr_FindCircle(I)

%I=uint8(imread('omr-img5.jpg'));
%figure,imshow(I);

% Ostu's rule is used for thresholding you can give your own threshold if
% resuls are not satisfactory.
level = graythresh(I);
BW = im2bw(I,level);
%figure,imshow(BW);

%removal of small objects
%P=500;
%BW2 = bwareaopen(BW,P);
%figure,imshow(BW2);

BW3 = bwmorph(BW,'dilate');
%figure,imshow(BW3);

BW4 = bwmorph(BW3,'fill');
%figure,imshow(BW4);

BW5 = bwmorph(BW4,'majority');
%figure, imshow(BW5);

%[I2,center]=Hughcir(BW4);
%figure,imshow(I2);
v=1;
sm=0;
d=zeros(500,2);
%b=double(BW5);
[m,n,p]=size(BW5);
%disp(m);
%disp(n);
%e(:,:,1)=zeros(m,n);
%e(:,:,2)=zeros(m,n);
%e(:,:,3)=zeros(m,n);
e(:,:)=zeros(m,n);
for i=3:m-2
    for j=3:n-2
        if BW5(i,j)==0
            %disp('hi');
            sm=0;
            for x=-2:2
                for y=-2:2
                    sm=sm+uint8(BW5(i+x,j+y));
                end
            end
            if sm==0
                %disp('got');
                d(v,1)=i;
                d(v,2)=j;
                e(i,j)=255;
                v=v+1;
            end
        end
    end
end
%figure, imshow(e);
%disp(d);
%disp(size(d));
f=zeros(100,2);
f(1,1)=d(1,1);
f(1,2)=d(1,2);
x=1;
for i=2:m
    if(d(i,1)==0 && d(i,2)==0)
        break;
    end
    flg=0;
    for k=1:x
        if(((d(i,1)-f(k,1))^2+(d(i,2)-f(k,2))^2)<36)
            flg=1;
            break;
        end
    end
    if(flg==0)
        x=x+1;
        f(x,1)=d(i,1);
        f(x,2)=d(i,2);
    end    
end
%disp(f);
g=zeros(x,2);
y=1;
for i=1:x
    q=int8(f(i,1)*10/310);
    r=22+(q-1)*31;
    s=ceil(f(i,2)*5/490);
    g(y,1)=(s-1)*10+q;
    l=40+(s-1)*97;
    h=l+50;
    opt=int8((f(i,2)-l)*3/(h-l))+1;
    g(y,2)=opt;
    y=y+1;
end
%disp(g);

t=zeros(50,2);
for i=1:50
    t(i,1)=i;
end
for i=1:x
    u=g(i,1);
    t(u,2)=g(i,2);
end
%disp(t);

fid1=fopen('ans.txt','w+');
for i=1:50
    dataline=[num2str(t(i,1)),'-',num2str(t(i,2))];
    fprintf(fid1,dataline,'\n');
end

unattempted=0;
correct=0;
incorrect=0;
fid2=fopen('soln.txt');
%line1=fileread(fid2);
%disp(line1);
for z=1:50
    line=fgetl(fid2);
    %disp(line);
    m=str2num(line);
    %disp(m);
    if(t(z,2)== m)
        correct=correct+1;
    elseif(t(z,2)== 0)
        unattempted=unattempted+1;
    else
        incorrect=incorrect+1;
    end
end
%disp(unattempted);
%disp(correct);
%disp(incorrect);
fclose(fid1);
fclose(fid2);
p(1)=unattempted;
p(2)=correct;
p(3)=incorrect;
%disp(p);