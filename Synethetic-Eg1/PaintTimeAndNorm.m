function flag=PaintTimeAndNorm(timeList,mList,filestr,labelY,paintFun)
%paintFun=@plot;
color={[1,85,153],[250,192,15],[243,118,74],[95,198,201],[79,89,109]};
paintFun(mList,timeList(1,:),'- s','DisplayName','RQSVD-QHQR','LineWidth',3,'Color',color{3}/255);
hold on;
%paintFun(mList,timeList(2,:),'-- s','DisplayName','RQSVD-qMGS1','LineWidth',4,'Color',color{4}/255);
if size(timeList,1)>2
    if size(timeList,1)==3
        paintFun(mList,timeList(3,:),'-- s','DisplayName','RQSVD-QMGS','LineWidth',2,'Color',color{2}/255);
    else
        paintFun(mList,timeList(3,:),'- s','DisplayName','RQSVD-QMGS','LineWidth',2,'Color',color{4}/255);
        paintFun(mList,timeList(4,:),': s','DisplayName','RQSVD-PseudoSVD','LineWidth',2,'Color',color{2}/255);
        paintFun(mList,timeList(5,:),'- diamond','DisplayName','Onepass-PseudoQR','LineWidth',3,'Color',color{1}/255);
        paintFun(mList,timeList(6,:),'-- diamond','DisplayName','Onepass-PseudoSVD','LineWidth',2,'Color',color{2}/255);
    end
end
xlabel('r:');
ylabel(labelY);
set(gca, 'linewidth', 3, 'fontsize', 13);
set(gca,'yminortick','on');
set(gca,'xminortick','on');
legend('Location','best');
saveas(gcf,filestr);
hold off;
% close;
end

