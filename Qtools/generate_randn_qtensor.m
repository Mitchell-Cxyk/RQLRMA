function [qt] = generate_randn_qtensor(sz_tens)
% generate a quaternion tensor with every entry being standard Gaussian

% Authors: Hanxin Ya, Yuning Yang (yyang@gxu.edu.cn,
%           yuning.yang1207@gmail.com)

% Reference:
% [1] Hanxin Ya, Ying Wang, Yuning Yang, On Quaternion Higher-Order Singular Value Decomposition: Models and Analysis
%           https://arxiv.org/abs/2309.05211

    qt = quaternion(randn(sz_tens),randn(sz_tens),randn(sz_tens),randn(sz_tens));  
end

