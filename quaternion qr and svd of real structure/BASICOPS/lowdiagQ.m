function sum=lowdiagQ(H)
% sum of the elements lower that diagonnal of the quaternion matrix
% input the first block row of real presentation of quaternion matrix
% H=H0+H1i+H2j+H3k
% H=[H0,H2,H1,H3];
% Note that:
% H0 H2,H1,H3 real matrices
%
% Sum is the lower subdiagonal  triangular of H0
%        the lower    triangular of H2
%        the lower    triangular of H1
%        the lower    triangular of H3
%by Zhi-Gang Jia
%on Aug1 2015
%
sum=0;
[m,n]=size(H);
[H0,H1,H2,H3]=A2A0123(H);
if m>1
    for k=2:m
        for t=1:k-1
            %sum=sum+abs(H0(k,t))^2+abs(H1(k,t))^2+abs(H2(k,t))^2+abs(H3(k,t))^2+abs(H0(t,k))^2+abs(H1(t,k))^2+abs(H2(t,k))^2+abs(H3(t,k))^2;
            sum=sum+abs(H0(k,t))^2+abs(H1(k,t))^2+abs(H2(k,t))^2+abs(H3(k,t))^2;
        end
        sum=sum-norm(diag(H0,-1))^2;
    end
     sum=sqrt(sum);
else
    'No meaning for lower tiangular matrices! The reason may be the dimension of matrix is  m=1!'
    sum=0;
end
    
