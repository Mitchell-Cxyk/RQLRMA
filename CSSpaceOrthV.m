function indexSelected=CSSpaceOrthV(V)
ee=1e-2;
% A=GenerateLowRankPlusExpDecay(100,50,1,'low');
% AA=Q2cplx(A);
% [Uo,So,Vo]=svd(AA,0);
% V=Vo;
U=V;
m=size(U,1);n=size(U,2);
Um=zeros(m,n);
Um(:,1)=U(:,1);
Um(:,2)=Qc2Qa(U(:,1));
index=2:n;
indexSelected=[];
% tmpSelected=[];
for iter1=2:n/2
    [Q,~]=qr(Um(:,1:2*iter1-2),0);
    for iter2=index
        
        tmp=Qc2Qa(U(:,iter2))-Q*(Q'*Qc2Qa(U(:,iter2)));
        normtmp=norm(tmp);
        index=setdiff(index,[iter2]);
        % tmpSelected(end+1)=normtmp;
        if normtmp>ee
            Um(:,2*iter1-1)=tmp;
            Um(:,2*iter1)=Qc2Qa(Um(:,2*iter1-1));
            indexSelected(end+1)=iter2;
            
            break;
        end
    end
end

indexSelected=[1,indexSelected];
% Ucu=Uo(:,indexSelected);
% 
% 
% 
% % Uc=Um(:,1:2:end);
% UU=cplx2Q([Ucu,Qc2Qa(Ucu)]);
% S=rand(size(UU,2),1)+1;
% UU=UU.*S';
% [Uq,~,~]=csvdQ(UU);

% normQf(Uq'*Uq-eye(size(Uq,2)))
% norm(Q2cplx(Uq)*Q2cplx(Uq)'-Uo*Uo','fro')
 end