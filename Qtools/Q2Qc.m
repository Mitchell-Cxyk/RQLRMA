function [Qc] = Q2Qc(Qq)
%COMPLEX_REPRESENTATION_Q complex representation of a quaternion matrix Qq
% convert the quaternion matrix Qq to its compact complex representation (Qq)_c

% Authors: Chao Chang, Yuning Yang (yyang@gxu.edu.cn,
%           yuning.yang1207@gmail.com)

% Reference:
% [1] Chao Chang, Yuning Yang, Randomized Large-Scale Quaternion Matrix Approximation:
%             Practical Rangefinders and One-Pass Algorithm, https://arxiv.org/pdf/2404.14783


Ac = Qq.w+i*Qq.x;
Bc = Qq.y+i*Qq.z;
 

Qc = [Ac; -conj(Bc)];  
end

