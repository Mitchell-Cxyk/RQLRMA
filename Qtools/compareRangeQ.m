function [res] = compareRangeQ(Y,H)
%COMPARERANGEQ compare the range of two quaternion matrices Y and H of the
%same size using complex representation
% using Frobenius norm

% Authors: Chao Chang, Yuning Yang (yyang@gxu.edu.cn,
%           yuning.yang1207@gmail.com)

% Reference:
% [1] Chao Chang, Yuning Yang, Randomized Large-Scale Quaternion Matrix Approximation:
%             Practical Rangefinders and One-Pass Algorithm, https://arxiv.org/pdf/2404.14783

    [uY,~,~] = svd(Q2cplx(Y),0);
    [uH,~,~] = svd(Q2cplx(H),0);

   res= norm(uY*uY'-uH*uH','fro');

end

