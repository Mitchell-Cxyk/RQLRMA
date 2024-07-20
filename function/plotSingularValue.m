function dummy=plotSingularValue(A,path,svdMethod)
if strcmp(svdMethod,'svd')
    [~,S,~]=svd(A);
elseif strcmp(svdMethod,'R_svdQCQ')
    [~,S,~]=R_svdQCQ(A);
elseif strcmp(svdMethod,'mysvdQ')
    [~,S,~]=mysvdQ(A);
end

semilogy(1:numel(diag(S)),diag(S),'ob-', 'linewidth', 1.1,'markerfacecolor', [120, 169, 225]/255);
hold on;
set(gca, 'linewidth', 3, 'fontsize', 16, 'fontname', 'times');
xlabel('Singular value order');
ylabel('Singular value');
saveas(gcf,path,'psc2');
hold off;
