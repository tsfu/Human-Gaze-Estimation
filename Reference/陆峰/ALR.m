clc;
clear all;
path(path, './Optimization');
num=36; %（4，9，16，25，36）
numl=5; %( 1 2 4 5 6)
%str1=strcat('E:\test',num2str(numl),'\eye',num2str(num),'\');
%str2='.jpg';
%%str3=strcat('E:\test',num2str(numl),'\eye','\');
%str4='.jpg';
%data=load(strcat('E:\test',num2str(numl),'\',num2str(num),'点.txt'));
%ture=load(strcat('E:\test',num2str(numl),'\','测试.txt'));

str1='C:\Users\lenovo\Desktop\毕设\New\图片提取\36_Eye_Cutiqu\';
str2='.jpg';
str3='C:\Users\lenovo\Desktop\毕设\New\采集数据\测试集采集\';
str4='.jpg';
data=load(strcat('C:\Users\lenovo\Desktop\毕设\New\注视点坐标','\',num2str(num),'点.txt'));
ture=load(strcat('C:\Users\lenovo\Desktop\毕设\New\注视点坐标','\','测试.txt'));

fea=[];
Size=num;
flong=100;
for i=1:Size
    I=imread(strcat(str1,num2str(i),str2));
    %imshow(I);
    im = imresize(I, [40, 80]);
    imshow(im);
    f=getfea(im);
    fea=[fea f];  %训练样本总特征
end

%%  测试样本

feature1=[];
for i=1:25
    I=imread(strcat(str3,num2str(i),str4)); 
    im = imresize(I, [40, 80]);
    f=getfea(im);
%     imshow(im);
%     f=f*COEFF(:,1:flong);
    feature1=[feature1 f];  %测试样本总特征
end

b1=[];
sigma = 0.5;
b1=[];
b=[];
for i=1:1
%      b1=[];
     f=feature1(:,i);
%     x0 = (fea'*fea)\(fea'*f);
     x0 = (fea'*f);
    epsilon=0.12;
    w = l1qc_logbarrier(x0, fea, [], f, epsilon, 1e-3);
    cal=data'*w;
    erro=cal-ture(i,:)';
    a=sum(erro.^2,1);
    a=sqrt(a);
    c=atan(a.*0.027/50);
    b1=[b1 c]; 
end
mean(b1)
std(b1)
