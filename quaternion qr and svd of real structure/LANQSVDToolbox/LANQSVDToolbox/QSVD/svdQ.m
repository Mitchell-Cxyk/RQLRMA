function [U,D,V]=svdQ(A)
%function [U,D,V]=svdQ(A)
%input the first block row of real presentation of quaternion matrix
%Q=A0+A1i+A2j+A3k
%A=(A0,A2,A1,A3);
% output 
%D; %  is the diagonal matrix whose diagonal elements are singular values of quaternion matrix  Q
%U=[U0 U2 U1 U3]; % is the first block row of real presentation of left
%singular vectors
%V=[V0 V2 V1 V3]; % is the first block row of real presentation of right
%singular vectors

% by Zhigang Jia on Aug 14 2014, 02:33

[U,B,V]=bidiagQ(A);

[u,D,v]=svd(B);

U=U*blkdiag(u,u,u,u);

V=V*blkdiag(v,v,v,v);



