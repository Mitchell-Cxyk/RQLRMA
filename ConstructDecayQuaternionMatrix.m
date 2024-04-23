function CDQM=ConstructDecayQuaternionMatrix(m,n,decayRate,startFlag)
u=randq(m,1);
u=u/norm(u,2);
%u'*u
v=randq(n,1);
v=v/norm(v,2);
U=quaternion(eye(m),zeros(m),zeros(m),zeros(m))-2*u*u';
V=quaternion(eye(n),zeros(n),zeros(n),zeros(n))-2*v*v';
S=zeros(m,n);%initialize the singular value matrix.
for i=1:startFlag
    S(i,i)=1;
end
for i=startFlag+1:min(m,n)
    S(i,i)=S(i-1,i-1)*decayRate;
end
CDQM=U*S*V;