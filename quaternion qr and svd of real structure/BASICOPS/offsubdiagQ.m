function sum=offsubdiagQ(H)
% sum of the off diagonnal elements of the hessenberg matrix by hessQ.m
% input the first block row of real presentation of quaternion matrix
% H=H0+H1i+H2j+H3k
% H=[H0,H2,H1,H3];
% Note that:
%  H0 is real Hessenberg matrix
%  H2,H1,H3 real upper triangular matrices
%
% Sum is the lower -1 triangular of H0
%        the lower    triangular of H2
%        the lower    triangular of H1
%        the lower    triangular of H3

% by Zhigang Jia On January 27,2015

sum=0;
[m,n]=size(H);
[H0,H1,H2,H3]=A2A0123(H);
if m>2
    for k=3:m
        for t=1:k-2
            sum=sum+abs(H0(k,t))+abs(H1(k,t))+abs(H2(k,t))+abs(H3(k,t));
        end
    end
    for k=2:m
        sum=sum+abs(H1(k,k-1))+abs(H2(k,k-1))+abs(H3(k,k-1));
    end
elseif m==2
    sum=sum+abs(H1(2,1))+abs(H2(2,1))+abs(H3(2,1));
elseif m<2
    'No meaning for hessenberg! The reason may be m<2!'
end
    
