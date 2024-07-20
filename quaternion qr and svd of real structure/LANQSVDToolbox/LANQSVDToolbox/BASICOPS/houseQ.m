function [v,b]=houseQ(x)
% by Zhigang Jia On January 26,2015
n=length(x);
sg=x(2:n)'*x(2:n);

v=x;
v(1)=1;

tol=1e-14;

if sg<=tol
    b=0;
else
    a=sqrt(x(1)^2+sg);
    if x(1)<=0
        v(1)=x(1)-a;
    else
        v(1)=-sg/(x(1)+a);   
    end
    
    b=2*v(1)^2/(sg+v(1)^2);
    v=v/v(1);
end



