function [Q] = Qc2Q(Qc)
% convert the compact complex representation back to quaternion class

% Authors: Chao Chang, Yuning Yang (yyang@gxu.edu.cn,
%           yuning.yang1207@gmail.com)

% Reference:
% [1] Chao Chang, Yuning Yang, Randomized Large-Scale Quaternion Matrix Approximation:
%             Practical Rangefinders and One-Pass Algorithm, https://arxiv.org/pdf/2404.14783


    Q0 = Qc(1:end/2,:);
    Q1 = -conj(Qc(end/2+1:end,:));
    Q = quaternion(real(Q0),imag(Q0),real(Q1),imag(Q1) );
end

