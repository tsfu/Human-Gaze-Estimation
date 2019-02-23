function b1= GetC( feature,feature1, sigma )
num=25;
b1=[];
data=load(strcat('C:\Users\lenovo\Desktop\毕设\New\最新采集\注视点坐标','\',num2str(num),'点.txt'));
ture=load(strcat('C:\Users\lenovo\Desktop\毕设\New\最新采集\注视点坐标','\','测试坐标.txt'));
for i=1:36
    f=feature1(:,i);
    W = SimilarityMatrix( feature' , f , sigma ) ;  
    [w] = WCESR(feature',f,W);
    w(find(abs(w)<0.1))=0;
    w=w/sum(w);
    cal=data'*w;   
    erro=cal-ture(i,:)';   
    a=sum(erro.^2,1);
    a=sqrt(a);
    c=atan(a.*0.027/50);
    b1=[b1,c];  
end
end