clc;
clear all;
num=36;
str1=strcat('E:\人眼5\eye',num2str(num),'\');
str2='.jpg';
data=load(strcat('E:\人眼5\',num2str(num),'点.txt'));
ture=load('E:\人眼5\测试.txt');
str3='E:\人眼5\斑点\';     %改的地方
str4='.jpg';
fea=[];
Size=num;
flong=100;
for i=1:Size
    I=imread(strcat(str1,num2str(i),str2));
    im = rgb2gray(I);
    im = imresize(im, [80,120]);
    f=HPOG(im,30,40,4,2,9,0.5,'localinterpolate', 'unsigned', 'l2hys');
    f1=HPOG(im,15,40,8,2,9,0.5,'localinterpolate', 'unsigned', 'l2hys');
    f2=HPOG(im,15,20,8,4,9,0.5,'localinterpolate', 'unsigned', 'l2hys');
    f3=HPOG(im,12,10,10,8,9,0.5,'localinterpolate', 'unsigned', 'l2hys');
    fea=[fea;f f1 f2 f3];  %训练样本总特征
end

feature1=[];
for i=1:150
    I=imread(strcat(str3,num2str(i),str4));
    im = rgb2gray(I);
    im = imresize(im, [80, 120]);
    f=HPOG(im,30,40,4,2,9,0.5,'localinterpolate', 'unsigned', 'l2hys');
    f1=HPOG(im,15,40,8,2,9,0.5,'localinterpolate', 'unsigned', 'l2hys');
    f2=HPOG(im,15,20,8,4,9,0.5,'localinterpolate', 'unsigned', 'l2hys');
    f3=HPOG(im,12,10,10,8,9,0.5,'localinterpolate', 'unsigned', 'l2hys');
    feature1=[feature1;f f1 f2 f3];  %训练样本总特征
end
%%  svm  进行回归
% 寻找最佳c参数/g参数
Predict=[];
for k=1:2
[c,g] = meshgrid(-10:0.5:10,-10:0.5:10);
[m,n] = size(c);
cg = zeros(m,n);
eps = 10^(-4);
v = 5;
bestc = 0;
bestg = 0;
error = Inf;
for i = 1:m
    for j = 1:n
        cmd = ['-v ',num2str(v),' -t 2',' -c ',num2str(2^c(i,j)),' -g ',num2str(2^g(i,j) ),' -s 3 -p 0.1'];
        cg(i,j) = svmtrain(data(:,k),fea,cmd);
        if cg(i,j) < error
            error = cg(i,j);
            bestc = 2^c(i,j);
            bestg = 2^g(i,j);
        end
        if abs(cg(i,j) - error) <= eps && bestc > 2^c(i,j)
            error = cg(i,j);
            bestc = 2^c(i,j);
            bestg = 2^g(i,j);
        end
    end
end
% 创建/训练SVM  
cmd = [' -t 2',' -c ',num2str(bestc),' -g ',num2str(bestg),' -s 3 -p 0.01'];
model = svmtrain(data(:,k),fea,cmd);
%  进行测试
a=ture(1:150,k);
[Predict1,error_2] = svmpredict(a,feature1,model);
Predict=[Predict;Predict1];
end 
%%  预测角度
b1=[];
for i=1:150
    erro=Predict(i,:)-ture(i,:);   
    a=sum(erro.^2,2);
    a=sqrt(a);
    c=atan(a.*0.027/50);
    b1=[b1 c];    
end

mean(b1)
std(b1)
