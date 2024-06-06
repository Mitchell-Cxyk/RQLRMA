function [Uq,Sq,Vq] = csvdQ(Qq)
% Note: naive implementation of computing QSVD via computing complex svd of Chi_Q
% not always correct: when Q has duplicated singular values it does not
% give the correct U and V (not orthonormal and do not span the correct
% range)
%% ModifiedcsvdQ77 is the correction of this method
   % display('ComplexRepresentUsing...');
% 
% Note: The following are described by the researchers who made this
% function.

% GENERAL DESCRIPTION
% Quaternionic Singular Value Decomposition
% [Uq,Sq,Vq] = qsvd(Qq) produces a diagonal matrix Sq of the same dimension as the real 
% part of a quaternionic matrix Qq, with nonnegative diagonal elements in decreasing 
% order, and quaternionic unitary matrices Uq and Vq so that Qq = Uq*Sq*Vq'.
%
% ABOUT
% Create:               14 Mar. 2008
% Last Update:       14 Mar. 2008
% Reversion:           1.0
%
% AUTHOR            Lu, Wei
%
% AFFILIATION	Institute of Image Communication and Information Processing,
%                           Shanghai Jiao Tong University, China
% 
% Mailto:               learza2008@gmail.com 
% 
% REFERENCE       F. Zhang, "Quaternions and matrices of Quaternions," in
%                           Linear Algebra and Its Applications, 1997, pp. 21-57.

 

% computer svd of the equivalent complex matrix of Qq
Ac = Qq.w+i*Qq.x;
Bc = Qq.y+i*Qq.z;
Cc = [Ac Bc;-conj(Bc) conj(Ac)];
[Uc, S, Vc] = svd(Cc,'econ');

% use the relationship between Cc and Qq to obtain Uq, Sq, and Vq
Uq.w = real(Uc(1:end/2,1:2:end));
Uq.x = imag(Uc(1:end/2,1:2:end));
Uq.y = real(-conj(Uc(end/2+1:end,1:2:end)));
Uq.z = imag(-conj(Uc(end/2+1:end,1:2:end)));
Uq=quaternion(Uq.w,Uq.x,Uq.y,Uq.z);


Vq.w = real(Vc(1:end/2,1:2:end));
Vq.x = imag(Vc(1:end/2,1:2:end));
Vq.y = real(-conj(Vc(end/2+1:end,1:2:end)));
Vq.z = imag(-conj(Vc(end/2+1:end,1:2:end)));
Vq=quaternion(Vq.w,Vq.x,Vq.y,Vq.z);

Sq=S(1:2:end,1:2:end);
end



