%function U=ModifiedPseudoSVD(A)
A=GenerateLowRankPlusExpDecay(50,40,10,'high');
cpA=Q2cplx(A);
[U,S,V]=svd(cpA,0);
% S=[1,1,1,1,1,1,2,2,2,2,3,3,1e-12,1e-12,2e-13,1e-13,2e-15,1e-15];
S=diag(S);
S1=[S(3:end);0;0];
Diff=S-S1;
badIndex=[];
for iter=1:numel(S)
    if abs(Diff(iter))<1e-13
        badIndex(end+1)=iter;
    end
end
for iter=1:numel(badIndex)-1
    if abs(badIndex(iter+1)-badIndex(iter))>1
        badIndex=[badIndex,badIndex(iter)+1,badIndex(iter)+2];
    end
end
badIndex=sort(badIndex,'ascend');
if badIndex(end)>numel(S)
    badIndex=badIndex(1:end-2);
end
antiIndex=badIndex(2:end);
selectIndex=[];
selectIndex(end+1)=badIndex(1);
Uu=[];
u=U(:,antiIndex(iter2));
        Ju=[conj(u(end/2+1:end));-conj(u(1:end/2))];
for iter1=2:numel(badIndex)/2
    iter1
    for iter2=1:numel(antiIndex)
        iter2
        u=U(:,antiIndex(iter2));
        Ju=[conj(u(end/2+1:end));-conj(u(1:end/2))];
        Uu=[Uu,u,Ju];
        if norm(Ju-U(:,selectIndex)*(U(:,selectIndex)'*Ju))>1e-10
            selectIndex(end+1)=antiIndex(iter2);
            antiIndex(iter2)=[];
            iter2
            break;
        end
    end
end
