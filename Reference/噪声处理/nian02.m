clc;
clear all;
num=36;
str1=strcat('E:\人眼1\eye',num2str(num),'\');
str2='.jpg';
data=load(strcat('E:\人眼1\',num2str(num),'点.txt'));
ture=load('E:\人眼1\测试.txt');
str3='E:\人眼1\高斯\';     %改的地方
str4='.jpg';
fea=[];
Size=num;
flong=100;
for i=1:Size
    I=imread(strcat(str1,num2str(i),str2));
    im = rgb2gray(I);
    im = imresize(im, [40, 80]);
    f=HPOG(im, 10, 10, 4, 4, 9, 0.5,'localinterpolate', 'unsigned', 'l2hys');
    fea=[fea f'];  %训练样本总特征
end
% [COEFF, SCORE,latent] = princomp(fea');
% % L=fea'*fea;
% % [v d]=eig(L);
% feature=fea'*COEFF(:,1:flong);  % 训练样本
feature=fea';
%%  测试样本

feature1=[];
for i=1:150
    I=imread(strcat(str3,num2str(i),str4));
    im = rgb2gray(I);
    im = imresize(im, [40, 80]);
    f=HPOG(im, 10, 10, 4, 4, 9, 0.5,'localinterpolate', 'unsigned', 'l2hys');
%     f=f*COEFF(:,1:flong);
    feature1=[feature1 f'];  %训练样本总特征
end


b1=[];
K=num;
for i=1:150
    f=feature1(:,i);
    C=(feature-repmat(f',num,1))*(feature-repmat(f',num,1))';
    beta=1/(ones(K,1)'*pinv(C)*ones(K,1));
    w=(C+eye(K,K)*beta*trace(C))\ones(K,1);
    cal=data'*w;
    erro=cal-ture(i,:)';
    a=sum(erro.^2,1);
    a=sqrt(a);
    c=atan(a.*0.027/50);
    b1=[b1 c];   
end
mean(b1)
std(b1)