function [ bw2 ] = pcr_thinned1( bw )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
bw3=uint8(bw);
%figure,imshow(bw3);
%b=double(a);
% if isbw(a) == 0
%     a = im2bw( a ) ;
% end
c=255-bw3;
%figure,imshow(uint8(b));
%title('Original');
%figure,imshow(uint8(c));
%title('Negative');

level = graythresh(c);
d = im2bw(c,level);
%figure,imshow(d);

I = bwmorph(d, 'thin',inf);
%figure,imshow( d ) ;
%figure,imshow( I );

J=bwmorph(I,'dilate');

%I = bwmorph(J, 'thin',3);

I=J;
% [y3 x1]=size(I);
% y1=1;
% %while(y1<y3)
% while (sum(I(y1,:))==0)
%     y1=y1+1;
%     if(y1>y3)
%         break;
%     end
% end
% y2=y1;
% while (sum(I(y2,:))>0)
%     y2=y2+1;
% end
% p=imcrop(I,[1,y1,(x1-1),(y2-y1)]);
% figure,imshow(p);
% 
% [y4 x4]=size(p)
% x5=1;
% x6=1;
% 
% while(x5<x4)
% 
% while (sum(p(:,x5))==0)
%     x5=x5+1;
%     %if(x5>x4)
%      %   break;
%     %end
% end
% x6=x5+10;
% while (sum(p(:,x6))>0)
%     x6=x6+1;
% end
% 
% q=imcrop(p,[x5,1,(x6-x5),(y4-1)]);
% x5=x6;
% figure,imshow(q);
% end

bw2=I;
end

