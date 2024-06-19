%-----------------------------------------------------------------Note------------------------
% This function is to compute a quaternion linear equation AX=b. It reqire arguments as follows:
% 1.A is a m*n quaternion matrix, b is a m*d quternion matrix, return a solution X. No error detection here.
% 2.The rules is same to the real situation in matrix-left-divide(\), here gives its help document.
% The mldivide AlgorithmThe mldivide operator employs different algorithms to handle different kinds of coefficient matrices. The various cases are diagnosed automatically by examining the coefficient matrix.Permutations of Triangular Matricesmldivide checks for triangularity by testing for zero elements.
% If a matrix A is triangular, MATLAB software uses a substitution to compute the solution vector x. If A is a permutation of a triangular matrix, MATLAB software uses a permuted substitution algorithm.Square MatricesIf A is symmetric and has real, positive diagonal elements, MATLAB attemptsa Cholesky factorization. If the Cholesky factorization fails, MATLAB performsa symmetric, indefinite factorization. If A is upper Hessenberg, MATLAB uses Gaussian elimination to reduce the system to a triangular matrix. If A is square but is neither permuted triangular, symmetric and positive definite, or Hessenberg, then MATLAB performs a general triangular factorization using LU factorization with partial pivoting (see lu).Rectangular Matrices
%If A is rectangular, mldivide returns a least-squares solution. MATLAB solves overdetermined systems with QR factorization (see qr). For an underdetermined system, MATLAB returns the solution with the maximum number of zero elements.
%3.The fucntion uses complex represtation, So rules 2 may be different. Please reconsider it.
%---------------------------------------------------------------Note----------------------------


% Authors: Hanxin Ya, Yuning Yang (yyang@gxu.edu.cn,
%           yuning.yang1207@gmail.com)

% Reference:
% [1] Hanxin Ya, Ying Wang, Yuning Yang, On Quaternion Higher-Order Singular Value Decomposition: Models and Analysis
%           https://arxiv.org/abs/2309.05211


function [solution]=QLEQ(A,b)
CA=[[A.w+A.x*i,A.y+A.z*i];[-A.y+A.z*i,A.w-A.x*i]];
Cb=[b.w+b.x*i;-b.y+b.z*i];
% tic;
% tmp=pinv(CA)*Cb;
% toc;
%tic;
tmp=CA\Cb;
%toc;
sizetmp=size(tmp);
Solution0R=real(tmp(1:sizetmp(1)/2,:));
Solution0I=imag(tmp(1:sizetmp(1)/2,:));
Solution1R=real(tmp(sizetmp(1)/2+1:sizetmp(1),:));
Solution1I=imag(tmp(sizetmp(1)/2+1:sizetmp(1),:));
solution=quaternion(Solution0R,Solution0I,-Solution1R,Solution1I);

