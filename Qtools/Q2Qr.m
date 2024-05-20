function [Qr] = Q2Qr(Qq)
%COMPLEX_REPRESENTATION_Q compact real representation of a quaternion
%matrix Qq: the first block column of Gamma_Q
%   
 
Qr = [Qq.w; Qq.x; Qq.y; Qq.z];
end

