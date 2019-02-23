function feature1 = f_testing

num=25; %( 4 9 16 25 36)
numl=5; %( 1 2 4 5 6)
b4=[];
for numl=1:1

str3='C:\Users\lenovo\Desktop\毕设\New\最新采集\人眼\测试\';
str4='.jpg';

fea=[];
Size=num;
flong=100;

feature1=[];
for i=1:36
    I=imread(strcat(str3,num2str(i),str4));
    im = rgb2gray(I);
    im = imresize(im, [40, 80]);
    f=HPOG(im, 10, 10, 4, 8, 9, 0,'localinterpolate', 'unsigned', 'l2hys');
%     f=f*COEFF(:,1:flong);
    feature1=[feature1 f'];  %测试样本总特征
end