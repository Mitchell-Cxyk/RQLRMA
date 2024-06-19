function [q] = mtimesQcpt(l,r)
%MYMTIMESQ products of two quaternion matrix l,r, which are represented in
%their compact complex representations
% the result is also represented as a compact complex matrix
% q = [q0 q1], quaternionQ = q0 + q1*j
% l = [l0 l1] r = [r0 r1]
% the col size of l0 should be equal to the row size of r0

% Authors: Chao Chang, Yuning Yang (yyang@gxu.edu.cn,
%           yuning.yang1207@gmail.com)

% Reference:
% [1] Chao Chang, Yuning Yang, Randomized Large-Scale Quaternion Matrix Approximation:
%             Practical Rangefinders and One-Pass Algorithm, https://arxiv.org/pdf/2404.14783

if size(l,2)/2 ~= size(r,1)
    error('the half of the column size of l should be equal to the row size of r')
end
            
        q = zeros(size(l,1),size(r,2));  % q= [q0 q1]
        
%         l0 = l(:,1:end/2); l1 = l(:,end/2+1:end); 
%         r0 = r(:,1:end/2); r1 = r(:,end/2+1:end); 
  %      q0 = l0*r0 - l1*conj(r1); q1  =l0*r1 + l1*conj(r0);
        q(:,1:end/2) = l(:,1:end/2)*r(:,1:end/2) - l(:,end/2+1:end)*conj(r(:,end/2+1:end));
        q(:,end/2+1:end) = l(:,1:end/2)*r(:,end/2+1:end) + l(:,end/2+1:end)*conj(r(:,1:end/2));
end

