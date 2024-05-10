function [H,S,V] = TruncationStage(H,X,varargin)
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

%%%%%% truncation stage

if size(X,1)>=size(X,2)
[U,S,V]=ModifiedcsvdQ(X);
if r<size(U,2)
H=H*U(:,1:r);
S=S(1:r,1:r);
V=V(:,1:r);
else
    H=H*U;
end
else
    [U,S,V]=ModifiedcsvdQ(X');
    if r<size(U,2)
    H=H*V(:,1:r);
    S=S(1:r,1:r);
    V=U(:,1:r);
    else
        H=H*V;
        S=S;
        V=U;
    end
end
clear X;

end

