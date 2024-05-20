function [Qc] = Q2Qc(Qq)
%COMPLEX_REPRESENTATION_Q complex representation of a quaternion matrix Qq
%   
Ac = Qq.w+i*Qq.x;
Bc = Qq.y+i*Qq.z;
 

Qc = [Ac; -conj(Bc)];  
end

