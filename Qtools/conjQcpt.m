function [q] = conjQcpt(q)
%CONJQCPT conjgate of the quaternion matrix Q  represented compactly as Q = [Q0 Q1]
%with Q = Q0 + Q1j


% Authors: Chao Chang, Yuning Yang (yyang@gxu.edu.cn,
%           yuning.yang1207@gmail.com)

% Reference:
% [1] Chao Chang, Yuning Yang, Randomized Large-Scale Quaternion Matrix Approximation:
%             Practical Rangefinders and One-Pass Algorithm, https://arxiv.org/pdf/2404.14783

    if mod(size(q,2),2) == 1
        error('not a compact representation of a quaternion matrix')
    end
    q(:,1:end/2) = conj(q(:,1:end/2)); q(:,end/2+1:end) = -q(:,end/2+1:end);
end

