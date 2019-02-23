clc;
clear all;
%%  人眼特征数据
file=dir('C:\Users\iair\Desktop\11\*.jpg');
[k len]=size(file);
feature=[];
dircell=struct2cell(file) ;
da=[];
name1=file.name;
for i=1:k
   d=dircell{1,i};
str=strcat('C:\Users\iair\Desktop\11\',num2str(i),'.jpg');
    I=imread(str);
    f=getfea(I);
    feature=[feature f];
end
data=feature';
sigma = 0.15;
for i=1:size(data,1)    
    for j=1:size(data,1)
        dist = sqrt((data(i,:) - data(j,:))*(data(i,:) - data(j,:))' ); 
        affinity(i,j) = exp(-dist/(2*sigma^2));
    end
end

for i=1:size(data,1) 
    affinity(i,i)=0;
end
Edata=zeros(size(data,1),size(data,1));
for i=1:size(data,1)
    for j=1:size(data,1)
        Edata(i,j)=affinity(i,j)/sum(affinity(i,:),2);
    end
end
% for i=1:size(data,1)
%     for j=1:i
%         sdata(j,i)=sdata(i,j);
%     end
% end
% sdata=sdata-0.0084;
for i=1:size(data,1)
    Edata(i,i)=0;
end
%  save fdata.mat sdata
figure,imagesc(Edata),
% colorbar,
title('人眼特征空间');
imwrite(Edata,'11.jpg','jpg');
%%  注视点坐标数据
% a=[23.69 52.118 80.546 108.974 137.402 165.83];
% b=[14.805 44.415 74.025 103.635 133.245 162.855];
% d1=[ones(6,1)*a(1)' b'];
% data=[];
% for i=1:6
%     data=[data;ones(6,1)*a(i)' b'];
% end
data=textread('36点.txt');
% for i=1:36   
%     plot(data(i,1),data(i,2),'*');
%     hold on; 
% end
sigma = 15.5;
for i=1:size(data,1)    
    for j=1:size(data,1)
        dist = sqrt((data(i,1) - data(j,1))^2 + (data(i,2) - data(j,2))^2); 
        affinity(i,j) = exp(-dist/(2*sigma^2));
    end
end

for i=1:size(data,1) 
    affinity(i,i)=0;
end
Gdata=zeros(size(data,1),size(data,1));
for i=1:size(data,1)
    for j=1:size(data,1)
        Gdata(i,j)=affinity(i,j)/sum(affinity(i,:),2);
    end
end
% for i=1:size(data,1)
%     for j=1:i
%         sdata(j,i)=sdata(i,j);
%     end
% end
for i=1:size(data,1)
    Gdata(i,i)=0;
end
figure,
imagesc(Gdata),
% colorbar,
title('注视点空间');
%%  核心算法
[n, d] = size(feature');
max_iter = 25;
% Initialize solution
A = randn(d, d) * .0001;
A = (A + A') + eye(d);
iter = 0;
converged = false;

P=Gdata;
X=feature';
while iter < max_iter && ~converged
    
    % Perform gradient step
    iter = iter + 1;
    disp(['Iteration ' num2str(iter) '...']);
    [A, f] = minimize(A(:), 'mcml_grad', 5, X, P);
    A = reshape(A, [d d]);
    if isempty(f) || f(end) - f(1) > -1e-3
        disp('Converged!');
        converged = true;
    end
    
    % Project A back onto the cone of PSD matrices
    [vec, val] = eig(A);
    val = diag(val);
    ind = find(val > 0);
    A = real(bsxfun(@times, val(ind)', vec(:,ind)) * vec(:,ind)');
end

D = zeros(n, n);
for i=1:n
    diffX = bsxfun(@minus, X(i,:), X(i + 1:end,:));
    dist = sum((diffX * A) .* diffX, 2);
    D(i + 1:end, i) = dist;
    D(i, i + 1:end) = dist';
end
%%
sigma = 0.5;
Q = exp(-D/sigma);
Q(1:n+1:end) = 0;
Q = bsxfun(@rdivide, Q, sum(Q, 2));
Q = max(Q, realmin);

figure,imagesc(Q),
% colorbar,
title('投影后空间');




























