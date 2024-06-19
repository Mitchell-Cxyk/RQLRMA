function [out] = randncptQ(m,n)
%RANDCPTQ 此处显示有关此函数的摘要
%   此处显示详细说明


% Authors: Chao Chang, Yuning Yang (yyang@gxu.edu.cn,
%           yuning.yang1207@gmail.com)

% Reference:
% [1] Chao Chang, Yuning Yang, Randomized Large-Scale Quaternion Matrix Approximation:
%             Practical Rangefinders and One-Pass Algorithm, https://arxiv.org/pdf/2404.14783

out = [randn(m,n)+i*randn(m,n), randn(m,n)+i*randn(m,n)];
end

