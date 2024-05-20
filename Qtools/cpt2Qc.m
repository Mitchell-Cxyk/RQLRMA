function [Qc] = cpt2Qc(cptQ)
%CPT2QC cptQ = [Q0 Q1], Q = Q0+Q1*j
% Qc = [Q0;
%        -conj(Q1)];

Qc = [cptQ(:,1:end/2); -conj( cptQ(:,end/2+1:end)  )];


end

