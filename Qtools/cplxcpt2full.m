function [fq] = cplxcpt2full(q)
%CPLXCPT2FULL compacted complex representation of a quaternion matrix q =
%[q0 q1] with q = q0+q1j to its full complex representation [q0 q1 ;
%-conj(q1) conj(q0)]
if mod(size(q,2),2) == 1
    error('not a compact representation of a quaternion matrix')
end

fq = [q; -conj(q(:,end/2+1:end)) conj(q(:,1:end/2))];
end

