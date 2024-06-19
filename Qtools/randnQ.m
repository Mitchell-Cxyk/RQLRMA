function [qt] = randnQ(sz_tens)
% generate a quaternion tensor with every entry being N(0,1)

% usage: qt = randnQ([10 10 10]);

% Authors: Chao Chang, Yuning Yang (yyang@gxu.edu.cn,
%           yuning.yang1207@gmail.com)

% Reference:
% [1] Chao Chang, Yuning Yang, Randomized Large-Scale Quaternion Matrix Approximation:
%             Practical Rangefinders and One-Pass Algorithm, https://arxiv.org/pdf/2404.14783

    qt = quaternion(randn(sz_tens),randn(sz_tens),randn(sz_tens),randn(sz_tens));  
end

