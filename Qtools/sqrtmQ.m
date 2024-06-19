function [sqrtA,resnorm,cond_sqrtChiA] = sqrtmQ(A)
% compute the square root of a Hermitian quaternion matrix using its
% complex representation

% Authors: Chao Chang, Yuning Yang (yyang@gxu.edu.cn,
%           yuning.yang1207@gmail.com)

% Reference:
% [1] Chao Chang, Yuning Yang, Randomized Large-Scale Quaternion Matrix Approximation:
%             Practical Rangefinders and One-Pass Algorithm, https://arxiv.org/pdf/2404.14783

chiA = Q2cplx(A); 

if nargout == 1
    sqrtChiA = sqrtm(chiA);
elseif nargout == 2
    [sqrtChiA,resnorm] = sqrtm(chiA); 
else
[sqrtChiA,resnorm,cond_sqrtChiA] = sqrtm(chiA); 
end

sqrtA = cplx2Q(sqrtChiA);

end

 