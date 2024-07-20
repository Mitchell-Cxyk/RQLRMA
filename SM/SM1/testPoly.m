color={[1,85,153],[250,192,15],[243,118,74],[95,198,201],[79,89,109]};
A=GenerateLowRankPlusPolyDecay(2000,500,100,'high');
[~,S,~]=csvdQ(A);
S=diag(S);
semilogy(1:numel(S),S,'Color',color{1}/255,'LineWidth',5);
set(gca, 'linewidth', 3, 'fontsize', 16);
set(gca,'yminortick','on');
set(gca,'xminortick','on');
saveas(gca,'fig/PolySingularValue.fig');
close all;
IterList=[1:5,6:5:50];
CondList=zeros(2,numel(IterList));
TimeList=zeros(2,numel(IterList));
for iter=1:numel(IterList)
    iterT=IterList(iter);
    tic;
    H1=pseudoQRIter(A,iterT);
    TimeList(1,iter)=toc;
    CondList(1,iter)=condQ(H1);
    tic;
    H2=approxPolar(A,iterT);
    TimeList(2,iter)=toc;
    CondList(2,iter)=condQ(H2);
end
save("data/PolyData","CondList","TimeList","IterList");
