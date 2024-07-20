color={[1,85,153],[250,192,15],[243,118,74],[95,198,201],[79,89,109]};
xList=[0:5 6:2:50];
semilogy(xList,normF,'-s','DisplayName','One-PassRelativeError(s=200,r=150)','LineWidth',4,'Color',color{1}/255);
hold on;
semilogy(xList,condH,'-o','DisplayName','condQH(s=200)','LineWidth',4,'Color',color{2}/255);
semilogy(xList,normFQB,'--s','DisplayName','QB-RelativeError(s=200)','LineWidth',3,'Color',color{3}/255);
semilogy(xList,normFQB1,'--s','DisplayName','QB-RelativeError(s=150)','LineWidth',3,'Color',color{4}/255);
xlabel('Newton Steps:')
set(gca, 'linewidth', 3, 'fontsize', 14);
set(gca,'yminortick','on');
set(gca,'xminortick','on');
legend('Location','best');
saveas(gcf,'testCondNum.fig');
hold off;
close;
