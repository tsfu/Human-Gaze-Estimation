function [x,y] = CESR(A,b)

[m,n] = size(A);
weight = ones(m,1);
F = [];
G = 1:n;
x = zeros(n,1);
Atb = A'*b;
y = -Atb;  %alpha

noready = 1;
count =1;
alpha=1.e-6;
while noready
    
    %     	//step 1
    yG = y(G);
    if isempty(yG)
        break;
    end
    r = G(yG == min(yG));
    if(isempty(r))
        break;
    end
    r = r(1);
    
    if (y(r) < 0)
        H1 = [];
        H2 = r;
        F = union(setdiff(F,H1),H2);
        G = union(setdiff(G,H2),H1);
    else
        noready = 0;
        break;
    end
    
    
    noready2 = 1;
    while noready2
        
        %         //step 2
        AF = A(:,F);  %XF
        
        %          //repmat(sqrt(weight),1, size(AF,2)).*AF;
        [dt,dt1] = size(AF);
        w1 = sqrt(weight);
        wt1 = AF;
        for i1=1:dt1
            wt1(:,i1)= wt1(:,i1).*w1;  %相当于X
        end
        
        %          //xF=(wt1)\(weight.*b);
        %          // disp('here');
        if( rank(wt1'*wt1)<size(wt1'*wt1,1))
            xF = pinv(wt1'*wt1)*(AF'*(weight.*b)-1/2*alpha*sum(length(F)));%  就是 alpha
            disp('warning by heran');
        else
            xF = (wt1'*wt1)\(AF'*(weight.*b)-1/2*alpha*sum(length(F)));
        end
        
        nF = length(xF);
        
        indt=find(xF < 0);
        
        if isempty(indt)
            %             //all(xF >= 0)
            
            x = [xF; zeros(n-nF,1)];
            %             	//goto 3
            noready2 = 0;
            break;
            
        else
            
            index = find(xF<0);
            t = -x(index)./(xF(index) - x(index));
            tetha = min(t);
            r = F(index(t == tetha));
            if(isempty(r))
                break;
            end
            r = r(1);
            x = [(1-tetha)*x(F) + tetha*xF ; zeros(n-nF,1)]; % 更新  beta
            H1 = r;
            H2 = [];
            F = union(setdiff(F,H1),H2);
            G = union(setdiff(G,H2),H1);
            %             	//goto 2
            
        end
        
    end
    %         //while noready2
    
    
    %     	//step 3
    AG = A(:,G);
    
    [dt,dt1] = size(AG);
    wt1=AG;
    for i1= 1:dt1
        wt1(:,i1)= wt1(:,i1).*weight;
    end
    
    yG = wt1' * (AF * xF - b)+1/2*alpha; % alpha
    y(G) = yG;
    
    %     //calculate the weight
    weight = (AF *xF-b).^2; 
    weight = exp(-weight/(1*mean(weight)));
    
    
    %     	printf('%d ",count);
    count=count+1;
    if(count>200)
        break;
    end
    
end

% 	//put results into their corresponding positions
a = x;
b = y;
x = zeros(n,1);
y = zeros(n,1);
x(F) = a(1:length(F));
y(G) = b(1:length(G));
end