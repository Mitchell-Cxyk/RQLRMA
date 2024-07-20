S=logspace(0,10,400)/1e10;
A=GenerateLowRankConsum(2000,400,S);
s=200;l=400;r=150;
normF=[];
normFQB=[];
normFQB1=[];
condH=[];
Y=A*randnQ([size(A,2),s]);
Y1=A*randnQ([size(A,2),r]);
Psi=randnQ([l,size(A,1)]);
Psi1=randnQ([2*r,size(A,1)]);
W=Psi*A;
for iterTime=[0:5 6:2:50]
H=approxPolar(Y,iterTime);
condH=[condH,condQ(H)];
X=QLEQ(Psi*H,W);
H1=approxPolar(Y1,iterTime);
X1=QLEQ(Psi1*H1,Psi1*A);
[U,S,V]=ModifiedQSVD1(X,'Rank',r);
normFQB=[normFQB,normQf(A-H*X)];
normFQB1=[normFQB1,normQf(A-H1*X1)];
normF=[normF, normQf(A-H*U*S*V')];
end
normF=normF/normQf(A);
normFQB=normFQB/normQf(A);
normFQB1=normFQB1/normQf(A);