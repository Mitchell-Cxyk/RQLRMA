function r=isnanQ(A)
% by Zhigang Jia On March 6,2018
    N=size(A,2)/4;
    r=isnan(A(:,1:N))|isnan(A(:,N+1:2*N))|isnan(A(:,2*N+1:3*N))|isnan(A(:,3*N+1:4*N));
    r=[r r r r];
end