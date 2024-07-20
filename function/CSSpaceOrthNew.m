ee=1e-4;
A=GenerateLowRankPlusExpDecay(100,50,1,'low');
AA=Q2cplx(A);
[U,S,V]=svd(AA,'econ');
m=size(U,1);n=size(U,2);
Um=zeros(m,n);
Um(:,1)=U(:,1);
Um(:,2)=Qc2Qa(U(:,1));
index=2:n;
indexSelected=[];
tmpSelected=[];
for iter1=2:n/2
    for iter2=index
        [Q,~]=qr(Um(:,1:2*iter1-2),0);
        tmp=Qc2Qa(U(:,iter2))-Q*(Q'*Qc2Qa(U(:,iter2)));
        normtmp=norm(tmp);
        tmpSelected(end+1)=normtmp;
        if normtmp>ee
            Um(:,2*iter1-1)=tmp;
            Um(:,2*iter1)=Qc2Qa(Um(:,2*iter1-1));
            indexSelected(end+1)=iter2;
            index=setdiff(index,[iter2]);
            break;
        end
    end
end
Uc=Um(:,1:2:end);
UU=cplx2Q([Uc,Qc2Qa(Uc)]);
S=rand(size(UU,2),1)+1;
S=diag(S);
UU=UU*S;
[Uq,Sq,Vq]=csvdQ(UU);

normQf(Uq'*Uq-eye(n/2))
norm(Q2cplx(Uq)*Q2cplx(Uq)'-U*U','fro')
% end