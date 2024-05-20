function [Qa] = Q2Qa(Qq)
% convert quaternion class Qq to the adjoit of conjugate of the compact
% complex representation: Qa = J\overline{Qc}
%   
 
Ac = Qq.w+i*Qq.x;
Bc = Qq.y+i*Qq.z;

  Qa = [Bc; conj(Ac)];
end

