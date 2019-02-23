
%%

clc;
clear all;
num=36; %( 4 9 16 25 36)
numl=5; %( 1 2 4 5 6)
b4=[];
for numl=1:1
%str1=strcat('E:\test',num2str(numl),'\eye',num2str(num),'\');
%str2='.jpg';
%str3=strcat('E:\test',num2str(numl),'\eye','\');
%str4='.jpg';
%data=load(strcat('E:\test',num2str(numl),'\',num2str(num),'点.txt'));
%ture=load(strcat('E:\test',num2str(numl),'\','测试.txt'));

str1=strcat('C:\Users\iair\Desktop\11\',num2str(numl));
str2='.jpg';
str3=strcat('C:\Users\iair\Desktop\11\',num2str(numl));
str4='.jpg';
data=load(strcat('C:\Users\iair\Desktop\11\36点.txt'));
ture=load(strcat('C:\Users\iair\Desktop\11\36点.txt'));

fea=[];
Size=num;
flong=100;
for i=1:Size
    I=imread(strcat(str1,str2));
    im = rgb2gray(I);
    im = imresize(im, [40, 80]);

    f=HPOG(im, 10, 10, 4, 8, 9,0,'localinterpolate', 'unsigned', 'l2hys');
    fea=[fea f'];  %训练样本总特征
end
% [COEFF, SCORE,latent] = princomp(fea');
% % L=fea'*fea;
% % [v d]=eig(L);
% feature=fea'*COEFF(:,1:flong);  % 训练样本
feature=fea';
%%  测试样本

feature1=[];
for i=1:30
    I=imread(strcat(str3,str4));
    im = rgb2gray(I);
    im = imresize(im, [40, 80]);
    f=HPOG(im, 10, 10, 4, 8, 9, 0,'localinterpolate', 'unsigned', 'l2hys');
%     f=f*COEFF(:,1:flong);
    feature1=[feature1 f'];  %训练样本总特征
end


b1=[];
sigma = 1.0;
for i=1:30
    f=feature1(:,i);
      W = SimilarityMatrix( feature' , f , sigma ) ;  %求w  之间的距离关系
       [w w1] = CESR(feature',f,W);
%      W = SimilarityMatrix( feature' , f , sigma ) ;  %求w  之间的距离关系
%      [w] = WCESR(feature',f,W);
%      w(find(abs(w)<0.1))=0;
     w=w/sum(w);
    cal=data'*w;   
    erro=cal-ture(i,:)';   
    a=sum(erro.^2,1);
    a=sqrt(a);
    c=atan(a.*0.027/60);
    b1=[b1 c];    
end
b4=[b4;b1];

end
%%
% mean(b1)
% std(b1)
mean(b4)
std(b4)



