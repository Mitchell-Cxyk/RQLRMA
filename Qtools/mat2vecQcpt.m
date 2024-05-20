function [vq] = mat2vecQcpt(q)
%TENS2VECQCPT column vectorization of a quaternion matrix represented compactly as
%Q = [Q0 Q1] with Q = Q0 + Q1j
if mod(size(q,2),2) == 1
    error('not a compact representation of a quaternion matrix')
end
[m, n] = size(q);
vq = [reshape(q(:,1:n/2),m*n/2,1) reshape(q(:,n/2+1:end),m*n/2,1)];

end

