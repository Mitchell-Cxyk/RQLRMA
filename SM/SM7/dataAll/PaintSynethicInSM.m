mList=floor(logspace(2.05,2.7,10));
DecayList={'low','mid','high'};
for iter=1:numel(DecayList)
    decay=DecayList{iter}
    str=['Noise_',decay,'.mat'];
    load(str);
    str1=['figure/NormNoise_',decay,'fig'];
    str2=['figure/TimeNoise_',decay,'fig'];
    PaintTimeAndNorm(normArray,mList,str1,'Relative Error',@plot);
    PaintTimeAndNorm(timeArray,mList,str2,'Running Time',@plot);
    str=['Poly_',decay,'.mat'];
    load(str);
    str1=['figure/NormPoly_',decay,'fig'];
    str2=['figure/TimePoly_',decay,'fig'];
    PaintTimeAndNorm(normArray,mList,str1,'Relative Error',@semilogy);
    PaintTimeAndNorm(timeArray,mList,str2,'Running Time',@plot);
    str=['Exp2_',decay,'.mat'];
    load(str);
    str1=['figure/NormExp2_',decay,'fig'];
    str2=['figure/TimeExp2_',decay,'fig'];
    PaintTimeAndNorm(normArray,mList,str1,'Relative Error',@semilogy);
    PaintTimeAndNorm(timeArray,mList,str2,'Running Time',@plot);
    str=['Exp_',decay,'.mat'];
    load(str);
    str1=['figure/NormExp_',decay,'fig'];
    str2=['figure/TimeExp_',decay,'fig'];
    PaintTimeAndNorm(normArray,mList,str1,'Relative Error',@semilogy);
    PaintTimeAndNorm(timeArray,mList,str2,'Running Time',@plot);
end
