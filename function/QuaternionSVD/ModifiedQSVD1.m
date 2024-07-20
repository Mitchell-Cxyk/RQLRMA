function [U,S,V] = ModifiedQSVD1(A,varargin)

p = inputParser;

addParameter(p, 'Precision', 1e-20, @isnumeric);
addParameter(p, 'Rank', min(size(A)), @isnumeric);

parse(p,varargin{:});

rank=p.Results.Rank;
Precision=p.Results.Precision;

% flag='econ';
% rank=-1;
% if ~isempty(varargin)
%     if isnumeric(varargin{1})
%         rank=varargin{1};
%         flag='full';
%     else
%         flag=varargin{1};
%     end
% end
if ~isa(A,'quaternion')
    if isreal(A)
        A=rowReal2Q(A);
    else
        A=rowComplex2Q(A);
    end
end
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
Spre=Sall(1:2:end);
rank=min(rank,n-findThresholdIndex(sort(Spre,'ascend'),Precision));
if rank<n
SsmallIndex=rank*2+1:numel(Sall);
else
    SsmallIndex=[];
end
%SsmallIndex=findSplitIndex(Sall,threshold,'smaller');
if mod(numel(SsmallIndex),2)>1e-10
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
    if ~isempty(IndexOfUpperTriangleBadIndex)
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
end
V=Qc2Q(Vc(:,1:2:end-1));
S=Sall(1:2:end);
Uc=Uall(:,SlargeIndex);
U=Qc2Q(Uc(:,1:2:end-1));
% U=A*V;
% colNorms = sqrt(sum((U.w.^2+U.x.^2+U.y.^2+U.z.^2), 1));
if exist("ModifiIndexCollect")
    if ~isempty(ModifiIndexCollect)
        UM=A*V(:,ModifiIndexCollect);
        colNorms = sqrt(sum((UM.w.^2+UM.x.^2+UM.y.^2+UM.z.^2), 1));
         UM=UM./colNorms;
         S(ModifiIndexCollect)=colNorms;
        % [UM,~]=qMGS1(UM);
        U(:,ModifiIndexCollect)=UM;
    end
end
%condQU=condQ(U)
UhUabs=abs(U'*U);
triUhUabs=triu(UhUabs,1);
sumUhU=sum(triUhUabs,1);
OrthIndex=find(sumUhU>1e-13*size(UhUabs,1));
normUhu=norm(sumUhU);
%normsumUhU=sum(normUhu,1);
if normUhu>1e-10*size(U,2)
    [UOrth,~]=qMGSWithPart(U(:,OrthIndex),U(:,setdiff(1:size(U,2),OrthIndex)));
    UOrth=UOrth(:,size(UOrth,2)-numel(OrthIndex)+1:end);
    U(:,OrthIndex)=UOrth;
end
%S=Sall(1:2:end);
% S=colNorms';
%S=0.5*(S+Sall(1:2:2*numel(S)-1));

S=diag(S(1:size(V,2)));






end