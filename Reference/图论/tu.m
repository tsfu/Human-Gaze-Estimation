clc;
clear all;
num=25;
str1=strcat('E:\test3\eye',num2str(num),'\');
str2='.jpg';
fea=[];
Size=num;
flong=3;
for i=1:Size
    I=imread(strcat(str1,num2str(i),str2));
    im = rgb2gray(I);
    im = imresize(im, [40, 80]);
    f=HPOG(im, 10, 10, 4, 8, 9, 0.5,'localinterpolate', 'unsigned', 'l2hys');
    fea=[fea f'];  %训练样本总特征
end
[COEFF, SCORE,latent] = princomp(fea');
% % L=fea'*fea;
% % [v d]=eig(L);
feature=fea'*COEFF(:,1:flong);  % 训练样本
% feature=fea';
%% 
% ms = 50;
% lw = 1.5;
% v1 = -15; v2 = 20;
% c =randint(1,36,6)+1;
% % c=feature(:,3)+1;
% scatter3(feature(:,1),feature(:,2),feature(:,3),10);
% grid on;
% caxis([1,5]);
%% 

x=feature(:,1)';
y=feature(:,2)';
z=feature(:,3)';

%%
% figure
xx=[120 120 120 120 120 250 250 250 250 250 100 100 100 100 100 60 60 60 60 60 160 160 160 160 160];
[X,Y,Z]=griddata(x,y,z,linspace(min(x),max(x),80)',linspace(min(y),max(y),80),'v4');%插值
% pcolor(X,Y,Z);shading interp%伪彩色图
% figure,contourf(X,Y,Z) %等高线图
figure,surf(X,Y,Z);%三维曲面
hold on;
scatter3(x,y,z,repmat(20,numel(x),1),xx,'filled','MarkerSize',0.5)%散点图
axis off;