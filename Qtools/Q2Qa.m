function [Qa] = Q2Qa(Qq)
% convert quaternion class Qq to the adjoit of conjugate of the compact
% complex representation: Qa = J\overline{Qc}
%   
 
% Authors: Chao Chang, Yuning Yang (yyang@gxu.edu.cn,
%           yuning.yang1207@gmail.com)

% Reference:
% [1] Chao Chang, Yuning Yang, Randomized Large-Scale Quaternion Matrix Approximation:
%             Practical Rangefinders and One-Pass Algorithm, https://arxiv.org/pdf/2404.14783

Ac = Qq.w+i*Qq.x;
Bc = Qq.y+i*Qq.z;

  Qa = [Bc; conj(Ac)];
end

