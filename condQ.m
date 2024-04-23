function [k] = condQ(A)
%COND Summary of this function goes here
%   Detailed explanation goes here
[~,S,~] = csvdQ(A); S = diag(S);
k = S(1)/S(end);
end

