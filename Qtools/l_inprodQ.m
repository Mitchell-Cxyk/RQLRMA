function [in] = l_inprodQ(a,b)
%INPRODQ left inner product between two quaternion (multi)arrays 
% <a,b>_l = a.'* conj(b)

% Authors: Hanxin Ya, Yuning Yang (yyang@gxu.edu.cn,
%           yuning.yang1207@gmail.com)

% Reference:
% [1] Hanxin Ya, Ying Wang, Yuning Yang, On Quaternion Higher-Order Singular Value Decomposition: Models and Analysis
%           https://arxiv.org/abs/2309.05211

    in = a(:).'*conj(b(:));
 
end

