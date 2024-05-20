function [f] = frobQcpt(q)
%FROBQCPT F-norm of the quaternion matrix Q represented compactly as Q = [Q0 Q1]
%with Q = Q0 + Q1j
if mod(size(q,2),2) == 1
    error('not a compact representation of a quaternion matrix')
end

f = norm(q(:),'fro');
end

