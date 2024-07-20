
function [U,R]=qrQ(A)

%input the first block row of real presentation of quaternion matrix
%Q=A0+A1i+A2j+A3k

 %A=(A0,A2,A1,A3);
 
% output 
%R; %  is the upper triagular matrix 
%U=[U0 U2 U1 U3]; % is the first block row of real presentation of left
%singular vectors


% the relation:  A=UR


% Size of quaternion matrix Q  represented by A=(A0,A2,A1,A3)
A = [A.w,A.y,A.x,A.z];
[m,n]=size(A);
n=n/4;
mn=min(m,n);

% A into four blocks
A0=A(:,1:n);
A2=A(:,(n+1):(2*n));
A1=A(:,(2*n+1):(3*n));
A3=A(:,(3*n+1):(4*n));

% to save left and right transformation matrices 
U0=eye(m);
U1=zeros(m);
U2=zeros(m);
U3=zeros(m);

if mn>=2   
    for s=1:mn-2
    %% U
        %givens
        for t=s:m
            G1=GivensW(A0(t,s),A1(t,s),A2(t,s),A3(t,s));
            zz=G1'*[A0(t,s:n);-A2(t,s:n);-A1(t,s:n);-A3(t,s:n)];
            A0(t,s:n)= zz(1,:);
            A2(t,s:n)= -zz(2,:);
            A1(t,s:n)= -zz(3,:);
            A3(t,s:n)= -zz(4,:);
            %
            zz=[U0(:,t) U2(:,t) U1(:,t) U3(:,t)]*G1;
            U0(:,t)= zz(:,1);
            U2(:,t)= zz(:,2);
            U1(:,t)= zz(:,3);
            U3(:,t)= zz(:,4);   
        end
        %householder
        [u,bt]=HouseW(A0(s:m,s),m+1-s);
        A0(s:m,s:n)=A0(s:m,s:n)-(bt*u)*(u'*A0(s:m,s:n));
        A1(s:m,s:n)=A1(s:m,s:n)-(bt*u)*(u'*A1(s:m,s:n));
        A2(s:m,s:n)=A2(s:m,s:n)-(bt*u)*(u'*A2(s:m,s:n));
        A3(s:m,s:n)=A3(s:m,s:n)-(bt*u)*(u'*A3(s:m,s:n));
        %
        U0(:,s:m)=U0(:,s:m)-(bt*U0(:,s:m)*u)*(u');
        U1(:,s:m)=U1(:,s:m)-(bt*U1(:,s:m)*u)*(u');
        U2(:,s:m)=U2(:,s:m)-(bt*U2(:,s:m)*u)*(u');
        U3(:,s:m)=U3(:,s:m)-(bt*U3(:,s:m)*u)*(u');
        %
    
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% s=mn-1, for the -2 row and column
    %
    s=mn-1;
    %% U
    %givens
    for t= s:m
        G1=GivensW(A0(t,s),A1(t,s),A2(t,s),A3(t,s));
        zz=G1'*[A0(t,s:n);-A2(t,s:n);-A1(t,s:n);-A3(t,s:n)];
        A0(t,s:n)=zz(1,:);
        A2(t,s:n)= -zz(2,:);
        A1(t,s:n)= -zz(3,:);
        A3(t,s:n)= -zz(4,:);
        %
        zz=[U0(:,t) U2(:,t) U1(:,t) U3(:,t)]*G1;
        U0(:,t)= zz(:,1);
        U2(:,t)= zz(:,2);
        U1(:,t)= zz(:,3);
        U3(:,t)= zz(:,4); 
    end
    %householder
    [u,bt]=HouseW(A0(s:m,s),m+1-s);
    A0(s:m,s:n)=A0(s:m,s:n)-(bt*u)*(u'*A0(s:m,s:n));
    A1(s:m,s:n)=A1(s:m,s:n)-(bt*u)*(u'*A1(s:m,s:n));
    A2(s:m,s:n)=A2(s:m,s:n)-(bt*u)*(u'*A2(s:m,s:n));
    A3(s:m,s:n)=A3(s:m,s:n)-(bt*u)*(u'*A3(s:m,s:n));
    %
    U0(:,s:m)=U0(:,s:m)-(bt*U0(:,s:m)*u)*(u');
    U1(:,s:m)=U1(:,s:m)-(bt*U1(:,s:m)*u)*(u');
    U2(:,s:m)=U2(:,s:m)-(bt*U2(:,s:m)*u)*(u');
    U3(:,s:m)=U3(:,s:m)-(bt*U3(:,s:m)*u)*(u');

end % the end of  mn>=2 
% the following is also good for both the case mn=1  and the case mn>=2.

%% the last row or the last column.
    s=mn;
    %% U
    %givens
    for t= s:m
        G1=GivensW(A0(t,s),A1(t,s),A2(t,s),A3(t,s));
        zz=G1'*[A0(t,s:n);-A2(t,s:n);-A1(t,s:n);-A3(t,s:n)];
        A0(t,s:n)=zz(1,:);
        A2(t,s:n)= -zz(2,:);
        A1(t,s:n)= -zz(3,:);
        A3(t,s:n)= -zz(4,:);
        %
        zz=[U0(:,t) U2(:,t) U1(:,t) U3(:,t)]*G1;
        U0(:,t)= zz(:,1);
        U2(:,t)= zz(:,2);
        U1(:,t)= zz(:,3);
        U3(:,t)= zz(:,4);   
    end
     %householder
     if m>n
        [u,bt]=HouseW(A0(s:m,s),m+1-s);
        A0(s:m,n)=A0(s:m,n)-(bt*u)*(u'*A0(s:m,n));
        A1(s:m,n)=A1(s:m,n)-(bt*u)*(u'*A1(s:m,n));
        A2(s:m,n)=A2(s:m,n)-(bt*u)*(u'*A2(s:m,n));
        A3(s:m,n)=A3(s:m,n)-(bt*u)*(u'*A3(s:m,n));
        %
        %
        U0(:,s:m)=U0(:,s:m)-(bt*U0(:,s:m)*u)*(u');
        U1(:,s:m)=U1(:,s:m)-(bt*U1(:,s:m)*u)*(u');
        U2(:,s:m)=U2(:,s:m)-(bt*U2(:,s:m)*u)*(u');
        U3(:,s:m)=U3(:,s:m)-(bt*U3(:,s:m)*u)*(u');
     end
  

%% output
% R=[A0 A2 A1 A3];
% U=[U0 U2 U1 U3];
R = quaternion(A0,A1,A2,A3);
U = quaternion(U0,U1,U2,U3);


