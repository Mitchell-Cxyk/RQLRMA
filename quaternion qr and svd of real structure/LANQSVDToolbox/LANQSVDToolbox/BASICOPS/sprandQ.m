function A=sprandQ(m,n,density)
% genreate a sparse random quaternion matrix A=[A0 A2 A1 A3], 
% density=[d0 d2 d1 d3], where d0123 are sparsity of A0123.
% by Zhigang Jia On January 26,2018
if nargin<1
    m=1,n=m,density=[1 1 1 1];
elseif nargin==1
    n=m,density=[0.1,0.1,0.1,0.1];
elseif nargin==2
    density=[0.1,0.1,0.1,0.1];
elseif nargin>3
    'Too many imput variables.'
end
%
A0=sprand(m,n,density(1));
A1=sprand(m,n,density(2));
A2=sprand(m,n,density(3));
A3=sprand(m,n,density(4));
%
A=[A0 A2 A1 A3];



  