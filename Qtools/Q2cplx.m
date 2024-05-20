function [Cc] = Q2cplx(Qq)
%COMPLEX_REPRESENTATION_Q complex representation of a quaternion matrix Qq
%   
Ac = Qq.w+i*Qq.x;
Bc = Qq.y+i*Qq.z;
Cc = [Ac Bc;-conj(Bc) conj(Ac)];
end

