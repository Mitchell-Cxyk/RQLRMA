function [Q,R] = mgs_nla(A)
[m,n] = size(A);
% Q = A; R=zerosq(n);
Q = A; R=zeros(n);
for k = 1:n
    R(k,k) = norm(Q(:,k));
    Q(:,k) = Q(:,k)/R(k,k);
    R(k,k+1:n) = Q(:,k)'*Q(:,k+1:n);
    Q(:,k+1:n) = Q(:,k+1:n) - Q(:,k)*R(k,k+1:n);
end
