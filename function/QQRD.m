function [Q,R]=QQRD(A)

m=size(A,1);
n=size(A,2);
mn=min(m,n);
B1=[A.w;-A.y;-A.x;-A.z];
 Q=[eye(m),zeros(m,3*m)];
for s=1:n
    x=B1([s:m,(s+m):2*m,(s+2*m):3*m,(s+3*m):4*m],s:n);
    
    for t=1:size(x,1)/4
        G=GRSGivens(x(t,1)/4,x(t+size(x,1)/4,1),x(t+2*size(x,1)/4,1),x(t+3*size(x,1)/4,1));
        x([t,t+size(x,1)/4,t+2*size(x,1)/4,t+3*size(x,1)/4],1:size(x,2))=G'*x([t,t+size(x,1)/4,t+2*size(x,1)/4,t+3*size(x,1)/4],1:size(x,2));
    end
    [u,bt]=HouseW(x(:,1),4*(m+1-s));
        H1=(eye(4*(m+1-s))-bt*u*u');
        
    
    
    
    %H3=G*H1;
    B1([s:m,(s+m):2*m,(s+2*m):3*m,(s+3*m):4*m],s:n)=H1*x;
%     T(1:m,[s:m,s+m:2*m,s+2*m:3*m,s+3*m:4*m])=T(1:m,[s:m,s+m:2*m,s+2*m:3*m,s+3*m:4*m])*H3;
end
R0=B1(1:m,1:n);
R1 = -B1(1 + 2 * m : 3 * m, 1 : n);
R2 =-B1(1 + m : 2 * m, 1 : n);
R3 = -B1(1 + 3 * m : 4 * m, 1 : n);
% Q0 = T (1 : m, 1 : m);
% Q1 = T (1 : m, 1 + 2 * m : 3 * m);
% Q2 = T (1 : m, 1 + m : 2 * m);
% Q3 = T (1 : m, 1 + 3 * m : 4 * m);
% Q=quaternion(Q0,Q1,Q2,Q3);
R=quaternion(R0,R1,R2,R3);
Q=QLEQL(A,R);