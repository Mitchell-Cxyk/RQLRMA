ScalarList=[10,15,20,50];
for iterScalar=1:numel(ScalarList)
    Scalar=ScalarList(iterScalar)
A=GenerateData(500,2000,10,Scalar);
mList=[];
for iter=1:numel(A)
    mList(end+1)=size(A{iter},1);
end
timeList=TimeTest(A);
save(['data/CompareFive_',num2str(Scalar),'mat']);
paintTimeFive;
end