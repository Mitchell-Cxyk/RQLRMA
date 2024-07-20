function A=lowrankQ_randn(m,n,r,A,U,S,V)
% generate m-by-n quaternion matrix Ar of rank r from original A
% by svd decomposition.

% by Zhigang Jia On May 3,2018
if nargin<=4
    if nargin <1
        m=2;n=m;r=1;
    elseif nargin<2
        n=m;r=min(m,n);
    elseif nargin<3
        r=min(m,n);
    elseif nargin<4
        A0=randn(m,n);
        A1=randn(m,n);
        A2=randn(m,n);
        A3=randn(m,n);
        A=[A0 A2 A1 A3];
    end
    [U,S,V]=svdQ(A);
end
rankS=rank(S);
diagS=diag(S);
if r<=rankS && r<min(m,n)
    d=[diagS(1:r);zeros(n-r,1)];
else
    'warning: r>rankS!Then let r=rankS'
    r=rankS;
    d=[diagS(1:r);zeros(n-r,1)];
end
if m>n
    D=[diag(d);zeros(m-n,n)];
else
    D=[diag(d),zeros(m,n-m)];
end
Zo=zeros(m,n);
D=[D Zo Zo Zo];
% 
A=timesQ(timesQ(U,D),transQ(V));

