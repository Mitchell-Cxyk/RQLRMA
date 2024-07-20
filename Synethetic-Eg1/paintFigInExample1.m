load("mList_Processed.mat");
mList=floor(mList);
load("NoiseData6_Processed.mat");
PaintTimeAndNorm(normArray,mList,'figure/normNoise.fig','Relative Error',@plot);
PaintTimeAndNorm(timeArray,mList,'figure/timeNoise.fig','Running Time',@plot);
load("PolyData6_Processed.mat");
PaintTimeAndNorm(normArray,mList,'figure/normPoly.fig','Relative Error',@semilogy);
load("Exp2Data6_Processed.mat");
normArray=abs(normArray);
PaintTimeAndNorm(normArray,mList,'figure/normExp2.fig','Relative Error',@semilogy);
PaintTimeAndNorm(timeArray,mList,'figure/timeExp2.fig','Running Time',@plot);