color={[1,85,153],[250,192,15],[243,118,74],[95,198,201],[79,89,109]};
rList=iterList;
semilogy(rList,errorList(1,:),'- s','DisplayName','Algorithm 4.2 with Pesudo-SVD','LineWidth',3,'Color',color{1}/255);
hold on;
semilogy(rList,errorList(2,:),'-- s','DisplayName','Algorithm 4.2 with Pesudo-QR','LineWidth',3,'Color',color{2}/255);
semilogy(rList,errorList(3,:),'- o','DisplayName','HMT11','LineWidth',3,'Color',color{3}/255);
semilogy(rList,errorList(4,:),'- diamond','DisplayName','UPA16','LineWidth',3,'Color',color{4}/255);
xlabel('target rank r:');
ylabel('Relative Error:');
set(gca, 'linewidth', 3, 'fontsize', 13);
set(gca,'yminortick','on');
set(gca,'xminortick','on');
legend('Location','best');
saveas(gcf,'figure/NormCompareCFD1.fig');
hold off;

close;
plot(rList,timeList(1,:),'- s','DisplayName','Algorithm 4.2 with Pesudo-SVD','LineWidth',3,'Color',color{1}/255);
hold on;
plot(rList,timeList(2,:),'-- s','DisplayName','Algorithm 4.2 with Pesudo-QR','LineWidth',3,'Color',color{2}/255);
plot(rList,timeList(3,:),'- o','DisplayName','HMT11','LineWidth',3,'Color',color{3}/255);
plot(rList,timeList(4,:),'- diamond','DisplayName','UPA16','LineWidth',3,'Color',color{4}/255);
xlabel('target rank r:');
ylabel('Time Costs:');
set(gca, 'linewidth', 3, 'fontsize', 13);
set(gca,'yminortick','on');
set(gca,'xminortick','on');
legend('Location','best');
saveas(gcf,'figure/TimeCompareCFD1.fig');
hold off;

close;        

