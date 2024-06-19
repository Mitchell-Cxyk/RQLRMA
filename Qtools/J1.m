function [j1] = J1(n)
% let Q be a quaternion matrix and its real representation be
% [Qw, ..., ..., ...;
%  Qx, ..., ..., ...;
%  Qy, ..., ..., ...;
%  Qz, ..., ..., ...]
% the first block is Qr, the second one is J1*Qr, the third is J2*Qr, the
% fourth is J3*Qr.

j1 = [
     0    -1     0     0;
     1     0     0     0;
     0     0     0     1;
     0     0    -1     0];

% Authors: Chao Chang, Yuning Yang (yyang@gxu.edu.cn,
%           yuning.yang1207@gmail.com)

% Reference:
% [1] Chao Chang, Yuning Yang, Randomized Large-Scale Quaternion Matrix Approximation:
%             Practical Rangefinders and One-Pass Algorithm, https://arxiv.org/pdf/2404.14783
 
j1 = kron(j1,eye(n));

end
