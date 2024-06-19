function [Qq] = Qr2Q(Qr)
%COMPLEX_REPRESENTATION_Q convert compact real representation back to a
% full real representation of a quaternion Q
%   
 
% Authors: Chao Chang, Yuning Yang (yyang@gxu.edu.cn,
%           yuning.yang1207@gmail.com)

% Reference:
% [1] Chao Chang, Yuning Yang, Randomized Large-Scale Quaternion Matrix Approximation:
%             Practical Rangefinders and One-Pass Algorithm, https://arxiv.org/pdf/2404.14783

n = size(Qr,1)/4;

 Qq = [Qr, J1(n)*Qr, J2(n)*Qr, J3(n)*Qr];
end

