function [Jsym,Rsym,Ssym] =JRSsym(U)
% test JRS-symmetry of U
% by Zhigang Jia On May 14,2014
% J R  S are 
n=size(U,1)/4;
m=size(U,2)/4;
[Jn,Rn,Sn] =JRS(n);
[Jm,Rm,Sm] =JRS(m);
Jsym=norm(Jn*U*Jm'-U);
Rsym=norm(Rn*U*Rm'-U);
Ssym=norm(Sn*U*Sm'-U);

end

