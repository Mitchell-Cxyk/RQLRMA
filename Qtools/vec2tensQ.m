function [T] = vec2tensQ(vt,size_tens)
%VEC2TENS 此处显示有关此函数的摘要
%   此处显示详细说明


% Authors: Hanxin Ya, Yuning Yang (yyang@gxu.edu.cn,
%           yuning.yang1207@gmail.com)

% Reference:
% [1] Hanxin Ya, Ying Wang, Yuning Yang, On Quaternion Higher-Order Singular Value Decomposition: Models and Analysis
%           https://arxiv.org/abs/2309.05211

    T = reshape(vt,size_tens);
end

