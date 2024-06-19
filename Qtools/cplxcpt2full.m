function [fq] = cplxcpt2full(q)
%CPLXCPT2FULL compacted complex representation of a quaternion matrix q =
%[q0 q1] with q = q0+q1j to its full complex representation [q0 q1 ;
%-conj(q1) conj(q0)]

% Authors: Chao Chang, Yuning Yang (yyang@gxu.edu.cn,
%           yuning.yang1207@gmail.com)

% Reference:
% [1] Chao Chang, Yuning Yang, Randomized Large-Scale Quaternion Matrix Approximation:
%             Practical Rangefinders and One-Pass Algorithm, https://arxiv.org/pdf/2404.14783

if mod(size(q,2),2) == 1
    error('not a compact representation of a quaternion matrix')
end

fq = [q; -conj(q(:,end/2+1:end)) conj(q(:,1:end/2))];
end

