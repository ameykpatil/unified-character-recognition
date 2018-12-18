function [ z ] = pcr_extracrop( w1 )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
[x20,y20]=size(w1);
temp(:,:)=zeros(x20+2,y20+2);

for i=1:(x20+2)
    for j=1:(y20+2)
        if(i==1 || i==(x20+2) || j==1 || j==(y20+2) )
            temp(i,j)=0;
        else
            temp(i,j)= w1(i-1,j-1);
        end
    end
end

[x30,y30]=size(temp);
for i=2:x30-1
    for j=2:y30-1
        if(temp(i-1,j-1)+temp(i-1,j)+temp(i-1,j+1)+temp(i,j-1)+temp(i,j)+temp(i,j+1)+temp(i+1,j-1)+temp(i+1,j)+temp(i+1,j+1)<=0)
            temp(i,j)=0;
        end
    end
end
%cropping starts
q=temp;
[y2temp x2temp] = size(q);
x1=1;
y1=1;
x2=x2temp;
y2=y2temp;

% Finding left side blank spaces
cntB=1;
while (sum(q(:,cntB))==0)
    x1=x1+1;
    cntB=cntB+1;
end

% Finding upper side blank spaces
cntB=1;
while (sum(q(cntB,:))==0)
    y1=y1+1;
    cntB=cntB+1;
end

% Finding right side blank spaces
cntB=x2temp;
while (sum(q(:,cntB))==0)
    x2=x2-1;
    cntB=cntB-1;
end

% Finding lower side blank spaces
cntB=y2temp;
while (sum(q(cntB,:))==0)
    y2=y2-1;
    cntB=cntB-1;
end

% Crop the image to the edge
z=imcrop(q,[x1,y1,(x2-x1),(y2-y1)]);
% w1=uint8(w);
% w2=255-w1;
% level=graythresh(w2);
% w3=im2bw(w2,level);
% w4=bwmorph(w3,'fill');
% figure,imshow(w4);
% w5=uint8(w4);
% w6=255-w5;
% level=graythresh(w6);
% w7=im2bw(w6,level);
% z=w7;
end