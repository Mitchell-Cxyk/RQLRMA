function [qt] = transQcpt(q)
%TRANSQCPT transpose of the quaternion matrix Q represented compactly as Q = [Q0 Q1]
%with Q = Q0 + Q1j

% Authors: Hanxin Ya, Yuning Yang (yyang@gxu.edu.cn,
%           yuning.yang1207@gmail.com)

% Reference:
% [1] Hanxin Ya, Ying Wang, Yuning Yang, On Quaternion Higher-Order Singular Value Decomposition: Models and Analysis
%           https://arxiv.org/abs/2309.05211

[m,n]=size(q);
if mod(n,2) == 1
    error('not a compact representation of a quaternion matrix')
end

qt = zeros(n/2,m*2);
qt(:,1:m) = q(:,1:n/2).'; qt(:,m+1:end) = q(:,n/2+1:end).';

end

