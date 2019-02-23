x=[7.5 ; 6.1 ;  6.2 ;  7.2 ; 7.8 ;6.3   ];
e=[0.8;   1. ; 1.1  ; 1. ;  1.2; 1.5  ];
gpname = {['Muti-CNN'],['RF'],['KNN'],['ALR'],['SVR']} ;
% leg={['36'],['25'],['16'],['9'],['4']}; %legend锟斤拷图锟斤拷
h = barwitherr(e, x);% Plot with errorbars
set(gca,'XTickLabel',{'Ours','Muti-CNN','RF','KNN','ALR','SVR'})
% legend('本文方法','Muti-CNN','RF','KNN','ALR','SVR');
 ylabel('注视点平均误差（度）')
 xlabel('MPIIGaze数据集')
 set(gca,'FontSize',12)

% x=[ 0.08 0.09 0.35 1.07 0.26;
%     0.08 0.09 0.35 1.07 0.25;
%     0.08 0.09 0.33 1.09 0.25;
%     0.08 0.09 0.35 1.07 0.25
% ];
% e=[0.05 0.06 0.25 0.24 0.14;
%     0.05 0.06 0.24 0.23 0.14;
%     0.05 0.06 0.25 0.23 0.14;
%     0.05 0.06 0.25 0.25 0.14];
% 
% h = barwitherr(e, x);% Plot with errorbars
% set(gca,'XTickLabel',{'50%','30%','20%','10%'})
% legend('LCER','CESR','ALR','Local region','HOG+SVR');
% ylabel('Estimation Error(degree)')
% xlabel('Down Rate')
% set(gca,'FontSize',12)
figure;
a=[5.9  6.1   6.2   7.2  7.8 6.3];
 b=diag(a);
 c=bar(b,'stack');
color=[0 0 0.75;0 1 0;1 0.5 0];
for i=1:3
set(c(i),'FaceColor',color(i,:));
end
H=legend('本文方法','Muti-CNN','RF','KNN','ALR','SVR');
set(H,'Orientation','horizon');
set(gca,'XTickLabel',{'Ours','Muti-CNN','RF','KNN','ALR','SVR'})
set(H,'FontSize',6)