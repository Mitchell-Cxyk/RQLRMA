function [Q] = realR2Q(real_Q)
%COMPLEX2Q convert the compact real representation of a quaternion matrix back
%to itself


% Authors: Chao Chang, Yuning Yang (yyang@gxu.edu.cn,
%           yuning.yang1207@gmail.com)

% Reference:
% [1] Chao Chang, Yuning Yang, Randomized Large-Scale Quaternion Matrix Approximation:
%             Practical Rangefinders and One-Pass Algorithm, https://arxiv.org/pdf/2404.14783

    [m,~] = size(real_Q);
    if mod(m,4) == 1  
        error('the input is not a full real representation of a quaternion matrix')
    end
    
    Q0 = real_Q(1:m/4,:); Q1 = real_Q(m/4+1:m/2, :); 
    Q2 = real_Q(m/2+1: 3*m/4,:); Q3 = real_Q(3*m/4+1:end,:);
    Q = quaternion(Q0,Q1,Q2,Q3);
end