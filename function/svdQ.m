function [Uq,Sq,Vq] = svdQ(Qq)
   display('ComplexRepresentUsing...');
%
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

% initialization
%sz = size(Qq(:,:,1));
%Uq = zeros(sz(1),sz(1),4);
%Vq = zeros(sz(2),sz(2),4);

% computer svd of the equivalent complex matrix of Qq
Ac = Qq.w+i*Qq.x;
Bc = Qq.y+i*Qq.z;
Cc = [Ac Bc;-conj(Bc) conj(Ac)];
% Cc=[Ac -conj(Bc);Bc conj(Ac)];
[Uc, S, Vc] = svd(Cc,'econ');

% use the relationship between Cc and Qq to obtain Uq, Sq, and Vq
Uq.w = real(Uc(1:end/2,1:2:end));
Uq.x = imag(Uc(1:end/2,1:2:end));
Uq.y = real(-conj(Uc(end/2+1:end,1:2:end)));
Uq.z = imag(-conj(Uc(end/2+1:end,1:2:end)));
% Uq.w = real(Uc(1:end/2,1:2:end));
% Uq.x = imag(Uc(1:end/2,1:2:end));
% Uq.y = real(conj(Uc(end/2+1:end,1:2:end)));
% Uq.z = imag(conj(Uc(end/2+1:end,1:2:end)));
Uq=quaternion(Uq.w,Uq.x,Uq.y,Uq.z);


Vq.w = real(Vc(1:end/2,1:2:end));
Vq.x = imag(Vc(1:end/2,1:2:end));
Vq.y = real(-conj(Vc(end/2+1:end,1:2:end)));
Vq.z = imag(-conj(Vc(end/2+1:end,1:2:end)));
% Vq.w = real(Vc(1:end/2,1:2:end));
% Vq.x = imag(Vc(1:end/2,1:2:end));
% Vq.y = real((Vc(end/2+1:end,1:2:end)));
% Vq.z = imag((Vc(end/2+1:end,1:2:end)));
Vq=quaternion(Vq.w,Vq.x,Vq.y,Vq.z);

Sq=S(1:2:end,1:2:end);
end



