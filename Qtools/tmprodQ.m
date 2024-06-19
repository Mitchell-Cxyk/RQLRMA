function [T] = tmprodQ(T,U,mode,side,transpose)
%TMPROD Mode-n tensor-matrix product.
%   S = tmprod(T,U,mode) computes the tensor-matrix product of the tensor T
%   with the matrices U{1}, ..., U{N} along the modes mode(1), ...,
%   mode(N), respectively. Note that in this implementation, the vector
%   mode should contain distinct integers. The mode-n tensor-matrix
%   products are computed sequentially in a heuristically determined order.
%   A mode-n tensor-matrix product results in a new tensor S in which the
%   mode-n vectors of a given tensor T are premultiplied by a given matrix
%   U{n}, i.e., tens2mat(S,mode(n)) = U{n}*tens2mat(T,mode(n)).
%
%   S = tmprod(T,U,mode,'T') and tmprod(T,U,mode,'H') apply the mode-n
%   tensor-matrix product using the transposed matrices U{n}.' and
%   conjugate transposed matrices U{n}' respectively along mode(n).
%
%   [S,iperm] = tmprod(T,U,mode) and S = tmprod(T,U,mode,'saveperm') save
%   one permutation operation. In the former case, the tensor-matrix
%   product can then be recovered by permute(S,iperm).
%
%   See also tens2mat, mat2tens, contract.

% Authors: Hanxin Ya, Yuning Yang (yyang@gxu.edu.cn,
%           yuning.yang1207@gmail.com)

% Reference:
% [1] Hanxin Ya, Ying Wang, Yuning Yang, On Quaternion Higher-Order Singular Value Decomposition: Models and Analysis
%           https://arxiv.org/abs/2309.05211

n = length(U);
size_tens = size(T);

if ~iscell(U), U = {U}; end
if n ~= length(mode)
    error('tmprod:NumberOfProducts','length(U) should be length(mode).');
end
if n ~= length(side)
    error('tmprod:NumberOfProducts','length(U) should be length(side).');
end

modes = 1:ndims(T); 
if max(mode) > length(modes)
    modes = 1:max(mode);
    size_tens = ones(1,length(modes));
    size_tens(1:ndims(T)) = size(T);
end

for i = 1: n
    md = mode(i);
    sd = side{i};
    switch sd
        case 'l' 
            newmt = U{md}*tens2matQ(T,md,setdiff(modes,md));
            size_tens(md) = size(U{md},1);
            T = mat2tensQ(newmt,size_tens,md,setdiff(modes,md));
        case 'r' 
            newmt = tens2matQ(T,setdiff(modes,md),md)*U{md};
            size_tens(md) = size(U{md},2);
            T = mat2tensQ(newmt,size_tens,setdiff(modes,md),md);
    end
    
    
end








