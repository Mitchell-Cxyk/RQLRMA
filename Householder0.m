function [u0,t0]=Householder0(x,n)
u0=x;
a1=norm(x);
if u0(1)>=0
    u0(1)=u0(1)+a1;
    t0=1/(u0(1)*a1);
else
    u0(1)=u0(1)-a1;
    t0=1/(u0(1)*a1);
end