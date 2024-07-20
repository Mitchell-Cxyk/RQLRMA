function [r,sparsity]=nnzQ(A,N)
% function nz=nnzQ(A) output the numbers of nonzero elements of quaternion
% matrix A
% different to nnzQr, sparsity is a number.
% by Zhigang Jia On February 13,2018

% if nargin<=1
%     N=size(A,2)/4;
% else
    absA=abs(A(:,1:N))+abs(A(:,N+1:2*N))+abs(A(:,2*N+1:3*N))+abs(A(:,3*N+1:4*N));
    r=nnz(absA);
    sparsity=r/(size(A,1)*N);
% end
