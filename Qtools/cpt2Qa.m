function [Qa] = cpt2Qa(cptQ)
%CPT2QC cptQ = [Q0 Q1], Q = Q0+Q1*j
% Qc = [Q1;
%        conj(Q0)];

% Authors: Chao Chang, Yuning Yang (yyang@gxu.edu.cn,
%           yuning.yang1207@gmail.com)

% Reference:
% [1] Chao Chang, Yuning Yang, Randomized Large-Scale Quaternion Matrix Approximation:
%             Practical Rangefinders and One-Pass Algorithm, https://arxiv.org/pdf/2404.14783

Qa = [cptQ(:,end/2+1:end);  conj(cptQ(:,1:end/2) )];

end

