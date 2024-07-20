fid = fopen('C:\Users\cxyk3\source\repos\vectorqMGS\vectorqMGS\OriginMatrix.txt', 'r');
OriginMatrix = fscanf(fid, '%g');
fclose(fid);
m=10000;n=500;
OriginMatrix = reshape(OriginMatrix, [4*m, n]); 
AA=OriginMatrix;
A=quaternion(AA(1:m,:),AA(m+1:2*m,:),AA(2*m+1:3*m,:),AA(3*m+1:4*m,:));
% [QQ,RR]=qMGS2(AA);
% % [Q,R]=qMGS1(A);
% Q=quaternion(QQ(1:m,:),QQ(m+1:2*m,:),QQ(2*m+1:3*m,:),QQ(3*m+1:4*m,:));
% condQ(Q)
% absUqU=abs(Q'*Q);


fid = fopen('C:\Users\cxyk3\source\repos\vectorqMGS\vectorqMGS\matrixQ.txt', 'r');
matrix = fscanf(fid, '%g');
fclose(fid);
matrix = reshape(matrix, [4*m,n]); % 重新调整矩阵为 5x5
QQ=matrix;
Q=quaternion(QQ(1:m,:),QQ(m+1:2*m,:),QQ(2*m+1:3*m,:),QQ(3*m+1:4*m,:));
condQ(Q)
absUqU=abs(Q'*Q);

fid = fopen('C:\Users\cxyk3\source\repos\vectorqMGS\vectorqMGS\matrixR.txt', 'r');
matrixR = fscanf(fid, '%g');
fclose(fid);
matrixR = reshape(matrixR, [4*n, n]); % 重新调整矩阵为 5x5
RR=matrixR;
R=quaternion(RR(1:n,:),RR(n+1:2*n,:),RR(2*n+1:3*n,:),RR(3*n+1:4*n,:));
absR=abs(R);
normF=normQf(A-Q*R)