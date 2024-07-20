function [H,S,V] = preconditionedTruncateStage(H,X,varargin)
% truncation stage of the randomized one-pass algorithm for quaternion low rank approximation
% input: range H \in\mathbb Q^{m\times s}, X\in\mathbb Q^{s\times n}. 
% input: varargin{1}: target rank r, default = s

% output: H\in\mathbb Q^{m\times r} (non-)orthonormal;
% output: S\in\mathbb R^{r\times r} real diagonal 
% output: V\in\mathbb Q^{r\times n} orthonormal.


r = size(H,2); 
if ~isempty(varargin) 
    r = varargin{1};
end

Z=X';
u=pseudoSVD2(Z);
sv=u'*Z;
[uu,ss,vv]=R_svdQCQ(sv);
%%%%%% truncation stage
H=H*vv(:,1:r);
S=ss(1:r,1:r);
V=u*uu(:,1:r);


%%%%%% truncation stage
% [U,S,V]=csvdQ(X,r);
% H=H*U;
% clear X;

end

