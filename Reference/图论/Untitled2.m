clc;
clear all;
num=25;
str1=strcat('E:\test1\eye',num2str(num),'\');
str2='.jpg';
fea=[];
Size=num;
flong=3;
for i=5:5
    I=imread(strcat(str1,num2str(i),str2));
    im = rgb2gray(I);
    im = imresize(im, [80, 40]);
    f=HPOG(im, 10, 10, 4, 4, 9, 0.5,'localinterpolate', 'unsigned', 'l2hys');
    fea=[fea f'];  %训练样本总特征
end
 %% 
 imhist(fea,9)


