cd Synethetic-Eg1;
RunExampleAndPaint;
cd ..;
cd BigCFD-Eg2;
run_bigcfd;
cd ..;
cd BigLorenz-Eg3;
RunExampleAndPaint;
cd ..;
% cd BigImage-Eg4;
% RunExampleAndPaint;
% cd ..;
cd SM;
cd SM1;
RunAndPaint;
cd ..;
cd SM4;
RunTimeTest;
PaintTime;
TimeCompareThree;
TimeCompareTwo;
cd ..;
cd SM6;
testCondNum;
paintFig;
cd ..;
cd SM7;
testAllData;
cd dataAll;
PaintSynethicInSM;
cd ..;
cd ..;
cd SM8;
testODE1;
disp('RunComplete!');