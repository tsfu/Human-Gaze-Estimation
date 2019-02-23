
%%

clc;
clear all;
num=9; %( 4 9 16 25 36)
numl=5; %( 1 2 4 5 6)
b4=[];
for numl=1:1
feature=f_training; %提取训练集特征
feature1=f_testing; %提取测试样本特征

s=[];
ff=[];
b1=[];
ft0=0.20;
for k = 1:-0.010:-10
    sigma = exp(k)/2;   
    s=[s sigma];

%入口，参数feature1，sigma'
b1= GetC(feature,feature1,sigma);
%出口输出b向量  

ft=std(b1);
ff=[ff ft];

if ft0>ft
    ft0=ft;
    count=0;
    sigma_flag=sigma;
    ft0_flag=ft0;
else
    count=count+1;
    if  ft-ft0>=0.03 
        break;
    end
end
end
plot(s,ff,'ro-')
xlabel('核带宽δ')
ylabel('误差 std')

end
%%
% mean(b1)
% std(b1)

ft0_flag
sigma_flag




