clear all;
close all;
clc;

stImageFilePath  = 'C:\Users\iair\Desktop\36_Eye\';
stImageSavePath  = 'C:\Users\iair\Desktop\11\';
dirImagePathList = dir(strcat(stImageFilePath,'*.jpg'));        %读取该目录下全部图片的路径（字符串格式）
iImageNum        = length(dirImagePathList);                    %获取图片的总数量
if iImageNum > 0                                                %批量读入图片，进行五官检測，再批量检測
   for i = 1 : iImageNum
      iSaveNum      = int2str(i);
       stImagePath   = dirImagePathList(i).name;
       img = imread(strcat(stImageFilePath,stImagePath)); 
%img=imread('3.jpg');
img1=img;
imshow(img);
[m n]=size(img);
img=double(img);

%%canny边缘检测的前两步相对不复杂，所以我就直接调用系统函数了
%%高斯滤波
w=fspecial('gaussian',[5 5]);
img=imfilter(img,w,'replicate');
figure;
imshow(uint8(img))

%%sobel边缘检测
w=fspecial('sobel');
img_w=imfilter(img,w,'replicate');      %求横边缘
w=w';
img_h=imfilter(img,w,'replicate');      %求竖边缘
img=sqrt(img_w.^2+img_h.^2);        %注意这里不是简单的求平均，而是平方和在开方。我曾经好长一段时间都搞错了
figure;
imshow(uint8(img))

%%下面是非极大抑制
new_edge=zeros(m,n/3);
for i=2:m-1
    for j=2:n/3-1
        Mx=img_w(i,j);
        My=img_h(i,j);
        
        if My~=0
            o=atan(Mx/My);      %边缘的法线弧度
        elseif My==0 && Mx>0
            o=pi/2;
        else
            o=-pi/2;            
        end
        
        %Mx处用My和img进行插值
        adds=get_coords(o);      %边缘像素法线一侧求得的两点坐标，插值需要       
        M1=My*img(i+adds(2),j+adds(1))+(Mx-My)*img(i+adds(4),j+adds(3));   %插值后得到的像素，用此像素和当前像素比较 
        adds=get_coords(o+pi); %边缘法线另一侧求得的两点坐标，插值需要
        M2=My*img(i+adds(2),j+adds(1))+(Mx-My)*img(i+adds(4),j+adds(3));   %另一侧插值得到的像素，同样和当前像素比较
        
        isbigger=(Mx*img(i,j)>M1)*(Mx*img(i,j)>=M2)+(Mx*img(i,j)<M1)*(Mx*img(i,j)<=M2); %如果当前点比两边点都大置1
        
        if isbigger
           new_edge(i,j)=img(i,j); 
        end        
    end
end
figure;
imshow(uint8(new_edge))

%%下面是滞后阈值处理
up=90;     %上阈值
low=90;    %下阈值
set(0,'RecursionLimit',10000);  %设置最大递归深度
for i=1:m
    for j=1:n/3
      if new_edge(i,j)>up &&new_edge(i,j)~=255  %判断上阈值
            new_edge(i,j)=255;
            new_edge=connect(new_edge,i,j,low);
      end
    end
end
%se = [1,1,1;1,1,1;1,1,1];
se = strel('disk',3);
new_edge=imdilate(new_edge,se);
new_edge=im2bw(uint8(new_edge),0.6);
new_edge= bwareaopen(new_edge,100);
new_edge=im2uint8(new_edge);
figure;imshow(new_edge);hold on;


new_edge=im2bw(new_edge);
status=regionprops(new_edge,'BoundingBox');
figure;imshow(img1);hold on;
%rectangle('position',status(1).BoundingBox,'edgecolor','r');
[r, c]=find(new_edge==1);
[rectx,recty,area,perimeter] = minboundrect(c,r,'p'); 
line(rectx(:),recty(:),'color','g');
img2=imcrop(img1,status(1).BoundingBox);
%imwrite(img2,'C:\Users\iair\Desktop\1.jpg');

imwrite(img2,strcat(stImageSavePath,iSaveNum,'.jpg')); 
   end
end

%figure;
%imshow(new_edge==255)