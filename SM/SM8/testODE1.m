a = 15;
b = 2;
c = 28;
% d = 0.1;
% k = 0.1;
% e = 20.6;
% h = 1;

F = @(t,Y) [a*(Y(2)-Y(1));c*Y(1)-Y(2)-Y(1)*Y(3)+Y(4);-b*Y(3)+Y(1)*Y(2);(c-1)*Y(2)+Y(4)-Y(1)^3/b];
pointNum=10000;
timeNum=20000;
A=randq(timeNum,pointNum);
qc=100*randq(pointNum,1);
T = linspace(0,5000,timeNum);
%Y={pointNum};
% bar = waitbar(0,'processing...');
for iter=1:1
    CI=[part(qc(iter,1),1),part(qc(iter,1),2),part(qc(iter,1),3),part(qc(iter,1),4)]';
%CI = [3.2 8.5 3.5 2.0]';

[t,Y{iter}]=ode45(F,T,CI);
% [t,Y]=ode45(F,T,CI);

end

plot3(Y{1}(:,1),Y{1}(:,2),Y{1}(:,3))
