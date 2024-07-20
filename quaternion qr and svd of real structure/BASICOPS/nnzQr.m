function [r,density]=nnzQr(A,N)
% [r,density]=nnzQr(A,N) define nonzeros number,r, and density, on four
% parts. 
% different to nnzQ, density is a vector.
% by Zhigang Jia On February 13,2018
if nargin==1
    N=size(A,2)/4;
end
    r=nnz((abs(A(:,1:N))+abs(A(:,N+1:2*N))+abs(A(:,2*N+1:3*N))+abs(A(:,3*N+1:4*N)))/4);
    density=[nnz(A(:,1:N)),nnz(A(:,N+1:2*N)),nnz(A(:,2*N+1:3*N)),nnz(A(:,3*N+1:4*N))]/(size(A,1)*N);
end