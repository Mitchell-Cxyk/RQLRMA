function [Uq,Sq,Vq] = svdQ(Qq)
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

% computer svd of the equivalent complex matrix of Qq
[Uc, S, Vc] = svd(full(Qq),'econ');

% use the relationship between Cc and Qq to obtain Uq, Sq, and Vq
Uq = myquaternion(Uc(1:end/2,1:2:end), -conj(Uc(end/2+1:end,1:2:end)));
Vq = myquaternion(Vc(1:end/2,1:2:end), -conj(Vc(end/2+1:end,1:2:end)));
Sq=S(1:2:end,1:2:end);
end



