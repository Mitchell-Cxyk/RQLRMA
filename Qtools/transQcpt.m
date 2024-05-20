function [qt] = transQcpt(q)
%TRANSQCPT transpose of the quaternion matrix Q represented compactly as Q = [Q0 Q1]
%with Q = Q0 + Q1j

[m,n]=size(q);
if mod(n,2) == 1
    error('not a compact representation of a quaternion matrix')
end

qt = zeros(n/2,m*2);
qt(:,1:m) = q(:,1:n/2).'; qt(:,m+1:end) = q(:,n/2+1:end).';

end

