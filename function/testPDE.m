a = 15;
b = 2;
c = 28;
% d = 0.1;
% k = 0.1;
% e = 20.6;
% h = 1;

F = @(t,Y) [a*(Y(2)-Y(1));c*Y(1)-Y(2)-Y(1)*Y(3)+Y(4);-b*Y(3)+Y(1)*Y(2);(c-1)*Y(2)+Y(4)-Y(1)^3/b];
pointNum=2000;
timeNum=1000;
A=randq(timeNum,pointNum);
qc=100*randq(pointNum,1);
T = linspace(0,500,timeNum);
%Y={pointNum};
bar = waitbar(0,'processing...');
for iter=1:pointNum
    CI=[part(qc(iter,1),1),part(qc(iter,1),2),part(qc(iter,1),3),part(qc(iter,1),4)]';
%CI = [3.2 8.5 3.5 2.0]';

%[t,Y{iter}]=ode45(F,T,CI);
[t,Y]=ode45(F,T,CI);
A(:,iter)=quaternion(Y(:,1),Y(:,2),Y(:,3),Y(:,4));
str=['Computing...',num2str(100*iter/pointNum),'%'];
waitbar(iter/pointNum,bar,str)
end
[~,S,~]=csvdQ(A);
S=diag(S);
semilogy(S);
%semilogy(1:numel(Y(:)),Y(:));
%%
%plot3(Y{1}(:,1),Y{1}(:,2),Y{1}(:,3))
% A=randq(100,100);
% for iter=1:numel(t)
%     A(iter)=quaternion(Y(iter,1),Y(iter,2),Y(iter,3),Y(iter,4));
% end
% A=randq(pointNum,timeNum);
% % A=[];
% for iter1=1:pointNum
%     YIter=Y{iter1};
%     for iter2=1:timeNum
%         A(iter1,iter2)=quaternion(YIter(iter2,1),YIter(iter2,2),YIter(iter2,3),YIter(iter2,4));
% %         A(iter1,iter2)=YIter(iter2,1);
%     end
% end
% %%
% %output=ThreeSketchImg(A,9,30,60,'Gaussian');
% %%
% % for iter=1:100
% %     L2=1;
% %     iter
% %     L1=1;
% %     L2=iter+1-L1;
% % while (L2>0)&&(L2<=100)
% %     
% %    
% %     A(L1,iter+1-L1)=quaternion(Y(iter,1),Y(iter,2),Y(iter,3),Y(iter,4));
% %     L1=L1+1;
% %     L2=iter+1-L1
% % end
% % end
% [~,S,~]=mysvdQ(A);
% % [~,S,~]=svd(A);
% semilogy(1:numel(diag(S)),diag(S));
% 
% %A=reshape(vA,50,60);