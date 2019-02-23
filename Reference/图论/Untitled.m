clc;
clear all;
num=25;
str1=strcat('E:\test1\eye',num2str(num),'\');
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
z=feature(:,3)';
x=feature(:,1)';
y=feature(:,2)';
[X,Y]=meshgrid(min(x)-0.5:(max(x)-min(x))/300:max(x)+0.5,min(y)-0.5:(max(y)-min(y))/300:max(y)+0.5);
Z=griddata(x,y,z,X,Y);
surf(X,Y,Z)
hold on
% xR=[10,50];%设置x范围
% yR=[40,50];%设置y范围
% z1=Z.*(X>=xR(1)&X<=xR(2))&(Y>=yR(1)&Y<=yR(2));%为取出设定范围数据重新赋值而得到逻辑数组
% z2=Z;%为不覆盖原始Z，新建变量
% z2(z1(:)==1)=-5;%设定范围改为蓝色
% mesh(X,Y,Z)
% hold on;
% INDEX = [ones(25,1); ones(25,1)+1; ones(25,1)+2 ];
% color_1 = [1 0.2 0.4];
% color_2 = [0.34 0.65 0.87];
% color_3 = [0.5 0.5 0.5];
% 
% cmap = [color_1; color_2; color_3];
% 
% INDEX_color = cmap(INDEX,:);
%%
plot3(feature(:,1),feature(:,2),feature(:,3),'b.');
grid on;
% % 
% % hold on;
% % scatter3(feature(:,1),feature(:,2),feature(:,3),10,c);
% shading interp;
% % colormapeditor;
% figure(2);
% meshgrid(feature(:,1)',feature(:,2)',feature(:,3)');

% view(v1,v2); axis('equal'); axis('off');