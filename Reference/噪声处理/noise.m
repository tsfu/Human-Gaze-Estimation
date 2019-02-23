%% 提取人眼图像的特征，样本特征 30个特征
clc;
clear all;
% str1='C:\训练3\';
str1='E:\test6\eye\';   %  改
str2='.jpg';
str3='E:\人眼5\斑点\'; %  改
str4='E:\人眼5\泊松\';
str5='E:\人眼5\高斯\';
str6='E:\人眼5\椒盐\';
Size=153;                     %  改
for i=1:Size
    I=imread(strcat(str1,num2str(i),str2));
    I_speckle=imnoise(I,'speckle');
    imwrite(I_speckle,strcat(str3,num2str(i),str2)); %斑点
    I_poisson=imnoise(I,'poisson');
    imwrite(I_poisson,strcat(str4,num2str(i),str2)); %泊松
    I_gaussian=imnoise(I,'gaussian');            
    imwrite(I_gaussian,strcat(str5,num2str(i),str2)); %高斯
    I_salt=imnoise(I,'salt & pepper'); 
    imwrite(I_salt,strcat(str6,num2str(i),str2));     %椒盐
end