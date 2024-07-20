function [r,s]=absQ(A)
% by Zhigang Jia On March 6,2018
    N=size(A,2)/4;
    r=sqrt(A(:,1:N).^2+A(:,N+1:2*N).^2+A(:,2*N+1:3*N).^2+A(:,3*N+1:4*N).^2);
    s=A./([r r r r]+eps);
end