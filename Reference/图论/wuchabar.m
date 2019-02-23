a_live =[3.62 ;  4.83 ; 5.24  ; 5.63 ;  6.03 ; 4.52 ];

a = [a_live];
c=bar(a, 'stack')
% ch = get(b,'children');
% set(c(1),'FaceColor','g');
% set(c(2),'FaceColor','r')
% set(ch,'FaceVertexCData',[0 0 1;0 1 1;1 1 0;1 1 0;1 1 0;1 1 0])
set(gca,'YLim', [0.5,7], 'XTickLabel',{'本文结构+SVR','本文结构','Pixel+SVR','Random forest','Muti-CNN','Muti-CNN+SVR'}, 'FontSize', 7.5);
ylabel('注视点平均误差（度）','FontSize', 15);
title('全部样本','FontSize', 15)
% ch = get(fx,'children');
% set(gca,'XTickLabel',{'conditon 1','condition 2''condition 3'})
% % set(fx(1), 'FaceColor',[1 0.6 0.8]);% Pink
% set(fx(2), 'FaceColor',[0 1 0]); % Green

% set(gca, 'Ytick', [0.5:0.05:5], 'ygrid','on','GridLineStyle','-');
%=  legend('本文结构+SVR','本文结构','Pixel+SVR','Random forest','Muti-CNN','Muti-CNN+SVR');
% legend('boxoff');
e = [0 0 0 0 0 0];
% hold on
% numgroups = size(a, 1); 
% numbars = size(a, 2); 
% groupwidth = min(0.8, numbars/(numbars+1.5));
% for i = 1:numbars
%       % Based on barweb.m by Bolu Ajiboye from MATLAB File Exchange
%       x = (1:numgroups) - groupwidth/2 + (2*i-1) * groupwidth / (2*numbars);  % Aligning error bar with individual bar
%       errorbar(x, a(:,i), e(:,i), 'k', 'linestyle', 'none', 'lineWidth', 1);
% end