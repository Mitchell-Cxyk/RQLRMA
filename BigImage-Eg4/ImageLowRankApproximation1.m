%load data
function flag=ImageLowRankApproximation1(RightSketch,LeftSketch,Psi,r,rangefinder)
%r=3900;
tic;
RightSketch=RightSketch(:,1:r+50);
LeftSketch=LeftSketch(1:2*r+100,:);
Psi=Psi(1:2*r+100,:);
H=rangefinder(RightSketch);
t1=toc;

%condH=condQ(H)
clearvars RightSketch;
tic;
X=QLEQ(Psi*H,LeftSketch);
t2=toc;
clearvars Psi LeftSketch;
tic;
[U,S,V]=csvdQ(X);
U=H*U(:,1:r);
V=V(:,1:r);
S=S(1:r,1:r);
t3=toc;
CostTime=t1+t2+t3;
save(['ImageStore_',num2str(r),'_',func2str(rangefinder),'.mat'],"CostTime","U","S","V",'-v7.3');
flag=1;
% clearvars -except U S V;
% AAA=U*S*V';
%imshowQ(AAA);