function [Q] = cplx2Qcpt(cplx_Q)
%COMPLEX2Q convert the compact complex representation of a quaternion matrix back
%to itself, i.e., if cplx_Q = [q01 q23], q01 = q0 + q1i, q23 = q2 + q3i,
%then Q= q0 + q1i + q2j + q3k;

     if  mod(size(cplx_Q),2) == 1
        error('the input is not a compact complex representation of a quaternion matrix')
    end
    
    Q01 = cplx_Q(:,1:end/2); Q23 = cplx_Q(:,end/2+1:end);
    Q = quaternion(real(Q01),imag(Q01),real(Q23),imag(Q23));
end