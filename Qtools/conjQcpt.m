function [q] = conjQcpt(q)
%CONJQCPT conjgate of the quaternion matrix Q  represented compactly as Q = [Q0 Q1]
%with Q = Q0 + Q1j
    if mod(size(q,2),2) == 1
        error('not a compact representation of a quaternion matrix')
    end
    q(:,1:end/2) = conj(q(:,1:end/2)); q(:,end/2+1:end) = -q(:,end/2+1:end);
end

