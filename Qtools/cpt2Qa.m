function [Qa] = cpt2Qa(cptQ)
%CPT2QC cptQ = [Q0 Q1], Q = Q0+Q1*j
% Qc = [Q1;
%        conj(Q0)];

Qa = [cptQ(:,end/2+1:end);  conj(cptQ(:,1:end/2) )];

end

