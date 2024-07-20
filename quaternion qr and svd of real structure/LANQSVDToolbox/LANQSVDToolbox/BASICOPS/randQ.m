function A=randQ(m,n,r)
% generate m-by-n quaternion matrix A of rank r 
% by svd decomposition.
    % by Zhigang Jia On January 26,2018
if nargin <1
    m=2;n=m;r=1;
elseif nargin==1
    n=m;r=min(m,n);
elseif nargin==2
    r=min(m,n);
end
addpath /Users/jiazhigang/Dropbox/mycodes/Quaternion_code/svdQ

%
A0=rand(m,m);
A1=rand(m,m);
A2=rand(m,m);
A3=rand(m,m);
A=[A0 A2 A1 A3];
[U,S,V]=svdQ(A);
diagS=diag(S);
if r<min(m,n)
    d=[ones(r,1)+diagS(1:r);zeros(n-r,1)];
else 
    d=[ones(r,1);zeros(n-r,1)];
end
D=diag(d);
Zo=zeros(m,n);
D=[D Zo Zo Zo];
A=timesQ(timesQ(U,D),transQ(V));


