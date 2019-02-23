clc;
clear all;
num=25; %( 4 9 16 25 36)
numl=5; %( 1 2 4 5 6)
addpath(genpath(pwd));
b4=[];
for numl=1:5
    str1=strcat('E:\test',num2str(numl),'\eye',num2str(num),'\');
    str2='.jpg';
    str3=strcat('E:\test',num2str(numl),'\eye','\');
    str4='.jpg';
    data=load(strcat('E:\test',num2str(numl),'\',num2str(num),'点.txt'));
    ture=load(strcat('E:\test',num2str(numl),'\','测试.txt'));
    fea=[];
    Size=num;
    flong=100;
    for i=1:Size
        I=imread(strcat(str1,num2str(i),str2));
        im = rgb2gray(I);
        im = imresize(im, [40, 80]);
        f=HPOG(im, 10, 10, 4, 8, 9,0,'localinterpolate', 'unsigned', 'l2hys');
        fea=[fea f'];  %训练样本总特征
    end
    % [COEFF, SCORE,latent] = princomp(fea');
    % % L=fea'*fea;
    % % [v d]=eig(L);
    % feature=fea'*COEFF(:,1:flong);  % 训练样本
    feature=fea;
    %%  测试样本
    
    feature1=[];
    for i=1:150
        I=imread(strcat(str3,num2str(i),str4));
        im = rgb2gray(I);
        im = imresize(im, [40, 80]);
        f=HPOG(im, 10, 10, 4, 8, 9, 0,'localinterpolate', 'unsigned', 'l2hys');
        %     f=f*COEFF(:,1:flong);
        feature1=[feature1 f'];  %训练样本总特征
    end
    X=feature;
    %%
    b1=[];
    mean_x=mean(X,2);
    for i=1:150
        y=feature1(:,i);
        w=WCORR(X,y,mean_x);
        %     w=CRFS(feature,f,lamda);
        cal=data'*w;
        erro=cal-ture(i,:)';
        a=sum(erro.^2,1);
        a=sqrt(a);
        c=atan(a.*0.027/50);
        b1=[b1 c];
    end
   b4=[b4;b1];
    
    
    
    
end
mean(sum(b4)/5)