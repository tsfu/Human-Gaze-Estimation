clc;
clear all;
data=textread('36µã.txt');
% set the parameters
sigma = 20;
for i=1:size(data,1)    
    for j=1:size(data,1)
        dist = sqrt((data(i,1) - data(j,1))^2 + (data(i,2) - data(j,2))^2); 
        affinity(i,j) = exp(-dist/(2*sigma^2));
    end
end

for i=1:size(data,1) 
    affinity(i,i)=0;
end
save gdata.mat affinity
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
% X=data;
% mapping.mean = mean(X, 1);
% X = bsxfun(@minus, X, mapping.mean);
% [n, d] = size(X);
% D = zeros(n, n);
% for i=1:n
%     diffX = bsxfun(@minus, X(i,:), X(i + 1:end,:));
%     dist = sum((diffX ) .* diffX, 2);
%     D(i + 1:end, i) = dist;
%     D(i, i + 1:end) = dist';
% end
% %%
% sigma = 800000;
% Q = exp(-D/sigma);
% Q(1:n+1:end) = 0;
% Q = bsxfun(@rdivide, Q, sum(Q, 2));
% Q = max(Q, realmin);
% 
% figure,imagesc(Q),colorbar,title('Affinity Matrix');

% save gdata.mat sdata
% figure,imagesc(Q),colorbar,title('Affinity Matrix');