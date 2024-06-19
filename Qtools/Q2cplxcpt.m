function [Cc] = Q2cplxcpt(Qq)
%COMPLEX_REPRESENTATION_Q compact complex representation of a quaternion matrix Qq
%   if Qq = q.w + i*q.x + j*q.y + k*q.z, then Cc = [Ac Bc], where 
% Ac = q.w+i*q.x; Bc = q.y+i*q.z;

% Authors: Chao Chang, Yuning Yang (yyang@gxu.edu.cn,
%           yuning.yang1207@gmail.com)

% Reference:
% [1] Chao Chang, Yuning Yang, Randomized Large-Scale Quaternion Matrix Approximation:
%             Practical Rangefinders and One-Pass Algorithm, https://arxiv.org/pdf/2404.14783

Ac = Qq.w+i*Qq.x;
Bc = Qq.y+i*Qq.z;
Cc = [Ac Bc];
end

