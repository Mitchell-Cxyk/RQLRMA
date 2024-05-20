function [cptQr] = cptTrunCol(cptQ,r)
%CPTTRUNCOL cptQ = [Q0, Q1], Q= Q0+Q1*j
% return the first r column of Q, 
% the output is still represented in the compact complex form

cptQr = [cptQ(:,1:r), cptQ(:,end/2+1:end/2+r)];


end

