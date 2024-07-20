function [D,V]=eigQ(A)
%function [D,V]=eigQ(A). Compute the eigenvalues and corresponding egenvectors of Hermitian quaternion matrices.
% Input:  A=[A0,A2,A1,A3] % a Hermitian quaternion matrix A=A0+A1i+A2j+A3k;
% Output: D--a vector of eigenvalues of A
%          V--eigenvectors of A
% satisfying: AV=Vdiag(D);
% References:

% Z. Jia, M. Wei, and S. Ling. A New Structure-Preserving Method for
%  ``Quaternion Hermitian Eigenvalue Problems''. J. Comput. Appl. Math.,
%  239:12-24,  2013.
%

% by Zhigang Jia May 13 2014

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
n=size(A,1);
[T,A]=tridiagQ(A);
[P,D]=schur(A(:,1:n));  % surely give orthogonal eigenvectors
%% sort
[D , ind] = sort(diag(D) , 'descend');
P = P (: , ind );
V=[T(:,1:n)*P,T(:,n+1:2*n)*P,T(:,2*n+1:3*n)*P,T(:,3*n+1:4*n)*P];
