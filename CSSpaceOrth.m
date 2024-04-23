% clear;clc;

% function UU=CSSpaceOrth(U)
ee=1e-2;
A=GenerateLowRankPlusExpDecay(100,50,1,'mid');
AA=Q2cplx(A);
[U,S,V]=svd(AA,0);
m=size(U,1);n=size(U,2);
Um=zeros(m,n);
Um(:,1)=U(:,1);
Um(:,2)=Qc2Qa(U(:,1));
index=2:n;
for iter1=2:n/2
    for iter2=index
        tmp=Qc2Qa(U(:,iter2))-Um(:,1:2*iter1-2)*(Um(:,1:2*iter1-2)'*Qc2Qa(U(:,iter2)));
        normtmp=norm(tmp);
        if normtmp>ee
            Um(:,2*iter1-1)=tmp/normtmp;
            Um(:,2*iter1)=Qc2Qa(Um(:,2*iter1-1));
            index=setdiff(index,[iter2]);
            break;
        end
    end
end
Uc=Um(:,1:2:end);
UU=cplx2Q([Uc,Qc2Qa(Uc)]);
normQf(UU'*UU-eye(n/2))
norm(Q2cplx(UU)*Q2cplx(UU)'-U*U','fro')
% end
    