function [Qr] = Q2Qr(Qq)
%COMPLEX_REPRESENTATION_Q compact real representation of a quaternion
%matrix Qq: the first block column of Gamma_Q
%   


% Authors: Chao Chang, Yuning Yang (yyang@gxu.edu.cn,
%           yuning.yang1207@gmail.com)

% Reference:
% [1] Chao Chang, Yuning Yang, Randomized Large-Scale Quaternion Matrix Approximation:
%             Practical Rangefinders and One-Pass Algorithm, https://arxiv.org/pdf/2404.14783
 
Qr = [Qq.w; Qq.x; Qq.y; Qq.z];
end

