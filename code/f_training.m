function feature = f_training

num=36; %( 4 9 16 25 36)
numl=5; %( 1 2 4 5 6)
b4=[];
for numl=1:1

str1='C:\Users\lenovo\Desktop\毕设\New\最新采集\人眼\36\';
str2='.jpg';

fea=[];
Size=num;
flong=100;
for i=1:Size
    I=imread(strcat(str1,num2str(i),str2));
    im = rgb2gray(I);
    im = imresize(im, [40, 80]);

    f=HPOG(im, 10, 10, 4, 8, 9,0,'localinterpolate', 'unsigned', 'l2hys');
    fea=[fea f']; 
    feature=fea'; %训练样本总特征
end
