function [Q] = cplx2Q(cplx_Q)
%COMPLEX2Q convert the full complex representation of a quaternion matrix back
%to the quaternion class

    [m,n] = size(cplx_Q);
    if mod(m,2) == 1 || mod(n,2) == 1
        error('the input is not a complex representation of a quaternion matrix')
    end
    
    Q01 = cplx_Q(1:m/2,1:n/2); Q23 = cplx_Q(1:m/2,n/2+1:end);
    Q = quaternion(real(Q01),imag(Q01),real(Q23),imag(Q23));
end

