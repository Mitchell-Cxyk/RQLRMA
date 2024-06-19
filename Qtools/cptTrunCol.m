function [cptQr] = cptTrunCol(cptQ,r)
%CPTTRUNCOL cptQ = [Q0, Q1], Q= Q0+Q1*j
% return the first r column of Q, 
% the output is still represented in the compact complex form

% Authors: Chao Chang, Yuning Yang (yyang@gxu.edu.cn,
%           yuning.yang1207@gmail.com)

% Reference:
% [1] Chao Chang, Yuning Yang, Randomized Large-Scale Quaternion Matrix Approximation:
%             Practical Rangefinders and One-Pass Algorithm, https://arxiv.org/pdf/2404.14783

cptQr = [cptQ(:,1:r), cptQ(:,end/2+1:end/2+r)];


end

