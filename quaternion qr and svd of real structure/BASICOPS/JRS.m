function [J,R,S] =JRS(n)
% by Zhigang Jia On May 14,2014
%define J matrices 
J=zeros(4*n);
J(1:2*n,2*n+1:4*n)=-eye(2*n);
J(2*n+1:4*n,1:2*n)=eye(2*n);

R=zeros(4*n);
R(1:n,n+1:2*n)=-eye(n);
R(n+1:2*n,1:n)=eye(n);
R(2*n+1:3*n,3*n+1:4*n)=eye(n);
R(3*n+1:4*n,2*n+1:3*n)=-eye(n);

S=zeros(4*n);
S(1:n,3*n+1:4*n)=-eye(n);
S(n+1:2*n,2*n+1:3*n)=eye(n);
S(2*n+1:3*n,n+1:2*n)=-eye(n);
S(3*n+1:4*n,1:n)=eye(n);
end
