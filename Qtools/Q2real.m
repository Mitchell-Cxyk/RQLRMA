function [Rr] = Q2real(Qq)
%COMPLEX_REPRESENTATION_Q real representation of a quaternion matrix Qq
%   convert the quaternion matrix Qq to its full real representation
%   Upsilon_Qq

% Authors: Chao Chang, Yuning Yang (yyang@gxu.edu.cn,
%           yuning.yang1207@gmail.com)

% Reference:
% [1] Chao Chang, Yuning Yang, Randomized Large-Scale Quaternion Matrix Approximation:
%             Practical Rangefinders and One-Pass Algorithm, https://arxiv.org/pdf/2404.14783

Q0 = Qq.w; Q1 = Qq.x; Q2 = Qq.y; Q3 = Qq.z;

Rr = [Q0, -Q1, -Q2, -Q3;
    Q1, Q0, -Q3, Q2;
    Q2, Q3, Q0, -Q1;
    Q3, -Q2, Q1, Q0];

end

