if ~exist("FullImage",'var')
    load("FullImage.mat","FullImage");
else
    clearvars -except FullImage;
end

rList=[1000,2000,2900,3900];
timeList=zeros(2,numel(rList));
errorList=zeros(2,numel(rList));
RelativeErrorList=zeros(2,numel(rList));
PSNRList=zeros(2,numel(rList));
normFullImage=normQf(FullImage);
for iter=1:numel(rList)
    filestr=['ImageStore_',num2str(rList(iter)),'_pseudoQR.mat'];
    load(filestr,"U","S","V","CostTime");
    timeList(1,iter)=CostTime;
    errorF=normQf(FullImage-U*S*V');
    relativeError=errorF/normFullImage;
    PSNR=20*log10(sqrt(3*size(FullImage,1)*size(FullImage,2))/errorF);
    errorList(1,iter)=errorF;
    relativeError(1,iter)=relativeError;
    PSNRList(1,iter)=PSNR;
    filestr=['ImageStore_',num2str(rList(iter)),'_pseudoSVD2.mat'];
    load(filestr,"U","S","V","CostTime");
    timeList(2,iter)=CostTime;
    errorF=normQf(FullImage-U*S*V');
    relativeError=errorF/normFullImage;
    PSNR=20*log10(sqrt(3*size(FullImage,1)*size(FullImage,2))/errorF);
    errorList(2,iter)=errorF;
    relativeErrorList(2,iter)=relativeError;
    PSNRList(2,iter)=PSNR;
end