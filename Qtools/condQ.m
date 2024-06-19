function [k] = condQ(A)
%COND computing the condition number of a quaternion matrix A using the
%fact that
%% sigma_max(A) = sigma_max(chi_A) and sigma_min(A) = sigma_min(chi_A)

% Authors: Chao Chang, Yuning Yang (yyang@gxu.edu.cn,
%           yuning.yang1207@gmail.com)

% Reference:
% [1] Chao Chang, Yuning Yang, Randomized Large-Scale Quaternion Matrix Approximation:
%             Practical Rangefinders and One-Pass Algorithm, https://arxiv.org/pdf/2404.14783

k = cond(Q2cplx(A));
end

