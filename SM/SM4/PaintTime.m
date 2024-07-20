color={[1,85,153],[250,192,15],[243,118,74],[95,198,201],[79,89,109]};
semilogy(mList,timeList(1,:),'- s','DisplayName','Pesudo-QR','LineWidth',3,'Color',color{1}/255);
hold on;
semilogy(mList,timeList(2,:),'- s','DisplayName','Pesudo-SVD','LineWidth',3,'Color',color{2}/255);
if size(timeList,1)>2
    if size(timeList,1)==3
        semilogy(mList,timeList(2,:),'- s','DisplayName','pseudo-SVD','LineWidth',3,'Color',color{2}/255);
    else
semilogy(mList,timeList(3,:),'- s','DisplayName','QHQR','LineWidth',3,'Color',color{3}/255);
semilogy(mList,timeList(4,:),'- s','DisplayName','QMGS','LineWidth',3,'Color',color{4}/255);
semilogy(mList,timeList(5,:),'- s','DisplayName','qtfm','LineWidth',3,'Color',color{5}/255);
    end
end
xlabel('m:');
ylabel('Cost Time');
set(gca, 'linewidth', 3, 'fontsize', 16);
set(gca,'yminortick','on');
set(gca,'xminortick','on');

saveas(gcf,['figure/semilogyCompareTimeFive_',num2str(Scalar),'.fig']);
hold off;
legend('Location','best');
% close;        

