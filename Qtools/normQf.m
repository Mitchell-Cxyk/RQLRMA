function [out] = normQf(A)
% the Frobenius norm of a quaternion matrix A

% Authors: Chao Chang, Yuning Yang (yyang@gxu.edu.cn,
%           yuning.yang1207@gmail.com)

% Reference:
% [1] Chao Chang, Yuning Yang, Randomized Large-Scale Quaternion Matrix Approximation:
%             Practical Rangefinders and One-Pass Algorithm, https://arxiv.org/pdf/2404.14783

if ~isempty(A.w)
    out = sqrt(norm(A.w,'fro')^2 + norm(A.x,'fro')^2 + norm(A.y,'fro')^2 + norm(A.z,'fro')^2  );
else
    out = sqrt(norm(A.x,'fro')^2 + norm(A.y,'fro')^2 + norm(A.z,'fro')^2 );
end

