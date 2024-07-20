function [T,D]=tridiagQ(A)
% function [T,A]=tridiagQ(A). Tridiagnalize the Hermitian quaternion matrix.
%Input:
%A=(A0,A2,A1,A3)--Hermitian quaternion matrix Q=A0+A1i+A2j+A3k;
 
%Output:
%D---the tridiagonal matrix which is similar to Q
%T=[T0 T2 T1 T3]; % unitary quaternion tranformation  T
% satisfying:A=T*D*T'
% References:

% Z. Jia, M. Wei, and S. Ling. A New Structure-Preserving Method for
%  ``Quaternion Hermitian Eigenvalue Problems''. J. Comput. Appl. Math.,
%  239:12-24,  2013.
%

%by Zhigang Jia, 2012, 2015


n=size(A,1);
A0=A(:,1:n);
A1=A(:,2*n+1:3*n);
A2=A(:,n+1:2*n);
A3=A(:,3*n+1:4*n);

% T=[T0 T2 T1 T3]
T0=eye(n);
T1=zeros(n);
T2=zeros(n);
T3=zeros(n);


for k=1:n-1
    for i=k+1:n
            t=GivensW(A0(i,k),A1(i,k),A2(i,k),A3(i,k));
            GA=[A0([k:i-1,i+1:n],i),A2([k:i-1,i+1:n],i),A1([k:i-1,i+1:n],i),A3([k:i-1,i+1:n],i)]*t;
            A0([k:i-1,i+1:n],i)=GA(:,1);
            A2([k:i-1,i+1:n],i)=GA(:,2);
            A1([k:i-1,i+1:n],i)=GA(:,3);
            A3([k:i-1,i+1:n],i)=GA(:,4);
                     
 
            A0(i,[k:i-1,i+1:n])=GA(:,1)';
            A2(i,[k:i-1,i+1:n])=-GA(:,2)';
            A1(i,[k:i-1,i+1:n])=-GA(:,3)';
            A3(i,[k:i-1,i+1:n])=-GA(:,4)';
                  
% transformation matrix T=[T0 T2 T1 T3]

            GA=[T0(:,i),T2(:,i),T1(:,i),T3(:,i)]*t;
            T0(:,i)=GA(:,1);
            T2(:,i)=GA(:,2);
            T1(:,i)=GA(:,3);
            T3(:,i)=GA(:,4);    
    end  
   
    [v,b]=gallery('house',A0(k+1:n,k));
    u=A0(k+1:n,k)-b*(v'*A0(k+1:n,k))*v; 
    A0(k+1:n,k)=u;
    A0(k,k+1:n)=u';
      
    u=b*(A0(k+1:n,k+1:n)*v); 
    w=u-(b*(u'*v)/2)*v;
    z=v*w';
    A0(k+1:n,k+1:n)=A0(k+1:n,k+1:n)-z-z';  
%          
    u=b*(A2(k+1:n,k+1:n)*v);
    w=u*v';
    A2(k+1:n,k+1:n)=A2(k+1:n,k+1:n)+w'-w+((b*(v'*u))*v)*v';
%     
    u=b*(A1(k+1:n,k+1:n)*v);
    w=u*v';
    A1(k+1:n,k+1:n)=A1(k+1:n,k+1:n)+w'-w+((b*(v'*u))*v)*v';
% 
    u=b*(A3(k+1:n,k+1:n)*v);
    w=u*v';
    A3(k+1:n,k+1:n)=A3(k+1:n,k+1:n)+w'-w+((b*(v'*u))*v)*v';
%
    T0(:, k+1:n)=T0(:, k+1:n)-(T0(:, k+1:n)*(b*v))*v';
    T2(:, k+1:n)=T2(:, k+1:n)-(T2(:, k+1:n)*(b*v))*v';
    T1(:,k+1:n)=T1(:,k+1:n)-(T1(:,k+1:n)*(b*v))*v';
    T3(:,k+1:n)=T3(:,k+1:n)-(T3(:,k+1:n)*(b*v))*v';
end   

%% output
D=A0;
T=[T0 T2 T1 T3];

