function [U,S,V] = ModifiedQSVD(A,varargin)
flag='econ';
rank=-1;
if ~isempty(varargin)
    if isnumeric(varargin{1})
        rank=varargin{1};
        flag='full';
    else
        flag=varargin{1};
    end
end
if ~isa(A,'quaternion')
    if isreal(A)
        A=rowReal2Q(A);
    else
        A=rowComplex2Q(A);
    end
end
threshold=1e-18;
% indexList=[];
% transflag=0; %indicate if doing adjoint
% rk=min(size(A,1),size(A,2));
% flag='full'; %default setting is 'full', meaning that the very small singular values will be included
% if ~isempty(varargin)
%     if isnumeric(varargin{1})
%         rk=varargin{1};
%     else
%         flag=varargin{1};
%     end
% end
% if size(A,1)<size(A,2)
%     A=A';
%     transflag=1;
% end
[m,n]=size(A);
[Uall,Sall,Vall]=svd(Q2cplx(A),0);
Sall=diag(Sall);%Intitial Vc Sall
SsmallIndex=findSplitIndex(Sall,threshold,'smaller');
if mod(numel(SsmallIndex),2)>threshold
    SsmallIndex(1)=[];
end

SlargeIndex=setdiff(1:size(Sall,1),SsmallIndex);
Vc=Vall(:,SlargeIndex);
%process large part
Slarger=Sall(SlargeIndex);
Sdiff=abs(Slarger(1:end-1)-Slarger(2:end));
IndexTiny=findSplitIndex(Sdiff,1e-5,'smaller');
IndexSingleInTiny=findNonAdjacentElementsVec(IndexTiny);
SMainsinlgeRootIndex=SlargeIndex(IndexTiny(IndexSingleInTiny));
% USingle=Qc2Q(Uall(:,SMainsinlgeRootIndex));
% VSingle=Qc2Q(Vall(:,SMainsinlgeRootIndex));
% Ssingle=Sall(SMainsinlgeRootIndex);
%mixPartIndex
SmixIndex=setdiff(SlargeIndex,[SMainsinlgeRootIndex,SMainsinlgeRootIndex+1]);
if ~isempty(SmixIndex)
%SmixIndex=SmixIndex(2:2:end);
Vmix=Vall(:,SmixIndex(1:2:end-1));
Vq=Qc2Q(Vmix);
VhV=abs(Vq'*Vq);
[BadIndexRow,BadIndexCol]=find(VhV-eye(size(VhV,1))>1e-10);
IndexOfUpperTriangleBadIndex=findGreaterIndices(BadIndexCol,BadIndexRow);
ModifiIndex=findNodeGroups([BadIndexCol(IndexOfUpperTriangleBadIndex),BadIndexRow(IndexOfUpperTriangleBadIndex)]);
ModifiIndexCollect=[];
for iter=1:numel(ModifiIndex)
    IndexSub=ModifiIndex{iter};
    ModifiIndexCollect=[ModifiIndexCollect,floor(SmixIndex(2*IndexSub-1)+1)/2];
    IndexSubAbs=SmixIndex(2*IndexSub-1);
    Vqin=qMGS1(Vq(:,IndexSub));
    % Aqin=Vq(:,IndexSub).*(1+rand(1,numel(IndexSub))*0.5);
    % [Vqin,~,~]=csvdQ(Aqin);
    Vc(:,IndexSubAbs)=Q2Qc(Vqin);
end
end
V=Qc2Q(Vc(:,1:2:end-1));
S=Sall(1:2:end);
U=A*V;
colNorms = sqrt(sum((U.w.^2+U.x.^2+U.y.^2+U.z.^2), 1));
U(:,ModifiIndexCollect)=U(:,ModifiIndexCollect)./colNorms(ModifiIndexCollect);
x=randq(size(U,2),1);
normy=normQf(U*x);
if normy>1+1e-5
    [U,~]=qMGS1(U);

end
S=colNorms';
%S=0.5*(S+Sall(1:2:2*numel(S)-1));
if strcmp(flag,'full')

%process small part
[Vsmall,~,~]=csvdQ(Qc2Q(Vall(:,SsmallIndex(1:2:end-1))));
[Usmall,~,~]=csvdQ(Qc2Q(Uall(:,SsmallIndex(1:2:end-1))));
% Urest=QLEQ(U',zerosq(size(U,2),n-size(U,2)));
% Usmall=pseudoSVD2(Urest);
% Vrest=QLEQ(V',zerosq(size(V,2),n-size(V,2)));
% Vsmall=pseudoSVD2(Vrest);
% Usmall=Usmall(:,1:n-size(U,2));
% Vsmall=Vsmall(:,1:n-size(V,2));
V=[V,Vsmall];
U=[U,Usmall];
S=[S;Sall(2*numel(S)+1:2:end)];
S=diag(S);
else
    S=diag(S(1:size(V,2)));
end






end