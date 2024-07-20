function A=lowrankQ(m,n,r,A,U,S,V)
% generate m-by-n quaternion matrix Ar of rank r from original A
% by svd decomposition.
% by Zhigang Jia On February 18,2018
if nargin<=4
    if nargin <1
        m=2;n=m;r=1;
    elseif nargin<2
        n=m;r=min(m,n);
    elseif nargin<3
        r=min(m,n);
    elseif nargin<4
        A0=rand(m,m);
        A1=rand(m,m);
        A2=rand(m,m);
        A3=rand(m,m);
        A=[A0 A2 A1 A3];
    end
    addpath /Users/jiazhigang/Dropbox/mycodes/Quaternion_code/svdQ
    % [A0,A1,A2,A3]=A2A0123(A);
    % [U,~,V]=svdQ(A);
    [U,S,V]=svdQ(A);
    % timesQ(U,transQ(U))
    % timesQ(transQ(U),U)
end
%
% A0=rand(n,n);
% A1=rand(n,n);
% A2=rand(n,n);
% A3=rand(n,n);
% A=[A0 A2 A1 A3];
% V=qrQ(A);
% timesQ(V,transQ(V))
% timesQ(transQ(V),V)
%
%
rankS=rank(S);
diagS=diag(S);
if r<=rankS && r<min(m,n)
    d=[diagS(1:r);zeros(n-r,1)];
else
    'warning: r>rankS!Then let r=rankS'
    r=rankS;
    d=[diagS(1:r);zeros(n-r,1)];
end
D=diag(d);
Zo=zeros(m,n);
D=[D Zo Zo Zo];
% 
A=timesQ(timesQ(U,D),transQ(V));


