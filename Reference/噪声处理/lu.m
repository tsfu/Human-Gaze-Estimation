clc;
clear all;
path(path, './Optimization');
num=36;
str1=strcat('E:\人眼1\eye',num2str(num),'\');
str2='.jpg';
data=load(strcat('E:\人眼1\',num2str(num),'点.txt'));
ture=load('E:\人眼1\测试.txt');
str3='E:\人眼1\斑点\';     %改的地方
str4='.jpg';
fea=[];
Size=num;
flong=400;
for i=1:Size
    I=imread(strcat(str1,num2str(i),str2));
   
    im = imresize(I, [40, 80]);
    f=getfea(im);
    fea=[fea f];  %训练样本总特征
end

feature1=[];
for i=1:150
    I=imread(strcat(str3,num2str(i),str4));
    
    im = imresize(I, [40, 80]);
    f=getfea(im);
%     f=f*COEFF(:,1:flong);
    feature1=[feature1 f];  %训练样本总特征
end


b1=[];
for i=1:150
%      b1=[];
     f=feature1(:,i);
%     x0 = (fea'*fea)\(fea'*f);
     x0 = (fea'*f);
    epsilon=0.09;
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
