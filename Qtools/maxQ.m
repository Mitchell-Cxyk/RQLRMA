function maxQ=maxQ(A)

% finding the largest entry of the quaternion matrix Q = A^*A

% Authors: Chao Chang, Yuning Yang (yyang@gxu.edu.cn,
%           yuning.yang1207@gmail.com)

% Reference:
% [1] Chao Chang, Yuning Yang, Randomized Large-Scale Quaternion Matrix Approximation:
%             Practical Rangefinders and One-Pass Algorithm, https://arxiv.org/pdf/2404.14783

normA=normq(A);
maxQ=max(normA,[],'all');