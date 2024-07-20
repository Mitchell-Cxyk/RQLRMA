clc;clear;
MonteCarloNum=3;
ScalarList=[15];
for iterScalar=1:numel(ScalarList)
    Scalar=ScalarList(iterScalar);
A=GenerateData(2000,10000,15,Scalar);
mList=[];
for iter=1:numel(A)
    mList(end+1)=size(A{iter},1);
end
m=5;
n=numel(A);
timeStore=zeros(m,n);
timeQR=zeros(MonteCarloNum,1);
timeQR1=zeros(MonteCarloNum,1);
timeSVD1=zeros(MonteCarloNum,1);
timeQMGS=zeros(MonteCarloNum,1);
timeqMGS1=zeros(MonteCarloNum,1);
for iter=1:n
    for MonteCarlo=1:MonteCarloNum
        tic;U=stablePesudoQR(A{iter});timeQR(MonteCarlo)=toc;
        tic;U=pseudoQR1(A{iter});timeQR1(MonteCarlo)=toc;
        tic;U=pseudoSVD2(A{iter});timeSVD1(MonteCarlo)=toc;
        tic;U=QMGS_MEX(A{iter});timeQMGS(MonteCarlo)=toc;
        tic;U=qMGS1(A{iter});timeqMGS1(MonteCarlo)=toc;
    end
    timeStore(1,iter)=mean(timeQR);
    timeStore(2,iter)=mean(timeQR1);
    timeStore(3,iter)=mean(timeSVD1);
    timeStore(4,iter)=mean(timeQMGS);
    timeStore(5,iter)=mean(timeqMGS1);
end
timeList=timeStore;
save(['data/timeListThree_',num2str(Scalar),'.mat'],'timeList','mList');
%%
paintFun=@semilogy;
color={[1,85,153],[250,192,15],[243,118,74],[95,198,201],[79,89,109]};
paintFun(mList,timeList(1,:),'- s','DisplayName','Pesudo-QR','LineWidth',3,'Color',color{1}/255);
hold on;
% paintFun(mList,timeList(2,:),'- s','DisplayName','pseudo-QR1','LineWidth',3,'Color',color{2}/255);

paintFun(mList,timeList(3,:),'-- s','DisplayName','pseudo-SVD','LineWidth',3,'Color',color{2}/255);

paintFun(mList,timeList(4,:),'- s','DisplayName','QMGSMEX','LineWidth',3,'Color',color{4}/255);
paintFun(mList,timeList(5,:),': diamond','DisplayName','QMGS','LineWidth',3,'Color',color{4}/255);
xlabel('m:');
ylabel('Cost Time');
set(gca, 'linewidth', 3, 'fontsize', 10);
set(gca,'yminortick','on');
set(gca,'xminortick','on');
legend('Location','best');
saveas(gcf,['figure/paintFunCompareTimeThreeTemp_',num2str(Scalar),'.fig']);
hold off;
close;
end
