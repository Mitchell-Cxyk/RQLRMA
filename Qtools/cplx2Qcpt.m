function [Q] = cplx2Qcpt(cplx_Q)
%COMPLEX2Q convert the compact complex representation of a quaternion matrix back
%to itself, i.e., if cplx_Q = [q01 q23], q01 = q0 + q1i, q23 = q2 + q3i,
%then Q= q0 + q1i + q2j + q3k;

% Authors: Chao Chang, Yuning Yang (yyang@gxu.edu.cn,
%           yuning.yang1207@gmail.com)

% Reference:
% [1] Chao Chang, Yuning Yang, Randomized Large-Scale Quaternion Matrix Approximation:
%             Practical Rangefinders and One-Pass Algorithm, https://arxiv.org/pdf/2404.14783

     if  mod(size(cplx_Q),2) == 1
        error('the input is not a compact complex representation of a quaternion matrix')
    end
    
    Q01 = cplx_Q(:,1:end/2); Q23 = cplx_Q(:,end/2+1:end);
    Q = quaternion(real(Q01),imag(Q01),real(Q23),imag(Q23));
end