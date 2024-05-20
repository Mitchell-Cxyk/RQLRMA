function [Qc,Qa] = QcQa(Qq)
%COMPLEX_REPRESENTATION_Q  return compact complex representation Qc and 
% Qa = J\overline{Qc} from a full complex representation Qq
%   
Ac = Qq.w+i*Qq.x;
Bc = Qq.y+i*Qq.z;

Qc = [Ac; -conj(Bc)]; Qa = [Bc; conj(Ac)];
end

