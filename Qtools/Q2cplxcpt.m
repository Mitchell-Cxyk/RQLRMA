function [Cc] = Q2cplxcpt(Qq)
%COMPLEX_REPRESENTATION_Q compact complex representation of a quaternion matrix Qq
%   if Qq = q.w + i*q.x + j*q.y + k*q.z, then Cc = [Ac Bc], where 
% Ac = q.w+i*q.x; Bc = q.y+i*q.z;
Ac = Qq.w+i*Qq.x;
Bc = Qq.y+i*Qq.z;
Cc = [Ac Bc];
end

