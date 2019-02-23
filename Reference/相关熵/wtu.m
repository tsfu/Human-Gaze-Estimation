load w.mat
% w(find(abs(w)<0.01))=0;
w(:)=0;
figure(1)
w(13)=0.08;
w(14)=0.15;
w(15)=0.12;
w(20)=0.29;
w(21)=0.21;
w(25)=0.1;
w(26)=0.14;
w(27)=0.6;
plot(w,'-rp');
% xlabel('samples')
ylabel('Value of w')
figure(2)
plot(data(:,1),data(:,2),'k.','LineWidth',60,'MarkerSize',15)
hold on;
% plot(650,435,'b+');
% hold on;
% plot(648,478,'r*','MarkerSize',15)

hold on;
% plot(180,108,'b+');
% plot([data(4,1) 648],[data(4,2) 478],'g--')
% 
% plot([data(8,1) 648],[data(8,2) 478],'g--')
% plot([data(9,1) 648],[data(9,2) 478],'g--')
% plot([data(10,1) 648],[data(10,2) 478],'g--')
% 
% plot([data(16,1) 648],[data(16,2) 478],'g--')
% 
% plot([data(21,1) 648],[data(21,2) 478],'g--')
% plot([data(22,1) 648],[data(22,2) 478],'g--')
% plot([data(23,1) 648],[data(23,2) 478],'g--')
% 
% 
% plot([data(34,1) 648],[data(34,2) 478],'g--')
% plot([data(32,1) 648],[data(32,2) 478],'g--')
% plot([data(33,1) 648],[data(33,2) 478],'g--')
% plot([data(20,1) 450],[data(20,2) 510],'g--')
% plot([data(13,1) 450],[data(13,2) 510],'g--')
% plot([data(14,1) 450],[data(14,2) 510],'g--')
% plot([data(15,1) 450],[data(15,2) 510],'g--')
% % plot([data(7,1) 450],[data(7,2) 510],'g--')
% plot([data(21,1) 450],[data(21,2) 510],'g--')
% plot([data(25,1) 450],[data(25,2) 510],'g--')
% plot([data(26,1) 450],[data(26,2) 510],'g--')
% plot([data(27,1) 450],[data(27,2) 510],'g--')
% plot([data(15,1) 450],[data(15,2) 510],'g--')
% plot([data(7,1) 450],[data(7,2) 510],'g--')
plot([data(13,1) 450],[data(13,2) 510],'g--')
plot([data(7,1) 450],[data(7,2) 510],'g--')
% plot([data(14,1) 450],[data(14,2) 510],'g--')
plot([data(15,1) 450],[data(15,2) 510],'g--')
plot([data(21,1) 450],[data(21,2) 510],'g--')
plot([data(25,1) 450],[data(25,2) 510],'g--')
plot([data(26,1) 450],[data(26,2) 510],'g--')
% plot([data(27,1) 450],[data(27,2) 510],'g--')

plot(450,510,'b*','LineWidth',1,'MarkerSize',6);
% plot(200,310,'r.','MarkerSize',10);
% plot(190,330,'b.','MarkerSize',8);
% plot(180,350,'r*','MarkerSize',6);
% plot(109,64,'b+','LineWidth',60,'MarkerSize',5);
% plot(125,75,'b+','LineWidth',60,'MarkerSize',5)