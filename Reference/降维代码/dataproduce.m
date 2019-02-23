clc;
clear all;
a=[23.69 52.118 80.546 108.974 137.402 165.83];
b=[14.805 44.415 74.025 103.635 133.245 162.855];
d1=[ones(6,1)*a(1)' b'];
data=[];
for i=1:6
    data=[data;ones(6,1)*a(i)' b'];
end
% for i=1:36   
%     plot(data(i,1),data(i,2),'*');
%     hold on; 
% end
sigma = 6;
for i=1:size(data,1)    
    for j=1:size(data,1)
        dist = sqrt((data(i,1) - data(j,1))^2 + (data(i,2) - data(j,2))^2); 
        affinity(i,j) = exp(-dist/(2*sigma^2));
    end
end

for i=1:size(data,1) 
    affinity(i,i)=0;
end
sdata=zeros(size(data,1),size(data,1));
for i=1:size(data,1)
    for j=1:size(data,1)
        sdata(i,j)=affinity(i,j)/sum(affinity(i,:),2);
    end
end
% for i=1:size(data,1)
%     for j=1:i
%         sdata(j,i)=sdata(i,j);
%     end
% end
for i=1:size(data,1)
    sdata(i,i)=0;
end
figure,imagesc(sdata),colorbar,title('Affinity Matrix');

