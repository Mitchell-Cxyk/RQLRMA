function [qct] = conjtransQcpt(q)
%CONJTRANSQCPT conjugate transpose of the quaternion matrix Q represented compactly as Q = [Q0 Q1]
%with Q = Q0 + Q1j
% the result is also represented as the compact complex form

% Authors: Chao Chang, Yuning Yang (yyang@gxu.edu.cn,
%           yuning.yang1207@gmail.com)

% Reference:
% [1] Chao Chang, Yuning Yang, Randomized Large-Scale Quaternion Matrix Approximation:
%             Practical Rangefinders and One-Pass Algorithm, https://arxiv.org/pdf/2404.14783

[m,n]=size(q);
if mod(n,2) == 1
    error('not a compact representation of a quaternion matrix')
end


    qct = zeros(n/2,m*2);
    qct(:,1:m) = q(:,1:n/2)'; qct(:,m+1:end) = - q(:,n/2+1:end).';
end

