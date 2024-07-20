clc;clear;
MonteCarloNum=2;
ScalarList=[10,15,20,50];
for iterScalar=1:numel(ScalarList)
    Scalar=ScalarList(iterScalar);
A=GenerateData(10000,30000,10,Scalar);
mList=[];
for iter=1:numel(A)
    mList(end+1)=size(A{iter},1);
end
m=3;
n=numel(A);
timeStore=zeros(m,n);
timeQR=zeros(MonteCarloNum,1);
timeSVD=zeros(MonteCarloNum,1);
timeSVD1=zeros(MonteCarloNum,1);
for iter=1:n
    for MonteCarlo=1:MonteCarloNum
    tic;U=stablePesudoQR(A{iter});timeQR(MonteCarlo)=toc;
    tic;U=pseudoQR1(A{iter});timeSVD(MonteCarlo)=toc;
    tic;U=pseudoSVD2(A{iter});timeSVD1(MonteCarlo)=toc;
    end
    timeStore(1,iter)=mean(timeQR);
    timeStore(2,iter)=mean(timeSVD);
    timeStore(3,iter)=mean(timeSVD1);
end
timeList=timeStore;
save(['data/CompareTwo_',num2str(Scalar),'.mat'],'timeStore','mList');
color={[1,85,153],[250,192,15],[243,118,74],[95,198,201],[79,89,109]};
semilogy(mList,timeList(1,:),'- s','DisplayName','Pesudo-QR','LineWidth',3,'Color',color{1}/255);
hold on;
semilogy(mList,timeList(3,:),'- s','DisplayName','Pesudo-SVD','LineWidth',3,'Color',color{2}/255);
xlabel('m:');
ylabel('Cost Time');
set(gca, 'linewidth', 3, 'fontsize', 16);
set(gca,'yminortick','on');
set(gca,'xminortick','on');

saveas(gcf,['figure/semilogyCompareTimeTwo_',num2str(Scalar),'.fig']);
hold off;
legend('Location','best');
close;        

end