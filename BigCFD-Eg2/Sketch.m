
if exist('DataQ','var')
    clearvars -except DataQ;
else
    clearvars;
    load('DataQ.mat');
end

Omega_size=60;Psi_size=120;
Omega=ConstructTestMatrix(size(DataQ,2),Omega_size,'Gaussian','entry');
Psi=ConstructTestMatrix(Psi_size,size(DataQ,1),'Gaussian','entry');
[Y,W]=ConstructSketch(DataQ,Omega,Psi);
clear Omega;