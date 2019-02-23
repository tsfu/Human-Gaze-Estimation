
%%

feature=[];    %初始化
feature1=[];
num=9; %( 4 9 16 25 36)
numl=5; %( 1 2 4 5 6)
b4=[];

for numl=1:1

feature=f_training; %提取训练集特征
feature1=f_testing; %提取测试样本特征

b1=[];
sigma = 0.2410; %直接指定sigma
b1= GetC( feature,feature1, sigma );   %基于相关熵计算权值

end
%%
mean(b1)
std(b1)




