function output = AddQGNoise(A,gamma)
%
% description.
%
% @since 1.0.0
% @param {type} [name] description.
% @return {type} [name] description.
% @see dependencies
%
m=size(A,1);
n=size(A,2);
% [U,S,V]=mysvdQ(A);
% S=zeros(size(S));
G=randn(m,n);


% S(1:R,1:R)=eye(R);
% G=randn(size(S,1),size(S,2));
% [~,G,~]=svd(G);
% S=S+sqrt(gamma*R/(2*size(S,1)*size(S,2)))*(G);

A=A+sqrt(gamma/(2*m*n))*(G);
output=A;

