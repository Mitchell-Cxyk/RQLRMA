function [Q] = real2Q(real_Q)
%COMPLEX2Q convert the full real representation of a quaternion matrix back
%to quaternion class

    [m,n] = size(real_Q);
    if mod(m,4) == 1 || mod(n,4) == 1
        error('the input is not a full real representation of a quaternion matrix')
    end
    
    Q0 = real_Q(1:m/4,1:n/4); Q1 = real_Q(m/4+1:m/2, 1:n/4); 
    Q2 = real_Q(m/2+1: 3*m/4,1:n/4); Q3 = real_Q(3*m/4+1:end,1:n/4);
    Q = quaternion(Q0,Q1,Q2,Q3);
end