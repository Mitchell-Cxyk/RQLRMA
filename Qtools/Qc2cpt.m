function [cptQ] = Qc2cpt(Qc)
%QC2CPT Q = Q0+Q1*j, Qc= [Q0; -conj(Q1)];
% cptQ= [Q0, Q1];

cptQ = [Qc(1:end/2,:),   -conj(Qc(end/2+1:end,:))];
end

