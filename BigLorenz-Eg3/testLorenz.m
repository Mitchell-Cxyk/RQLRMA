
iterList=floor(logspace(2.3,3.2,10));
if exist('A','var')
    clearvars -except A;
else
    load("newLorenzData.mat");
end
if exist('DataQ','var')
    clearvars -except DataQ;
else
    load("DataQ.mat");
end
timeList=zeros(4,numel(iterList));
errorList=zeros(4,numel(iterList));
for iter1=1:numel(iterList)
    iter=iterList(iter1)
    tic;
    [U,S,V]=ranQLoRMA(A,iter,@pseudoSVD2,iter+5,2*iter+10);
    timePseudoSVD=toc;
    normPseudoSVD=normQf(A-U*S*V');
    timeList(1,iter1)=timePseudoSVD;
    errorList(1,iter1)=normPseudoSVD;
    % save(['dataApproximation_PseudoSVD',num2str(iter),'.mat'],'U','S','V','timePseudoSVD');
    % clearvars -except A iter1;
    tic;
    [U,S,V]=ranQLoRMA(A,iter,@pseudoQR,iter+5,2*iter+10);
    timePseudoQR=toc;
    normPseudoQR=normQf(A-U*S*V');
    timeList(2,iter1)=timePseudoQR;
    errorList(2,iter1)=normPseudoQR;
    % save(['dataApproximation_PseudoQR',num2str(iter),'.mat'],'U','S','V','timePseudoQR');
    % clearvars -except A iter;
    tic;[U,S,V]=HMTOnePass(A,iter);
    timeHMT11=toc;
    normHMT11=normQf(A-U*S*V');
    timeList(3,iter1)=timeHMT11;
    errorList(3,iter1)=normHMT11;
    tic;[U,S,V]=UPA16(A,iter);timeUPA16=toc;
    normUPA16=normQf(A-U*S*V');
    timeList(4,iter1)=timeUPA16;
    errorList(4,iter1)=normUPA16;
end
normA=normQf(A);
errorList=errorList/normA;
save('computedLorenzData.mat',"iterList","errorList","timeList");