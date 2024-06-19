function [Qc,Qa] = QcQa(Qq)
%COMPLEX_REPRESENTATION_Q  return compact complex representation Qc and 
% Qa = J\overline{Qc} from a full complex representation Qq
%   


% Authors: Chao Chang, Yuning Yang (yyang@gxu.edu.cn,
%           yuning.yang1207@gmail.com)

% Reference:
% [1] Chao Chang, Yuning Yang, Randomized Large-Scale Quaternion Matrix Approximation:
%             Practical Rangefinders and One-Pass Algorithm, https://arxiv.org/pdf/2404.14783

Ac = Qq.w+i*Qq.x;
Bc = Qq.y+i*Qq.z;

Qc = [Ac; -conj(Bc)]; Qa = [Bc; conj(Ac)];
end

